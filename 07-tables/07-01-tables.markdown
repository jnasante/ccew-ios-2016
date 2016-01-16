Table Views and Table Controllers
=================================

Table views (class: `UITableView`) are the workhorse of the iOS interface. They are everywhere on an iPhone and used in many places on iPads. They can be used to present large lists of data efficiently or to structure smaller amounts of information. Almost any time you need to create a vertically scrollable view, you’ll use a table view instead of writing your own custom view.

Perhaps more importantly table views epitomize the *delegate* pattern we've been introduced to. Table views are highly customizable and all of their cutomization comes through the use of a delegate. Table views use a similar *datasource* pattern which allows the table to request data from another object as it needs it. Consequently you will rarely need to subclass `UITableView`. 

Table views also introduce us to another design pattern known as the *flyweight*, which allows a single copy of an object to be re-used many times. We'll discover that table rows are built from a another class, the `UITableViewCell`, and that only a dozen cells or so are needed to represent all of the data in a table, even if it has hundreds or thousands of rows. We'll also see that most customization is accomplished through one of a set of default `UITableViewCell` styles or through custom subclasses.

Competent programming for the iOS requires a solid understanding of table views. We’ll spend the next few lessons laying the ground work and then we'll learn how to persist the data a user might add to a table so your application can display it again later. We'll also learn how table views make heavy use of the navigation interface.

## Important Classes

The relevant classes and protocols are:

`UITableView`:

Main tableview classes. Has a delegate and datasource property

`UITableViewDataSource`:

Protocol that defines the methods another class implements to provide data to a tableview


`UITableViewDelegate`:

Protocol that defines the methods another class implements to customize the appearance of a tableview

`UITableViewCell`: 

Base class for each row that appears in a table, contains image views, labels and other layout for a data cell.

Refer to these classes in the documentation.

## Table View Data Sources

In general you won’t subclass a table view. So how does your table view get the data it needs to display, and how can your application respond to user interaction with the table? UITableView relies heavily on delegates, data sources and automatic push segues.

We know what delegates are. A data source is a lot like a delegate, except that delegate methods are often used to inform another class of changes to the source object in response to user action, while data source methods are used to provide the source object with information it needs prior to user action. Putting a table view up on the screen is simple enough, but it won’t do anything, without the required delegate and data source methods. 

Let’s try it:

Create a new single view application. Add a table to the main view controller from the object library (not a table view controller). Run the app: shows the table view but nothing in it.

**Storyboard Connections**

Hook up the table view’s data source and delegate outlets to our File’s Owner. As you might suspect the `delegate` and `dataSource` are IBOutlet properties on `UITableView`, which means we control-drag from the table view to the object that is acting as the delegate or datasource.

Now let's add a `tableView` IBOutlet to our view controller so we can refer to the table view from code. This time control-drag from the view controller to the table view.

Run the applictation again. It crashes. What’s happening? It turns out that the table view data source methods are required. Because they are marked as required, the table view doesn’t check to see if the delegate actually implements them. It just calls them. That is part of the contract of conforming to the data source protocol, which we haven’t. Let’s do that and implement our missing methods. 

**Protocol conformance**

First, wow do we indicate our class conforms to a protocol? We put the protocol names in greater than and less than signs after the interface declaration for the class:

```objective-c
@interface CCViewController : UIViewController <UITableViewDataSource, UITabBarDelegate>
@end
```

Comma separate the protocol names to add more than one.

**Implement the data source**

Now we need to implement required methods. For the data source two methods are required. The first returns the number of rows in a section. Table views are organized by section. By default a table view assumes there is one section, but then it needs to know how many rows are in a given section, or the first at a minimum. Add the following to the implementation file:

```objective-c
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}
```

The second required method generates a cell for the given row. We'll return `nil` for now but normally we'd return an instance of `UITableViewCell`:

```objective-c
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}
```

Recall that a cell is responsible for displaying the contents of the row. This method creates the cell or re-uses one that already exists and then customizes its appearance based on the underlying data being represented.

This way the table view never has hold of the actual data it is displaying, only the controller, which passes bits of information to the cell for it to display. This way of displaying data epitomized the Model-View-Controller pattern. Model data is managed by a model object. The controller will fetch that data as needed and provided only what is necessary to the table view by way of a table view cell, which then renders it.

