Advanced View Controllers
==============================

The iOS offers a number of specialied view controllers for common interfaces. The two that form the basis of most applications are the `UITabBarController` and the `UINavigationController`. 

## Tab Bar Controller

A tabbed application presents a number of separate views to the user accessible through tabs at the bottom of the screen. Each tab maintains a relationship to its own view controller, which manages its own view for that tab, so you can think of a `UITabBarController` as an object which manages other view controllers.

Tabs have and maintain their own state through the invidual view controllers. Whatever a user has done in one tab, if she switches to another and then switches back, the original tab will be in the same state she left it in.

Tabs are commonly used to organize separate panels or activities in an application. For example, the built in Phone application on iPhones has five tabs, one each for *Favorites*, *Recents*, *Contacts*, *Keypad* and *Voicemail*. Each area offers separate functionality although all are related to making phone calls.

*Importantly, what happens in one tab does not affect the current interface state of another tab.*

Although your underlying data model might change and so information presented in one tab might need to reflect a change that has taken place in another tab, modifications in tab don't change the visual state of another tab by, for example, switching it to a different sceen.

When a user leaves a tab and returns to it, the tab should be in the same state she left it in.

**Creating Tabbed Applications**

Xcode provides a template for creating tabbed applications. Create a new project and select the iOS Tabbed Application template.

Notice the composition of the project. Alongside your storyboard are two view controllers, `CCFirstViewController` and `CCSecondViewController` (*CC* being the class prefix I am using). These two view controllers are responsible for managing the views in separate tabs.

Examine the *Main.storyboard* file. You'll see the primary Tab Bar Controller which is the Initial View Controller for the application and then you'll see two relationships with two other subsequent view controllers, the first view controller and the second view controller.

Notice that, although these relationships look similar to the segues we learned about in earlier chapters, they are different. A tab bar relationship does not define the transition from one view to another in response to a user action, instead it associates a view controller with a particular tab.

Run the application. You'll see that you can switch back and forth between the two tabs.

**Adding Tabs**

We'll use interface builder to make changes to the storyboard and add new tabs. Make sure the storyboard file is selected and drag a view controller from the object library to the workspace. Line it up underneat the first and second view controllers. Drag a label into the view and modify the text to identify it as the "Third View".

To add a third tab to the tab bar controller that corresponds to the view controller we just added, we'll need to establish a relationship between the tab bar controller and the view controller. As you might suspect, we'll do this by control-dragging from the tab bar controller to the new view controller.

Control-drag from the tab bar controller to the view controller and for the connection choose *view controllers* under *Relationships Segue*. Xcode draws an arrow from the tab bar controller to the new view controller and a third tab appears.

Run the application. We now have a third tab that loads our new view controller and displays its view.

**Removing Tabs** 

To remove a tab, select the relationships arrow between the tab bar controller and the view controller and press delete. Re-establish the relationship by control-dragging once again from the tab bar controller to the view controller.

**Arranging Tabs**

You can alter the order of the tabs by manipulating their icons and labels in the tab bar controller view. At the bottom of that view just above the gray bar you'll see the tabs. Drag a tab within that bar to change its position.

**Custom View Controllers**

Typically each tab will use a custom view contoller instead of the base `UIViewController` class. Recall how to associate a custom class with a view controller:

First create the view controller class in Xcode with the *File : New : File* menu item. Choose the iOS Cocoa Touch Objective-C class and name your class, making sure to make it a subclass of `UIViewController`. I've used `CCThirdViewController` for this example.

Second, click the third view controller's gray bar to select the view controller and choose the *Identity Inspector* in the Inspector panel on the right. Enter your custom class name, e.g. `CCThirdViewController`.  

## The Tab Bar

The `UITabBarController` uses instances of `UITabBarItem` to model the visual appearance of each tab in the tab bar at the bottom of a tab bar view. We're talking about the title and icon for each tab.

You might think that you can change the title and icon by editing the items in this bar but it isn't possible. Instead, instances of `UITabBarItem` belong to `UIViewController` as a property, and the tab bar fetches them from the view controllers in order to display the title and icon. Consequently, to change the title or icon for a tab you must change the `UITabBarItem` on that particular view controller.

In the storyboard file you'll notice that each view controller has its own tab title and icon at the bottom of its view. Select this item and be sure to select the *Attributes Inspector* in the Inspector panel at the right. You'll see that from here you can set values such as the badge, the identifier for one of a set of system provided icons, or custom properties such as the title and image.

Try different values for the badge, identifier. Use system provided icons when possible, so be familiar with the different identifer options. Set the Identifier to Custom and change the title and image values. Run the application in the simulator to see how the different look in a live application.

