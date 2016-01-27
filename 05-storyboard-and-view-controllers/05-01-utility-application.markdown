Building Interfaces: Utility App
========================================

Start by building a utility style application from the single view template. Begin with a Single View application. Create a new Project in Xcode (File : New : Project), select Single View application and fill in the required details.

Xcode provides the application delegate, which we won't need to modify, a storyboard where we'll add interface to our application and the single view controller. Examine the storyboard. Run the application to see how that storyboard is rendered.

A blank application, but not entirely. Today we'll really focus on the concept of a view controller and the view it controls.

## Model-View-Controller

Recall that one of the defining design patterns for iPhone development is the Model-View-Controller pattern, or MVC. This pattern separates code into three kinds of components:

1. **Models**, which encapsulate low level application data and contain the business logic for that data. A Person object with a profile picture, name, age, and nationality properties is an example of model.
2. **Views**, which display information to a user. If we wanted to render a person on the iPhone we would need a view for showing the profile picture (`UIImageView`) and views for the name, age and nationality (`UILabel` or `UITextField` if we want them editable). Typically we'll use APIs provided by the system rather than custom views.
3. **Controllers**, which respond to actions in the interface by modifying model objects and which find model objects and set up the interface to render their information. Controller *mediate* between views and models.

We'll be focusing on views and controllers today and especially on a particular kind of controller, `UIViewController`, which is responsible for managing a view and all its subviews.

## View Controllers

Our "blank" application already has a view controller managing a single view. Let's understand how that relationships is established in a storboard, first noting the class of the view controller, `CCViewController` for my project because I've chosen `CC` as the class prefix.

In Main.storybard we see a single large View-View Controller pair in the interface. The view is represented by the large white box and the view controller is represented by an icon in the gray box at the bottom. This is a single unit from the perspective of the storyboard and represents a view paired with a view controller.

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-01-view-controller.jpg)

Clicking on the view selects the view and clicking on the icon selects the view controller. We can see those changes taking effect in the Document Outline and also in our Inspector, depending on which one is selected.

**Document Outline:**

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-02-document-outline.png)

**Attributes Inspector:**

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-03-attributes-inspector.jpg)

The view is an instance of `UIView`, the base view class for iOS applications. All other view classes inherit from it. The view controller is an instance of our `CCViewController` class which inherits from the base view controller class, `UIViewController`.

We can examine and change the classes associated with an interface element (view or controller) via the Identity Inspector. Notice that the class of our view controller is `CCViewController`. This is how the runtime knows what class to instantiate when it loads this view controller from the interface file.

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-04-identity-inspector.jpg)

## Custom View Controller

What we'd like to do is add a second screen to our application and have a button trigger a transition to that screen, essentially creating a Utility style application with a "frontside" and a "backside".

The straightforward way to represent a "screen" in an iOS application is with a view that occupies the entire display. By default views at the top level of the storyboard which are not contained in other views do occupy the entire display, and these kinds of views typically need a view controller to manage them. View controllers often *but not always* controller a single view screen in an application.

Add a new view controller for this backside view to the storyboard. From the Object Library panel underneath the Inspectors search for "view controller" and drag the basic View Controller into a blank space in the storyboard:

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-05-object-library.jpg)

Whenever we add a view conroller to your storyboard Xcode automatically creates a view for it so that we have a view-view controller pair. It will use the default base classes for the view and view controller (`UIView` and `UIViewController`). You can move the view around the storyboard by dragging its gray bar.

Go ahead and set the background color for the new backside view controller so that we can clearly see the transition when we run it in our application. Remember, select the view and use the Attributes Inspector:

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-06-background.png)

## Buttons and Constraints

We would now like to add a button to our frontside view such that clicking the button shows the backside view. Adding a button to the interface is straightforward. Search for "button" in the Object Library and drag it into the first view. Position it at the bottom right, using the guidlines Xcode provides.

Go ahead and change the Type of the button in its Attributes Inspector from *System* to *Info Light* and reposition it to the bottom right again using the guidelines.

