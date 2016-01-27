Building Interfaces: Outlets and Actions
====================================

We've already had some practice working with outlets and actions. Let's re-inforce what we've learned and relate it back to the core Model-View-Controller design pattern used in this chapter.

Our task will be to set up the backside view from the previous section to accept login information for some online service. We'll want the user to enter an email address and password and we'll want to be able to communicate that information back to the frontside view.

## Subviews and Design Patterns

We've already seen how to add subviews to a view. These are user interface (UI) elements contained within the main view that is managed by a view controller. We'll typically want to get information from those subviews or set information on them. For example we may want to set the text on a label or get email entered into a text field. It is precisely the role of the view controller to mediate this movement of information.

As we discussed in the first chapter, a key feature of the iOS view APIs is that views are lightweight. Labels, text fields, buttons, web views, table views, and so on are not usually overridden. Instead they typically embody a limited behavior such as displaying text, allowing for text input, displaying an image, or accepting a touch and then defer to other objects to implement custom application logic.

There are a number of design patterns for defering to other objects such as the target-action pattern with the use of `IBAction` methods or the use of delegates and datasources as we'll discover in later chapters. We've also seen the `IBOutlet` property to get information to the widgets.

In every case the approach resolves the problem of customizing some part of the application's appearance and in every case it is a view controller where our code will go to implement the design pattern and customize the interface or respond to interaction with it.

*Design patterns such as target-action, outlets, and delegates and datasources are strategies for implementing the larger Model-View-Controller pattern.*

Importantly, in addition to managing its main view, a view controller will also manage and mediate interactions with all of the interface elements contained in the main view.

## Text Fields

Let's add text fields for capturing a user's email and password and a button for submitting that information to the application. We'll be adding these UI elements as subviews to the backside view controller and so they will have some relationship, either as outlets, actions or delegates, to that view controller.

First drag in a couple of text fields from the Object Library to the top of the backside view but underneath the Done button:

![](https://s3.amazonaws.com/okcoders/ios/images/04-02-01-textfields.png)

Don't worry about adding labels or anything, we'll take advantage of *placeholders* to instruct the user. Save the project and run the application. Without adding any other code we already have support for text entry. `UITextField` takes care of all of that. What we don't have yet is a way to get the text entered into our application.

Before taking care of that let's improve the interface. We can customize the text field so that context appropriate keyboards come up with the user touches them. The first text field is for entering an email address and so should have easy access to the at symbol. The second is for entering a password and so should hide the text as the user enters it.

Select each text field in turn and adjust the Keyboard attribute in the Atrributes Inspector to Email address on the first and select the Secure checkbox on the second:

![](https://s3.amazonaws.com/okcoders/ios/images/04-02-02-keyboard-secure.jpg)

Run the application and notice the change in the interface as you select each field and type.

Let's also set a placeholder value for each text field. A placeholder is lighter text that appears in the text field when the user hasn't entertered any text into it. Placeholders are commonly used to provide instructions in place of labels. Set the two placeholders in the Attributes Inspector to "Email Address" and "Password" respectively:

![](https://s3.amazonaws.com/okcoders/ios/images/04-02-03-placeholder.jpg)

## Text Field Outlets

Right now there is no way to hide the keyboard when the user is finished with it and it can be cumbersome to move from the first text field to the second. We've already seen in our homework assignment how to modify this.

iOS applications use the concept of a *first responder* to designate which interface element will receive text input from the user. The first responder is automatically set when the user touches a text field, but it is also possible to set it programmatically. Let's modify the application so that the first text field is already the first responder when the user switches to the back view and so that the second text field is selected when the user presses the Done button on the keyboard while interacting with the first.

It's easy to set up the first text field as the initial first responder, but we'll need a way to reference it from the backside view controller in order to do so. For that we use `IBOutlets`.

Add an `IBOutlet` property for each text field to the backside view controller header:

```objective-c
@property (weak) IBOutlet UITextField *emailField;
@property (weak) IBOutlet UITextField *passwordField;
```

Then in the storyboard control-drag from the backside view controller icon to each text field in turn to establish the outlet connection. We now have a way to reference each text field from the code.

In the `viewDidLoad` method in the implementation file, set the first responder on the `emailField` after `super` is called. The method is `becomeFirstResponder` on the target view:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.emailField becomeFirstResponder];
}
```

Run the application in the simulator. The two animations can be a little jarring when they occur simultaneously, so try delaying the keyboard animation:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.emailField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.2];
}
```

Don't worry about the mechanics of that `performSelector:` method but play around with various delay values for the nicest effect.

## Text Field Delegates

We now want to automatically transition the first responder from the first text field to the second when the user presses the Done button while interacting with the first. For that we must implement `UITextFieldDelegate` methods and set our backside view controller as the delegate for the first text field.

The delegate design pattern is just another way of information one object when something has happened in another. Something takes place in object A and object B needs to know, so B sets itself as the delegate of A and A calls a delegate method on B. It's not all that different from an `IBAction`, but it does systematically describe what kind of methods A will call on B.

In the storyboard control-drag from the first text field to the backside view controller icon and establish it as a delegate outlet:

![](https://s3.amazonaws.com/okcoders/ios/images/04-02-04-delegate.png)

The text field will now call certain methods on the view contorller if the view controller implements them. We can examine the `UITextFieldDelegate` protocol in the documentation to see which. The method we want is `textFieldShouldReturn:`, which is called when the user presses the Done (return) button. Implement that method on the backside view controller:

```objective-c
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
}
```

Run the application. Right now nothing happens. Let's add logic to set the second field as the first responder, like we did in the `viewDidLoad` method, but let's also be sure that the `textField` argument that is provided is in fact the email text field:

```objective-c
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == self.emailField) {
    [self.passwordField becomeFirstResponder];
  }
  return YES;
}
```

Run the application. Nice. Now the first responder changes to the second text field when we press return on the first and the keyboard changes.

Now let's hide the keyboard when the user presse the Done button (return) on the second text field. We'll add our code to the same `textFieldShouldReturn:` method but this time check if the `textField` argument is the password field and if it is call the method `resignFirstResponder` on it, which will cause the keyboard to hide:

```objective-c
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == self.emailField) {
    [self.passwordField becomeFirstResponder];
  } else if (textField == self.passwordField) {
    [self.passwordField resignFirstResponder];
  }
  return YES;
}
```

Ah! But don't forget, we also need to make the delegate connection between the password text field and the backside view controller. Control-drag from it to the view controller icon and select the delegate outlet option.

Run the application. We can now transition from one view to another and hide the keyboard. The return button doesn't reflect these transitions though. Modify the Return Key attribute on each text field so that the first says Next and the second says Done:

![](https://s3.amazonaws.com/okcoders/ios/images/04-02-05-return-key.jpg)

## Capturing Text Input: Custom Delegates

We're now ready to capture the email and password input and communicate it back to the frontside view controller. How are we going to do this? Right now the backside view controller doesn't know anything about the frontside view controller. It has no way of getting information to it. All it knows how to do is dismiss itself when the user presses the Done button.

What's the solution to this?

We've already seen the solution proposed by the Utility application template: delegates. Think for a moment about how delegates solve this problem the same way they solve the problem with the text field. When an action occurs in one object in the application, some other objects needs to respond, 

*without those two objects needing to know anything about each other except that one of them responds to a method defined by the other*. 

Whether that action occurs on a simple UI element or a more complex view controller doesn't matter.

So what's the plan of action? What sort of architectual changes do we need to make to our application to implement a delegate between two view controllers.

**1. Set up the delegate**

First we need to establish a `delegate` property on the backside view controller and set its value to the first view controller when the segue occurs. This gives our backside view controller access to the frontside view controller as its delegate.

Start by adding a delegate property to the backside view controller. Delegates are always weak to prevent memory leaks. Because any object can be a delegate, its type must be `id`:

```objective-c
@interface CCBacksideViewController : UIViewController
@property (weak) id delegate;
// ...
```

Then in the segue that transitions from the first view controller to the second, set the delegate attribute on the `destinationViewController`, which will be an instance of the backside view controller:

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"backsideSegue"]) {
      CCBacksideViewController *viewController = segue.destinationViewController;
      viewController.delegate = self; // ADD THIS LINE
      viewController.test = @"Some Test Value";
    }
}
```

Let's be sure we understand the effect. Set a breakpoint in the `viewDidLoad` method of the backside view controller and examine the `_delegate` property. Note that it is an instance of the frontside view controller. Our backside view controller now has a reference to the front side view controller!

**2. Establish a protocol**

We have a reference from the backside view controller to the front. Now we need to actually communicate the email and password to it. Somwhere our backside view controller needs to call a method on the frontside view controller and pass it the email and password as arguments.

What method should it call? This is the same as asking, what method should the front side view controller implement so that the backside view controller can call it?

We can make up any method we like, but we also want to build objects that are *re-usable*. To facilitate re-usability, we define a delegate *protocol*, or contract, that dictates which method the delegate should implement so that the backside view controller can call it.

This way, the backside view controller doesn't need to care what kind of object is its delegate. It only needs to know that the object implements a given method. This kind of relationships is called an *interface* in Java.

Define the protocol in the header file of the backside view controller. Define it after the `@end` declaration for the primary class. A protocol uses the `@protocol` declaration and then lists the required (or optional) methods followed by `@end`:

```objective-c
@protocol CCBacksideProtocol <NSObject>

