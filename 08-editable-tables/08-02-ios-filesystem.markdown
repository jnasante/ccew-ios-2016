Introduction to the iOS Filesystem
=================================

In the next chapter we'll look at using sqlite and modeling our data with a real database. In preparation for that chapter we should familiarize ourselves with the iOS filesystem.

## The Sandbox

Most importantly, the iOS Sandboxes every application. This means that every application runs in its own protected memory and file system environment and cannot access the memory or file system space of other applications except through well defined APIs provided by the iOS.

When an application is first loaded onto an iPhone, a data directory is created for it. This is the application’s personal workspace on the file system, or sandbox. Any data the application persists is automatically stored in this isolated space. If the user deletes the application at some point in the future, all the data associated with the application is deleted as well.

## The Application Bundle

It is also important to know that the application is itself protected from modification.  An application is actually just a directory with a number of files in it: compiled code, resources, storyboard files and so on. Although a running application has read access to this data, it does not have write access. An application cannot modify itself.

Read access is nevertheless significant. We can store resources in the application bundle such as a database file or other data files and access them through system APIs. We'll see that adding a *resource* to an application bundle is as simple as adding a file to our Xcode project.

The sandbox and application bundle are often used in conjunction. The application bundel may contain a default database with a few populated elements. Ultimately the user will need to modify that database, so when the application first launches it copies the database from its bundle to the sandboxed filesystem. Changes are then made to the database in the sandbox.

## Using the Application Bundle

Let's modify the table application we've begun to load an array of strings from the application bundle instead harcoding an empty array into the view controller. We'll load the strings from an xml like file that's easy to create and modify in Xcode.

Add a new file to your project. This time choose *Property List* from the *iOS Resource* section and explicitly select it from the Project Navigator. Click it again to rename it. Name it "DefaultValues.plist".

A property list is a serialized representation of a `NSDictionary` or `NSArray`. There is a root object that represents one or the other and then content in the object. Let's change the root object *Type* to `NSArray`:

![](https://s3.amazonaws.com/okcoders/ios/images/08-02-01-plist-type.png)

Then select that row can click the plus button to add new items to the array. The type should be *String* by default, which is what we want, so you'll just need to double click in the *Value* cell to set the strings. Type in the same strings used when we hardcoded the array:

![](https://s3.amazonaws.com/okcoders/ios/images/08-02-02-plist-strings.png)

**NSBundle**

By default the property list is added to the application bundle. We can access it with methods on the `NSBundle` class. See the documentation for a detailed description of this class. Its primary purpose is to provide access to resources in an application bundle.

Accessing those resources is a two step process. First we should identify the bundle we want to access. We'll be using our own bundle, or the *main bundle*. Second we should identify the resource we want by name and extension, or type. The API will give us back an `NSString` path identifying the location of that resource on the filesystem.

Modify the table view controller's `viewDidLoad` method:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DefaultValues" ofType:@"plist"];
  
    self.items = @[ @"Mark", @"Vanessa", @"James", @"Bart", @"Cathy" ];
  
  	// ...
}
```

`NSArray` then provides a class method for initializing an array from a propertly list file at a given path. It returns an instance of `NSArray` which we can set directly to `self.items`:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DefaultValues" ofType:@"plist"];
    self.items = [NSArray arrayWithContentsOfFile:path];
    
    // ...
}
```

And that's it. You're now accessing resources within the application's bundle. Moreover you can modify the propertly list and when your application is recompiled the changes will be incorporated into the new bundle.

## Using the Sandbox

Let's use the application's sandbox to store a copy of the default plist resource. We'll then use that resource to read the table values and write to it when the user makes changes to the table.

To copy a file from the bundle to the sandbox we'll need a destination path. We already know how to get the source path. Then we'll need to actually make the copy.

**File paths**

The system provides a few APIs for getting sandbox filepaths. The one we're interested in is the function `NSSearchPathForDirectoriesInDomains`. We'll provide a couple of values from enumerated constants to *restrict* the search domain to the user (or application) space and to the *documents* directory, which is where an application normally stores its data.

Where do we want this code? Code that copies over resources is application level code that doesn't really belong in a view controller. We'll put it in the application delegate instead, and this will be the first time we modify that file.

Modify the `application:didFinishLaunchingWithOptions` callback to include the following:

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  
    // Override point for customization after application launch.
    return YES;
}
```

We're just using the system API to get a path to the application's documents directory. See the documentation for other directories you might want access to.

Next we should create the complete path for the destination. Let's just append the file name to the document directory path, but we'll do so with `NSString` APIs:

```objective-c
NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
NSString *destinationPath = [documentsPath stringByAppendingPathComponent:@"DefaultValues.plist"];
```

Let's go ahead and add the method for getting the source path for the resource we want to copy:

```objective-c
NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
NSString *destinationPath = [documentsPath stringByAppendingPathComponent:@"DefaultValues.plist"];
NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"DefaultValues" ofType:@"plist"];
```

**NSFileManager**

Now that we have all the paths we need we actually have to make the copy. For that we'll use the `NSFileManager` class, a fairly low level class for directly manipulating the file system. It includes a number of methods for creating files and directories in the application sanbox. Add the following to the method:

```objective-c
NSFileManager *fm = [[NSFileManager alloc] init];
NSError *error;
BOOL success;
  
