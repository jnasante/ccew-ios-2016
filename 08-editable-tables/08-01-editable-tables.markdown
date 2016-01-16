Editable Tables
====================================

An editable table view is one in which you can add and remove rows from the interface, and which reflects those interactions in the underlying data model. Editing is largely accomplished by implementing certain delegate methods. The table view will inform the delegate when an edit event occurs such as removing a row and the delegate, typically a view controller, will take the appropriate response.

Editing also includes actions that aren't initiated from the table view such as adding a row.

For this lesson we’ll work our way through those the required delegate and other controller methods until we have a fully editable table view that supports both the addition of new rows and the removal of existing rows.

We'll also begin to address the four operations that are required to manage data, summarized by the CRUD acronym: Create, Retrieve, Update and Delete. In class we'll use a basic data model that's nothing more than an array of simple values, but for the homework assignment you'll create a more realistic data model with custom classes representing some real world objects.

## Setting Up

We'll start with a single view application again and build up the table view mostly from scratch. This will give us a chance to review table building.

**Custom classes and interface**

Create a new single view iOS project.

First, delete the provided controller class, both the header and implementation file. Select the files in the Project Navigator and press the delete button. You want to *Move to Trash*. The other option *Remove References* removes them from the project but doesn't actually delete the files.

Next we should modify the storyboard. Delete the existing interface. Just select the entire view controlelr and press delete.

Drag in a new navigation view controller. We're building a table view application and table views will almost always appear inside navigation views.

We'd like to use a custom subclass for the table view controller so create a new objective-c object for the project. Make sure you subclass `UITableViewController`.

Back in the storyboard, set the class on the table view controller to your custom subclass in the Identity Inspector (`CCTableViewController` for me).

Still in the storyboard, set the `delegate` and `dataSource` for the table view by control-dragging from the table view itself to the table view controller box icon.

Finally, let's use the provided prototype table view cell for now. We'll still need to set the Identifier on it so that we can refer to it from code. Select the prototype cell and in its Attributes Inspector set the Identifier to "Cell".

**Template code**

We're now ready to implement our table view controller subclass. Fortunately Xcode provides quite a bit of template code when we start with `UITableViewController`. Let's make sure we've got our basic data source methods working first and then we'll implement a very basic data model.

First let's modify the header file so that we explitily mark our controller as conforming to the `UITableViewDelegate` and `UITableViewDataSource` protocols:

```objective-c
@interface CCTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@end
```

Looking through the implementation file we see that two of the data source methods are already here. Delete the warning lines but otherwise leave them as is:

```objective-c
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}
```

The required cell method is commented out. Uncomment it. For the `dequeue` method use the "Cell" string we specified earlier in the interface for the reuseIdentifier. That should do:

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
```

Run the application in the simulator to make sure you're not crashing.

## Basic Data Model

Our data model will consist of an array of strings. For your homework assignment you'll use an array of objects with properties that model some kind of real world object, but for now this will suffice.

We'll be implementing our model a little differently than Xcode's master-detail application template does.

First let's add a property to the view controller that will store the array of strings. At the top of the implementation file you'll see that strange bit of syntax we looked at earlier:

```objective-c
@interface CCTableViewController ()

@end
```

This is a class extension, or *category*, identified by the appearance of parenthesis `()` after the `@interface` declaration. Categories allow us to extend the functionality of existing objects in the runtime. With cateogires we can add methods to other classes just like we add methods to our own subclasses.

Moreover this is the "private" clas extension because no identifier appears inside the parenthesis. Normally you name a class extension with a word or phrase inside the parenthesis. With private class extensions, which are supported only for your own custom classes, you can also add properties to the class that are hidden from other developers because they don't appear in the header file.

Now, objective-c doesn't actually support a distinction between private and public data in the runtime but we can mark it in the code as a message to ourselves and other developers.

Let's add an array property to the category. Notably this will not be a mutable array property even though we'll be making changes to it as items are added to the table:

```objective-c
@interface CCTableViewController ()

@property (strong, nonatomic) NSArray *items;