- (void) backsideViewControllerDidFinish:(CCBacksideViewController*)aController 
 	options:(NSDictionary*)options;

@end
```

That's a pretty verbose method we've defined for the protocol. This is the method the backside view will call on its delegate (the frontside view). It will pass in the email and password in the `options` argument as a dictionary.

**3. Enforce the protocol**

We must now commit the delegate object to obeying the protocol. What we want to do is say, hey, if you're going to be my delegate then you must implement this method. We can enforce a protocol by including it in the type declaration for the delegate property. Add the protocol name between greater than and less than symbols (`< ... >`) after the type (`id`):

```objective-c
@property (weak) id<CCBacksideProtocol> delegate;
```

Unfortunately Xcode doesn't see that symbol when its parsing the file because the protocol is defined after the object, so we need to add a line before the interface delcaration:

```objective-c
@protocol CCBacksideProtocol;
```

Altogether the backside view controller header file should now look something like:

```objective-c
#import <UIKit/UIKit.h>

@protocol CCBacksideProtocol;

@interface CCBacksideViewController : UIViewController

@property (weak) id<CCBacksideProtocol> delegate;

@property (weak) IBOutlet UITextField *emailField;
@property (weak) IBOutlet UITextField *passwordField;

@property (strong) NSString *test;
- (IBAction)dismiss:(id)sender;

@end

@protocol CCBacksideProtocol <NSObject>

- (void) backsideViewControllerDidFinish:(CCBacksideViewController*)aController 
	options:(NSDictionary*)options;

@end
```

**4. Implement the protocol**

Build the application. Notice that Xcode now gives us a warning about incompatible types where we set the backside view controller delegate.

Because we've established a protocol and our now enforcing it on the delegate object for the backside view controller, any object that is set as the delegate must implement the methods defined by the protocol. This means that our front side view controller must implement the `backsideViewControllerDidFinish:options` method and indicate that it implements the protocol.

Let's start with the second part of that. In the frontside view controller header, import in the backside view controller header and mark you class as implementing the protocol. Recall that we do this by including the protocol name between less than and greater than symbols in the interface declaration:

```objective-c
#import <UIKit/UIKit.h>
#import "CCBacksideViewController.h"

@interface CCViewController : UIViewController <CCBacksideProtocol>

@end
```

Now if we build the application Xcode says instead that our frontside view controller doesn't implement the methods required by the backside protocol. So add that method to its header file and implement it.

Header:

```objective-c
#import <UIKit/UIKit.h>
#import "CCBacksideViewController.h"

@interface CCViewController : UIViewController <CCBacksideProtocol>

- (void) backsideViewControllerDidFinish:(CCBacksideViewController *)aController
  options:(NSDictionary *)options;

@end
```

Implementation:

```objective-c
- (void) backsideViewControllerDidFinish:(CCBacksideViewController *)aController
  options:(NSDictionary *)options
{
  // do something
}
```

**5. Call the delegate method**

We now have a reference from the backside view controller to the frontside view controller and we now know what method the backside view controller should call on the frontside view controller. All we need to decide is where to do it. Let's do it from the Done button's `dismiss:` action:

```objective-c
- (IBAction)dismiss:(id)sender
{
  [self.delegate backsideViewControllerDidFinish:self options:nil];
  [self dismissViewControllerAnimated:YES completion:nil];
}
```

We call the method on the delegate and pass in an options dictionary. I've used `nil` for the placeholder. Let's create a dictionary literal that contains `email` and `password` keys and pass that in instead:

```objective-c
- (IBAction)dismiss:(id)sender
{
  [self.delegate backsideViewControllerDidFinish:self options:@{
    @"password": self.passwordField.text,
    @"email": self.emailField.text
  }];
  [self dismissViewControllerAnimated:YES completion:nil];
}
```

Finally, from the delegate method implemented in the frontside view controller we can extract the email and password from the `options` dictionary and use them:

```objective-c
- (void) backsideViewControllerDidFinish:(CCBacksideViewController *)aController
  options:(NSDictionary *)options
{
  NSString *password = options[@"password"];
  NSString *email = options[@"email"];
  
  NSLog(@"email: %@, password: %@", email, password);
}
```

Whew!

## Summary

Ultimately what problem are we trying to solve with this application example? We have two objects: a front side view controller and a backside view controller. We want to gather some information from the backside view, managed by the backside view controller, and communicate it to the frontside view controller so it can do something with it. The big question we need to address is:

*How will these two classes communicate with one another?*

In fact all of the design patterns we've discussed so far, from outlets and actions to delegates and model-view-controller addresses this question of how to oranize our code so that classes can communicate with one another via methods in an efficient manner. This is the question of application *architecture* and is the critical one that must be addressed when building complex applications.