Finally you will need to add *Auto Layout contraints* to the button. Make sure the button is selected and click the Resolve Auto Layout Issues icon. Select the Add Missing Contraints menu item:

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-07-constraints.jpg)

Constraints are an unnecessarily complex topic which we may address later. For now understand that iOS uses a constraints based layout engine to position and resize elements on variable sized screens. This contraint pins the button to the button right of the display, no matter how large the display is.

## Segues: Transitioning to a View

There are a number of ways to transition to another view in an iOS application. Some of the transitions depend on the kind of interface you already have set up, as we'll see later with navigation controllers. Generally though you will either set up the transition in code or in the interface, and the transtiion will either be modal or not.

The first distinction should be obvious: you'll either need to write some code or you won't. Regarding the second, a *modal* presentation is one in which you must first end interaction with the presented view before you can interact with the original view again. You have entered a *mode* in the application that restricts interaction to that view (or screen). We will be using a modal presentation here.

For modal presentations it's often simplest to set up the transition in the interface rather than write custom code. Transitions like this are known as *segues*. We'll treat them like actions and once again use the ctrl-drag trick to make the connection.

Set up a transition from the first view to the second view by ctrl-dragging from the info button to the second view. Let go over the second view and select *modal* for the Action Segue:

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-08-action-segue.png)

You'll notice that Xcode adds an arrow from the first view to the second view in the interface area:

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-09-segue.png)

This arrow represents the segue that is triggered by clicking on the info button. Select the arrow and make sure the Attributes Inspector is selected. You'll see that we can change the segue Style and Transition type:

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-10-segue-attributes.png)

Save your project and run the application in the simulator. Click the info button and you should see a "Cover Vertical" transition to the backside view. That is, the view rushes up from the bottom of the screen and completely covers the frontside view.

Quit the simulator and change the Transition style on the segue to Flip Horizontal. Run the application and click the button again. Notice the transition effect is different. Try the Cross Disolve and Curl options as well.

## Dismissing the View Controller

Right now we don't have a way of exiting the backside view once it's on screen. For that we'll need to add a button to the backside view and connect an action from it to the backside view controller. Let's start by adding a Done button.

Find the button element in the Object Library and drag it to the top right of the backside view. Double click it to rename it to "Done", move it into place with the help of the guidelines and then add the missing constraints once again to pin it to the top right of the view.

We now need to connect this button to some kind of action that undoes the modal transition. We cannot set this up in the interface. Although we can go forward with segues just using interface builder, we cannot go backward. We'll need to write some code.

Right now, however, we don't have anywhere to write the code. This button is on the backside view, which is managed by its own view controller, an instance of the default `UIViewController`. We need to subclass this view controller, add our application logic for dismissing the backside view, and connect the button to that logic via an action.

Start by creating a new view controller. Selec the File : New : File menu item and in the iOS Cocoa Touch category choose Objective-C class. Create a backside view controller class (`CCBacksideViewController` for me) which is a subclass of `UIViewController`.

Let's hand code an `IBAction` method on our new view controller called `dismiss:` that will remove the view from the display. First define the method in the header file:

```objective-c
@interface CCBacksideViewController : UIViewController
- (IBAction)dismiss:(id)sender;
@end
```

Then add it to the implementation file. The method should call `dismissViewControllerAnimated:animated:` on `self`, which is the system API for removing a modal segue presented view from the screen:

```objective-c
- (IBAction)dismiss:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}
```

We now have the code we need for dismissing the second view, now we just need to connect the interface to it. Save your code changes and in the storyboard try ctrl-dragging from the Done button to the backside view controller icon.

Our `dimiss:` action doesn't show up as a valid connection. That's because the backside view controller is not set to our custom class. It's still using `UIViewController` as its class, and `UIViewController` does not implement a `dismiss:` method.

Select the backside view controller by clicking on its icon. Select the Identity Inspector and change the Class to your custom class name, `CCBacksideViewController` for me:

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-11-controller-class.png)

Now try dragging from the Done button to the view contorller icon. `dismiss:` shows up under Sent Events. Select it to make the connection. Run the application. You should now be able to transition from the frontside to the backside and back.

## Preparing for the Segue