All of these properties are available through code as well, of course. If you must change the values in code you will typically do so through the view controller for that tab. Remember that a view controller maintains a property for its tab bar item, so changing it is as simple as grabbing the value for that property, which will be an instance of `UITabBarItem` and modifying it:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    // In CCThirdViewController for example
  
    UITabBarItem *item = self.tabBarItem;
    item.badgeValue = @"5";
}
```

View controllers also maintain a reference to any tab bars they are contained in through the `tabBarController` property:

```objective-c
// In CCThirdViewController for example
UITabBarController *controller = self.tabBarController;
```

**Custom Images**

You may be wondering how to add you own custom images to the application which you can then set for the tab bar item. You'll accomplish this for a homework assignment.

## Navigation Controller

A navigation based interface is one in which you *drill down* from one screen to the next and can go back and forth between screens. Navigation based interfaces maintain a stack of view controllers and controllers can be pushed onto the stack and popped off it. Typically navigation based application are used to move from more general representations of data to more detailed representations.

For example you might begin with a list of folders and when you select a folder you will then trasition to a list of files which slides in from the right side of the screen. A back button will let you return to the list of folders. If you select a file you'll then drill down into the details for the file, a new screen again sliding in from the right. You can then go back to the list of files and back again to the list of folders or select a new file.

Apple's Mail application is an example of a navigation based application. You begin with a list of Mailboxes displayed in a table. You select a mailbox which reveals the list of messages in that mailbox also displayed in a table. You then select a message which then reveals the details for that message, its full contents, and so on. You could select the sender of that message and drill down into your address details for that person. At each stage you can back up to the previous screen.

**Creating Navigation Based Applications**

Xcode provides a template for creating a navigation based application. Create a new project in Xcode and select the iOS Master-Detail application. The master-detail name reflects the general pattern in these kinds of applications of moving from more general information to more specific information.

Run the application in the simulator. You'll see that we start with a blank list of items in a table view. We'll learn more about table views in the next lesson. Add a few items to the list by clicking the plus button. Select an item. The application navigates to that item with the screen sliding in from the right, and now there is a back button at the top right that goes back to the master view. Click that button to return. Select another item. Back and forth.

**Navigation Using Segues**

The master-detail application sets up a table based application for us, which is one of the primary interfaces for iOS development. We'll learn more about those in the next chapter. For now let's see how we can work with navigation controller applications without needed table views.

Create a new single view application. Select the single view controller in the storyboard (not the view) and in the *Attributes Inspector* uncheck the *Is Initial View Controller* option:

![](https://s3.amazonaws.com/okcoders/ios/images/06-01-01-initial-controller.png)

Try running the application. Notice it crashes. That option identifies the main view controller that should be loaded when the application starts. Let's make it a navigation view controller.

Delete the view and view controller provided by the application template and drag in a navigation view controller from the Object Library. Notice that it creates a navigation controller and an immediate relationship with a second view controller. This is a relationships, not a segue, and it identifies the navigation controller's *root view controller*, or the view controller on the bottom of the navigation stack.

By default we're given a table view, which we don't want. Delete it and drag in vanilla view controller object. We want to make this view controller the root view controller for our navigation controller, which means, you guessed it, we should control-drag from the navigation controller to the new view controller. Choose *root view* under *Relationships Segue*. Run the application.

We want to set up a navigation segue to another view. First set a *Title* on the view controller in the Attributes Inspector, call it "Master":

![](https://s3.amazonaws.com/okcoders/ios/images/06-01-02-set-title.png)

And add a button to the view.

Now drag in a second view controller and place it to the right of the first one. Give it a title as well, call it "Detail". Finally, we want to set up the navigation relationship between the first view controller and the second one, so control-drag from the button in the first view to the second view. Choose *Push* for the *Action Segue*. Notice that the second view controller is now given a simulated navigation bar at the top of its view.

Previously we had been using *Modal* for *Action Segue*. View in the navigation controller that you want to push onto the navigation stack always use *Push* for the segue.

Run the application. We have the navigation controller mechanic working. Clicking the button slides the second view into place and we can click the Back button to return, but our views are missing titles. We'll fix that in a moment.

**Navigating in Code**

Most of the time we'll be able to set up our push segue's in the storyboard but this may not always be the case. When we have to push from code, we'll need to do a couple things. First we'll need a reference to the navigation controller which manages its stack. This is straightforward, as every view controller maintains a reference to any navigation controller it is embedded in.

Second we'll need to instantiate the view controller we want to push onto the stack. That view controller will still be set up in the storyboard, so we'll need a way to reference the storyboard object from our code. Fortunately, just as segues can have identifiers associated with them, so too can view controllers.

Let's modify our application so that we handle the button action in code and push the second view controller onto the stack manually.

First delete the push segue between the two view controllers. Select the arrow and press delete.

Second, set up an identifier for the second view controller. Select the view controller (not the view) and in the Identity Inspector set it's *Storyboard ID* to "secondView":

![](https://s3.amazonaws.com/okcoders/ios/images/06-01-03-storyboard-id.png)

Third, we'll need a custom view controller class to handle the button action on the first view controller. Fortunately we already have one provided by the template. Select the first view controller and in the Identity Inspector set its class to `CCViewController` (or whatever class and prefix name was generated for your template).

Fourth, let's modify our CCViewController files. First we'll add an action to the header file:

```objective-c:
@interface CCViewController : UIViewController
- (IBAction)clickButton:(id)sender;
@end
```

And we'll add an implementation template:

```objective-c
@implementation CCViewController