Run the application. It may not display any data but it no longer crashes.

Let's fake a single row of data. Return `1` for the first delegate method:

```objective-c
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}
```

And for the second let's generate a really simple cell with a text label:

```objective-c
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  cell.textLabel.text = @"Table view cell";
  return cell;
}
```

Run the app. We now have a minimum of interactivity. You can scroll and you can click the table view, and we have a single cell. But how exactly is the cell working and working in conjuction with the data source methods?

## Table View Cells

The table view does not maintain an internal copy of the data it displays. It is only responsible for presenting that data. When the table view appears on the screen the first time, or anytime you call the table view method `reloadData`, the table view asks its data source for the number of sections and rows it will be displaying. We’ve only specified the number of rows; there is one section by default.

Then, for every row that is currently visible on the screen, the table view also asks its data source for the cell that will be displaying the data for that row and gives the data source a chance to set up the appearance of that cell. In our case we’re just setting a text label on it.

A table view cell (class `UITableViewCell`) is a small subclass of `UIView` that displays whatever data you want. The built-in table view cell can show a text label and a detail text label, like a subtitle, and can also display what’s known as an accessory view, such as a checkmark or arrow indicator. Custom `UITableViewCell` subclasses can do quite a bit more, but let’s stick with the built-in cell for now

**Cell styles**

The built-in table view cell supports four types, which display the main text and detail text differently. We specify the type when we create the cell. Let’s modify our code so that’s the case. We'll initialize the cell with a style and re-use identifier. More on the that in a moment. Let's also modify the cell so that it display the row number:

```objective-c
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
  cell.textLabel.text = [@"Table view cell" stringByAppendingFormat:@" %d", indexPath.row];
  return cell;
}
```

Now return `20` rows from the other method so we can really see the effect:

```objective-c
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 20;
}
```

Run the appliction. In the simulator I can scroll the table by clicking on it with the mouse (trackpad), holding it and scrolling.

Let's try a different table view cell. Change the cell type to `UITableViewCellStyleValue1` and add detail text via the `detailTextLabel` property:

```objective-c
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
  cell.textLabel.text = [@"Table view cell" stringByAppendingFormat:@" %d", indexPath.row];
  cell.detailTextLabel.text = @"Details";
  return cell;
}
```

**Reusing table view cells**

I mentioned that the table view only asks the data source for cells that are visible on the screen. What exactly does that mean? Add a call to the log in the cellForRow method and log the row currently being requested:

```objective-c
NSLog(@"row %d",indexPath.row);
```

Run the app and watch the console. The table view has only requested cells for the visible rows. Scroll the table and watch the console. As rows become visible the table view requests cells for them. Now scroll back. The table view requests cells for rows it has already displayed! What gives?

In order to optimize its memory footprint, a table view forgets (relinquishes the memory for) any row it is not currently displaying. When that row is about to become visible again, the table view asks the data source once more for its cell.

Our code is not making the most of this optimization. We are creating a new cell every time we want to display a row. Every time a row becomes visible, we ask the system to re-allocate memory for that table view cell. This takes time and can visibly slow down scrolling with large and complex enough data sets.

Do we really need to re-allocate memory that that the table view has just freed: as one row falls off the screen, the memory for that cell is freed, and then we just immediately allocate the same amount of memory again for the next cell being displayed. This is inefficient. What if instead we could re-use the cell that is falling off the screen?

We do can do just that. It's called *dequeuing* a re-usable cell from the table view, and it uses the identifier for that cell. Let’s modify our code to take advantage of this queue of available cells. `UITableView` provides a method for dequing cells:

```objective-c
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    NSLog(@"row %d",indexPath.row);
  }
  
  cell.textLabel.text = [@"Table view cell" stringByAppendingFormat:@" %d", indexPath.row];
  cell.detailTextLabel.text = @"Details";
  return cell;
}
```

The method now first tries to deque a cell. Only if that fails does it then go on to create a new one. Notice that we've moved the call to `NSLog` inside the if statement, so we'll only see when a new cell is created. Run the app, scroll around, and see when logging takes place.