success = [fm copyItemAtPath:sourcePath toPath:destinationPath error:&error];
```

We create the file manager, prepare error and success variables and then call the requisite method. `copyItemAtPath:destinationPath` returns `YES` if the operation succeeds, `NO` otherwise, and sets `NSError` if something goes wrong. Notice that we pass the error by reference, which means we're passing the address to the pointer and not the pointer itself.

We should immediately check the value of success and if it is `NO` at the least log the error message. I also like to log a message if we are successful as this is initial application setup code and should only be run once:

```objective-c
if (!success) {
  NSLog(@"Problem copying file from %@ to %@, error: %@", sourcePath, destinationPath, error);
} else {
  NSLog(@"Copied default values resource to documents directory");
}
```

Run the application and see if it works. You should get a success message logged to the console.

Unfortunately, if we run the application again the file will be copied again, and this isn't what we want. Ultimately we want user changes to the table to be saved to this file, and if we overwrite it the user's changes will be lost. We should check if the file already exists, and if it does, skip the copy. `NSFileManager` provides a method for us. Wrap the copy and log code in a conditional check for the file's existence:

```objective-c
if ( ![fm fileExistsAtPath:destinationPath] ) { 
	// copy file
}
```

Great. The entire method should now look like:

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *destinationPath = [documentsPath stringByAppendingPathComponent:@"DefaultValues.plist"];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"DefaultValues" ofType:@"plist"];
  
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSError *error;
    BOOL success;
  
    if (![fm fileExistsAtPath:destinationPath]) {
      success = [fm copyItemAtPath:sourcePath toPath:destinationPath error:&error];
    
      if (!success) {
        NSLog(@"Problem copying file from %@ to %@, error: %@", sourcePath, destinationPath, error);
      } else {
        NSLog(@"Copied default values resource to documents directory");
      }
    }
  
    // Override point for customization after application launch.
    return YES;
}
```

If we were writing cleaner code we might move this copy functionality to its own method and call it from here, but this will do for now.

Run the application again. The console log should not appear.

Great, but now what happens if we modify the application bundle's property list? Our changes won't be reflected because the copy will no longer be made.

In order to delete a file in the application's sandbox, the application itself must be removed from the iPhone. We can do that on the simulator the same way we do it on a physical iPhone. Launch the simulator and close down the running application by pressing the home button once. You can simulate this using the *Hardware > Home* menu item. Then click and hold on the application icon until it starts wiggling and the delete button appears. Click the delete button.

At this point Xcode thinks the application has crashed, so just stop the project and then you can run it again in the simulator. You should see the success message appear in the console again when you do that.

**Using the property list**

We now need to reference the file in the applicaton's documents directory from our table view controller instead of the bundle file. We'll use the same `NSSearchPath...` and path building methods. Modify the `viewDidLoad` method so that the `path` variable points to the copied file instead of the bundle file. Everything else remains the same:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [documentsPath stringByAppendingPathComponent:@"DefaultValues.plist"];
    self.items = [NSArray arrayWithContentsOfFile:path];
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
  
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}
```

In a real application we would move all of this data loading and copying to another class that encapsulates and hides the details while providing simple APIs for access to the data, e.g. the list of names. We'll look at doing that in the next chapter.

We would also want to save any changes the user makes to the data. That will be part of your homework assignment.

## Singletons

Future lesson ...