All of the transition from the frontside view to the backside view is handled by the runtime automatically thanks to the connections we've made in interface builder. But often you'll need to implement some custom application logic in addition to the visual transformation. For example you may need to pass some information from the frontside controller to the backside controller, perhaps a model object or a selection made on the front.

For this custom logic the system provides a method you can override in your presenting view controller (fronstide) that will be called as the segue is being prepared. We've already encountered this method in our homework. It is the `prepareForSegue:sender:` method. Add this method to the implementation file of your fronstide view controller and log the fact that it's being called:

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"called prepareForSegue");
}
```

Run the application again and now, when you click the Info button, you'll see the message printed to the console.

`prepareForSegue:sender:` gives us the chance to access the presented view controller (backside) before it goes on the screen. At this point the second view controller has been instantiated but its view has not been associated with it yet. We can take advantage of this moment to pass data to the second view controller, and then in the second view controller's `viewDidLoad` method we can access that data and set up the interface.

However, a single view controller may present many different view controllers. Imagine that our frontside view controller segued to four different backside view controllers depending on what the user has selected on the frontside. We need a way of identifying which segue is about to take place so that we can correctly address the presented view controller and pass the correct information to it. For that a segue can be given a name and we can query that name in the code.

Examine the segue in the storboard by clicking on the arrow representing it. Make sure the Attributes Inspector is selected and you'll see an Identifier field. You can give the segue a name here. Call it "backsideSegue":

![](https://s3.amazonaws.com/okcoders/ios/images/04-01-12-segue-identifier.png)

Now back in the fronstide view controller in `prepareForSegue:sender:` you can ask for the `segue` parameters `identifier` and string compare it to `backside segue`:

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"backsideSegue"]) {
        //do something
    }
}
```

Often you'll need to access the second view controller that you are transitioning to. `UIStoryboardSegue` has a `destinationViewController` property which returns that instance. You can grab the instance and set properties on it as you need:

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"backsideSegue"]) {
      UIViewController *viewController = segue.destinationViewController;
      // do something with viewController; use your custom class!
    }
}
``` 

Any properties you set on the destination view controller will be available in its `viewDidLoad` method. Let's see how this works. We'll create a simple string property, set its value in `prepareForSegue:sender` and then log it in `viewDidLoad`.

First add a property in the header file for the backside view controller:

```objective-c
@interface CCBacksideViewController : UIViewController
@property (strong) NSString *test; // added this
- (IBAction)dismiss:(id)sender;
@end
```

Now include that header file in the frontside view controllers implementation file:

```objective-c
#import "CCBacksideViewController.h"
```

And use the correct class name in the segue method:

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"backsideSegue"]) {
      CCBacksideViewController *viewController = segue.destinationViewController;
    }
}
```

Set the value for the `test` property:

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"backsideSegue"]) {
      CCBacksideViewController *viewController = segue.destinationViewController;
      viewController.test = @"Some Test Value";
    }
}
```

Finally, log that value in the `viewDidLoad` method on the *backside* view controller:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.test);
}
```

Run the application to confirm your code is correct. The test string should be logged to the console when you click the Info button.

**Summary**

Let's review what's happening here. We started with a single view application that gave us a View - View Controller pair in our storyboard. We added a second view controller from the object library which gave us another View -View Controller pair.

We then added an info button to the first view and connected it to the second view controller, which established a segue in the interface. We modified the segue to use a different presentation style.

Next we added a Done button to the second view. We subclassed the second view controller and set the class for it in interface builder. We implemented a single action method on our subclass for dismissing the second view controller and connected the Done button to it.

Finally we override the `prepareForSegue:sender:` method in the first view controller to add application logic that prepares the second view controller to be displayed. This method is called after the user clicks the Info button and after the second view controller has been instantiated but before it's view from the storyboard has been associated with it. We passed data to the second view controller.

We then added custom logic to the second view controller's `viewDidLoad` method, which is called when a view is associated with a view controller, or right after we set our custom data in the `prepareForSegue:sender:` method. Normally you would use this method to prepare the interface with the data recieved from the first view controller.