Now, whenever the table view needs to display a new row, our data source asks the table view if it has any cells available that it is no longer using. The table view keeps the last few around momentarily in a queue that we can tap. If it has any, we take it from the queue and skip ahead to setting up how that cell will look. If it doesn’t, and only then, we create a new cell. The result is memory efficient code and fast scrolling.

This is the paradigmatic way to create cells for a table view. Ask the table view if it has any cells available that it is about to free, use those if we can, and if we can’t, create a new cell. In either case, set up the appearance of the cell afterwards and return it.

## Table View Delegate

Note what happens when we select a cell. The table view highlights it for us, and nothing else. Our app needs a way to respond to that selection, usually to show more information about it. For this, we use the table view delegate. Let’s go ahead and implement a minimal delegate which knows a row has been selected.

First we should conform to the `UITableViewDelegate` protocol:

```objective-c
@interface CCViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@end

```

Then we'll implement the table view delegate method that's called when a user selects a row. At a minimum our application should follow the established interface guidelines and deselect the row:

```objective-c
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSLog(@"%d",indexPath.row);
}
```

There are many more delegate methods for a table view. Generally they are called whenever one of a number of table view events occurs. We'll learn about others in our next chapter. In the meantime refer to the `UITableViewDelegate` documentation.

## Table Views with Storyboards

In practice this is not how we'll create table views and cells and respond to table view actions. I wanted to build a table view up from scratch so we can see the principles involved. Normally, however, we will use storyboards. The same principles are at work; we still need a datasource and we may make use of delegates. But cell customization and handling selections becomes much simpler.

Xcode provides a template for creating a table view based application. It is the master-detail template we already looked at for navigation based applications.

Create a new master-detail application for the iPhone. Let's tease apart what the template provides us.

**Class overview**

We already know that we'll have two classes, a master view controller and a detail view controller.

In this case the master controller is a subclass of `UITableViewController` instead of `UIViewController.` `UITableViewController` is a convenience view controller paired with table view interfaces that handles some of the table view interaction automatically. You should always prefer a subclass of `UITableViewController` over one of `UIViewController` when adding tables to your application.

Our detail controller is just a normal view controller that will display some piece of information about the row selected in the master controller. We could of course have another table view here that leads to another detail view. Remember that navigation based interface support as many layers of detail as you need.

**The storyboard**

Examine the interface file. We have a navigation controller set up which we should be comfortable with. Our entry point to the interface is a `UINavigationController` whose root view controller is our master view controller, which, remember, is a subclass of `UITableViewController`.

But the interface for this controller is different. We can see that there is a `UITableViewCell` already associated with the table view. We can examine the Identity and Attributes inspector to see the details about this cell. Importantly, the Cell Identifier in the Attributes inspector is set to *"Cell"*.

It turns out that we can build our table view cell complete in the storyboard rather than having to contruct it from code.

Look at the table view itself as well. Control-click it and you'll see that the dataSource and delegate are set to the master view controller object.

Next we see a segue. Select it. The segue is *from the cell to the detail view*. This is a *Push* segue that activates when the user selects a row in the table view. Convenient. It turns out that the table view controller will also handle the cell selection for us, keeping the cell selected when the detail controller is pushed onto the stack but deselected it when the user backs up to the master controller.

The detail view itself just contains a label that will be set when the user selects a cell. How?

**The table view controller**

Our master table view controller subclass is doing most of the heavy lifting in this application. Examine that file. First note this bit of code:

```objective-c
@interface CCMasterViewController () {
    NSMutableArray *_objects;
}
@end
```

This is how we create a category in objective-c. A category is an extension to a class that changes the class in the runtime. The empty parenthesis `()` mean this is a private extention that allows us to add instance variables to the class.

Let's not worry about what all this means right now. The important point is that our class is maintaining a mutable array of objects that will be used as the data model for the items displayed in the table.

We'll learn about making a table editable in the next chapter and we will do it differently.

The `viewDidLoad` method in the class sets up a navigation bar button for adding new items to the table. It's action, that is, the method it targets on `self`, is `insertNewObject:`. We could have easily set this button up in the storyboard.

`insertNewObject` itself adds a new item to the data model and inserts it into the table. We'll discuss this more in the next lesson.

We now see methods we should recognize. The first data source method indicates that the table view has only one section, and the next data source method returns the number of objects in the data model, as we might expect. 