@end
```

We'll modify our data source methods to refer to this variable, so we should initialize it. Property object values are `nil` by default, so let's initialize it to some array in the `viewDidLoad` method.

You might use an empty array here but we'll go ahead and populate the model with a few string values:

```objective-c
- (void)viewDidLoad
{
	[super viewDidLoad];
  
	self.items = @[ @"Mark", @"Vanessa", @"James", @"Bart", @"Cathy" ];
	// ...
}
```

Now we'll just refer to this property in our data source methods. Modify them so that you're pulling counts and values from the property:

```objective-c
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = self.items[indexPath.row];
  
    return cell;
}
```

Run the application again to confirm that you changes to the data model and to the data source methods are working.

## The Detail View

For kicks let's add a detail view in the storyboard so that something happens when we select a row in the table. We won't worry about actually implementing anything in the code though.

In the storyboard drag in a new view controller to the right of the table view.

Control-drag from the prototype table view cell to the new view and choose the *push* Selection Segue.

Run the application and confirm that the detail segue is working. That'll work for now.

## Adding Items

Let's build support for adding items to the table view. For the interface we'll add a bar button item to the top right of the navigation bar. In the code we'll modify our `items` property and also see how to dynamically modify the table view interface so that a complete refresh is not necessary.

We'll start by templating out and `addItem` `IBAction` to our header and implementation file that will be the target for the add button:

**Header file:**

```objective-c
- (IBAction)addItem:(id)sender;
```

**Implementation file:**

```objective-c
- (IBAction)addItem:(id)sender
{
  // implement
}
```

**Storyboard**

In the storyboard drag a Bar Button Item from the Object Library to the top right of the navigation bar in the table view. Select it and in the Attributes Inspector set it's Identifier to Add.

Interface:

![](https://s3.amazonaws.com/okcoders/ios/images/08-01-01-add-button.png)

Identifier:

![](https://s3.amazonaws.com/okcoders/ios/images/08-01-02-add-identifier.png)

Control-drag from the item to the view controller icon to connect the action to `addItem:`

**Basic Addition**

We now just need to implement the method to actually modify the items array and refresh the table view. We'll start with modifying the array and then we'll refresh the table view, which will force it to call its data source methods again and see that the `items` array has been changed.

We have a normal array, one that isn't mutable, so to add an item to it we'll need to make a mutable copy of it, push the new item onto it, and set the property again. Modify the `addItem:` method:

```objective-c
- (IBAction)addItem:(id)sender
{
  NSMutableArray *mutableItems = [self.items mutableCopy];
  [mutableItems addObject:@"New Item"];
  self.items = mutableItems;
}
```

We can then call the `reloadData` method on the table. A table view controller automatically keeps a reference to its table view through a `tableView` property, so we can just access that and call `reloadData`:

```objective-c
- (IBAction)addItem:(id)sender
{
  NSMutableArray *mutableItems = [self.items mutableCopy];
  [mutableItems addObject:@"New Item"];
  self.items = mutableItems;
  
  [self.tableView reloadData];
}
```

Basic implementation is that simple. Let's examine a couple improvements.

**Key-Value Coding**

Objective-c supports an advanced way of accessing object properties and seeing changes to object properties called *key-value coding* and *key-value observing*. We'll only touch on it here.

The first two methods to be familiar with are:

```objective-c
- (id)valueForKey:(NSString *)key
- (void)setValue:(id)value forKey:(NSString *)key
```

Key-value coding allows us to access and set properties on an object dynamically. These two methods work like getters and setters, but rather than harcoding the property name with an identifier we can use a string instead. We'll always call these methods on the object *whose property we want to modify*.

For example, we could get the `items` array from our view controller like:

```objective-c
NSArray *items = [self valueForKey:@"items"];
```

Similarly we could set the items array:

```objective-c
NSArray *array = @[ @"some items ...", @"..." ];
[self setValue:array forKeyPath:@"items"];
```

Just like using getters and setters.

The problem we want to solve with key-value coding is array modification. We have three lines of code simply to add a new item to an immutable array property. Any time we want to modify any array property anywhere, we have to type out those three lines. That repetition should suggest that a method which encapsulates this behavior is necessary.

The approach uses a proxy object which represents the original property *by name*, or *by key*, in a modifable form which will automatically make changes to the original object. That is, we'll create a proxy for the `items` property that is mutable and change it. The change will automatically be propogated back to the original `items`. Modify `addItem:`:

```objective-c
- (IBAction)addItem:(id)sender
{
  [[self mutableArrayValueForKey:@"items"] addObject:@"New Item"];
  [self.tableView reloadData];
}
```

This is pretty magical. The method `mutableArrayValueForKey:` generates the proxy array for us based on the name of the property we want, namely `@"items"`. It's like calling `valueForKey:` for `@"items"` but instead of getting the object itself back we get a mutable proxy back. Notice that we call this method on `self`.

The object this method returns behaves like a mutable array with mutable array methods, so we can call `addObject:` on it. But it is a proxy for `items`, so it actually makes the change to the underlying array, continuing to access it by it's name, `@"items"`.

**Dynamica table view changes**

Right now we're refreshing the entire table view after making a change to a single row on it. Calling `reloadData` forces the table view to hit the data source for new cells even when the other visible cells haven't changed. That's inefficient. It's also jarring. The new row suddenly appears. What if we could only generate the cell we need and have it appear with a smooth animation?

It turns out that `UITableView` provides an API that does just that. The method is `insertRowsAtIndexPaths:withRowAnimation:`. It takes an array of `NSIndexPath` objects, which encapsulate information about a row and section and which are used in other data source methods, and then an animation style. We still need to modify the data model, that is our `items` array first, but then we can call this method instead of `reloadTable`.

For this approach we should first build the single index path we want to change. We supply a row, which will be the last index of the `items` array (or its count minus one), and then the section, which will just be the first one or index zero. We'll then provide that index path to the table view method nd use the default row animation. Here's the new version of the `addItem:` method

```objective-c
- (IBAction)addItem:(id)sender
{
  [[self mutableArrayValueForKey:@"items"] addObject:@"New Item"];
  
  NSIndexPath *path = [NSIndexPath indexPathForRow:[self.items count]-1 inSection:0];
  [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
}
```

Run the application again and add a new item. It now animates in from the bottom, but more importantly the data source method for generating cells will only be called once for the new row.

## Deleting Items

We'll take the same approach to deleting items from the table. First we'll set up an edit button in the navigation for for making the table view editable and implement support for edit to delete functionality. Then we'll also enable swipe to delete, which is a common interface pattern for deleting items from a list.

But rather than implementing delete directly we'll implement table view delegate methods that inform us when user interaction indicates a row is being deleted.

**Edit item**

For the edit item we actually won't need to create any new interface. Every view controller has access to a native edit button by way of an API, and for a table view controller it will call the appropriate, built-in editing-abled method on it. Moreover the line of code we need is already in our controller, just commented out. 

In the `viewDidLoad` method, uncomment the last line and modify it so that the button is assigned to the left bar button item:

```objective-c
- (void)viewDidLoad
{
    // ...
  
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
```

Run the application and click the edit button. For free we get the entire edit interface. Try to delete an item. Click the red circle and then click delete. Ok, well we get the entire interface but we need to actually implement the delete code. For this we turn to our delegate methods.

Nicely, it turns out that the delegate method we need is already templated in and commented out. Uncomment the `tableView:commitEditingStyle:...` method:

```objective-c
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
```

Notice that we are using a deletion method that is similar to the insertion method. We provide an array of index paths, which the table view provides in the delegate callback, and then use a row animation style.

Run the application again and try deleting a row one more time. The application crashes.

What's happened is that we have not modified the underlying data model even though we have updated the table view. The table view keeps an internal cache representation of the number of rows in a table, and after deleting a row from the table view, it calls its data source methods for the number of rows and sees that the internal number does not match the data source number and raises and internal inconsistency exception.

To fix this we need to actually modify the data model, naturally. We'll use our key-value method again to remove an object at an index path. Add the following line before the call to `deleteRows...`:

```objective-c
[[self mutableArrayValueForKey:@"items"] removeObjectAtIndex:indexPath.row];
```

Run the application again. Now we're good.

You'll see this internal inconsistency exception again in your future iOS work. Just remember that you must keep your data model consistent with the interface, and this exception usually means you haven't updated your model.

**Conditional delete**

Nicely, we also get conditional swipe-to-delete for free. Run the application and swipe left on a row to bring up the delete interface. Hit delete and the delegate method is called to execute it.