- (IBAction)clickButton:(id)sender
{
  // more code here
}

...

@end
```

What will our code need to do? We want to instantiate the second view controller by way of its Storyboard ID. We can do this by accessing the storyboard associated with the view class and calling `instantiateViewControllerWithIdentifer` on it:

```objective-c
- (IBAction)clickButton:(id)sender
{
  UIViewController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"secondView"];
}
```

`self.storyboard` returns an instance of `UIStoryboard`. See the documentation for more information about this class.

We can now grab a reference to the navigation controller that this view controller is embedded in and push the second view controller onto the stack:

```objective-c
- (IBAction)clickButton:(id)sender
{
  UIViewController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"secondView"];
  [self.navigationController pushViewController:second animated:YES];
}
```

Finally we need to connect the button to our `IBAction`. In the storyboard file control-drag from the to the View Controller icon in the gray bar at the bottom and choose *clickButton* from the *Sent Events* section.

Run the application. We are manually managing the navigation stack instead of using storyboard segues.

## Navigation Bar

The navigation bar is the area above any view that belongs to a navigation controller. It shows a title associated with the currently visible view and can contain a number of button items for initiating actions specific to that view, as well as the back button to return to the previous view on the stack.

As with the tab bar controller, items in the navigation bar are not managed by the navigation controller. They are managed by each individual view controller instead. Every view controller has a `navigationItem` property whose value is an instance of `UINavigationItem`, which models the appearance of and items in the navigation bar for that view.

Most of the customization done to a view controller's navigation item can be accomplished in the storyboard. Let's start by setting a title for each ouf our views.

In the storyboard, double click in the center area of the navigation bar above a view. You'll be given space to enter in a title. Name the first one "Master" and the second one "Detail":

![](https://s3.amazonaws.com/okcoders/ios/images/06-01-04-nav-title.png)

We can also drag buttons into the navigation area. Find the *Bar Button Item* in the Object Library and drag one into the right area of the navigation bar on the first view. Bar button items are instances of `UIBarButtonItem`:

![](https://s3.amazonaws.com/okcoders/ios/images/06-01-05-nav-button.png)

Select the button and in the Attributes Inspector assign it various values for its Style, Identifier, Title and so on. Although this is a special kind of button that only appears in navigation bars or toolbars (which we haven't discussed), it functions like every other button with target-actions and control-drag to view controller for action hookups.

Sometimes it will be necessary to modify the navigation bar items for a view controller from the view controller's code. It is a property on the view controller. The following code adds a button to the right of the navigation bar. This is like dragging a button to that area, settings its Identifier to Compose, and connecting it to an `- (IBAction)composeAction:(id)sender` method.

```objetive-c
- (void)viewDidLoad
{
  [super viewDidLoad];
	
  UIBarButtonItem *compose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeAction:)];
  
  UINavigationItem *navItem = self.navigationItem;
  [navItem setRightBarButtonItem:compose];
}
```

Every view controller also maintains a reference to any navigation controller it is contained in:

```objective-c
UINavigationController *controller = self.navigationController;
```

See the *UINavigationItem* documentation for more details on customing a view's navigation item.

## Combining Tab and Navigation Controllers

A very common interface pattern combines tab bars with navigation controllers. The key is to understand that a navigation controller cannot contain a tab bar. Instead, a tab bar contains navigation controllers.

For this kind of application, begin with a tab bar application. Remove the connection to the view controllers for each tab and then drag in new Navigation View Controllers from the object library. Then connect the tabs to those navigation view controllers.

Remember that each tab maintains its own view controller. If you use navigation view controllers, then each tab, or however many tabs you choose, maintain their own navigation view controllers. Each tab will have a separate navigation stack and changes to the navigation stack on one tab will not and should not affect the navigation stack on another.

You will build a more complex application with tab and navigation controllers in your homework assignment.