The third data source method is, however, interesting:

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

  NSDate *object = _objects[indexPath.row];
  cell.textLabel.text = [object description];
  return cell;
}
```

This method has been implemented differently than how we did it in our application from scratch. First, a different method is used to deque a cell from the table view:

```objective-c
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
```

The method requires the index path as well. This particular method is used when we set up a table view in a story board and include the cells on the table in the storyboard. Notice that the identifier `@"Cell"` is the same one used on the cell in the storyboard.

Next, notice that we don't have to check if the returned cell is `nil` and create a new one if it is. The `dequeueReusableCellWithIdentifier:forIndexPath:` method handles all this for us! All we need to do is pass information from the model to the cell, setting its text label.

The following two methods deal with editing, which we'll learn about in the next lesson.

The final method is immediately important, however. We should recoginze it from earlier lessons, `prepareForSegue:sender:`. For the table view controller, preparing for the segue means identifying which row was selected, accessing the data model object represented by that row, and passing information to the detail view controller (`destinationViewController`) so that it can display it.

**The detail controller**

The detail controller is simply responsible for setting the text value of the label output. It moves the code that actually access the `IBOutlet` to a separate method that is called from both `viewDidLoad` and `setDetailItem:`.

Why whould it do this?

## Custom Table View Cells

Often we will want to create custom table view cells rather than use variations on the system provided one. This is straightforward in storyboard. We can add and remove table view cells to the table view in storyboard, assign our custom class to the cell and set up outlets on the custom class, connecting them to the cell's interface in storyboard.

Let's use a custom cell in our application. We'll start with the class. Create a new class for you project called `CCCustomTableViewCell` (or whatever prefix you use) and make it a subclass of `UITableViewCell`. Add two text label properties to it:

```objective-c
@interface CCCustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
```

In the storyboard select the prototype cell in the table view and delete it. Find the table view cell object in the object library and drag it onto the table view. You have a new prototype cell object.

Set its *Indentifier* in the Attributes inspector to "CustomCell". Next set its Class in the Identity inspector to "CCCustomTableViewCell" or whatever you class name is.

We can now add interface elements onto the cell as if it were any other view. First expand the size of the cell by dragging down on its bottom edge then add a couple of labels for a name and phone number. Make the font size for the phone number a little smaller in its Attribute inspector.

Connecting the outlets to the cell is a little more difficult. We have to go in the opposite direction to what we're used to. Select the first label and choose the Connections inspector. Drag from the Referencing Outlet circle to the cell. Establish both connections in turn: 

![](https://s3.amazonaws.com/okcoders/ios/images/07-01-01-connections.png)

I'm not sure why this is necessary, but I believe it is a bug in Xcode.

Now in the maste view controller implementation file we should modify the data source method that is responsible for dequing the cell and setting it up. First let's import our cell's header file at the top:

```objective-c
#import "CCCustomTableViewCell.h"

...
```

Modify the data source method so that it deques a cell whose identifier is "Custom" and then set the `nameLabel` and `phoneLabel` values. Make sure you're using your custom class instead of the `UITableViewCell` class:

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CCCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Custom" forIndexPath:indexPath];

  cell.nameLabel.text = @"Name Test";
  cell.phoneLabel.text = @"555-1234";
  return cell;
}
```

Run the application and create a couple new rows. Oh no! We get the data but our cell size is wrong even though we've set it up correctly in the storyboard.

Unfortunately because of legacy implementation patterns we need to implement a delegate method that specifies the row height. Add the following method to the implementation file:

```objective-c
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 77;
}
```

You'll need to get the right height for your cell. Select the cell in the storyboard file and in the Size inspector look at the row height:

![](https://s3.amazonaws.com/okcoders/ios/images/07-01-02-rowheight.png)

Run the application again. The row heights are now correct!

## Summary

Table views are the workhouse of the iOS interface. They embody many of the design patterns that are core to objective-c and iOS development such as Model-View-Controller (MVC), the use of delegates and data sources, and the flyweight pattern. With custom table cells and static cells (which we did not learn about in this chapter) an almost endless variety of interfaces is possible. Moreover an understanding of table views establishes a solid foundation for working with collection views, which you will have practice with in your homework.
