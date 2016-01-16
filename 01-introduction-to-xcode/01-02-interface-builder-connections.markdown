Interface Builder Connections
===================================

We've seen that Obj-C code resides in the header and implementation files and that interfaces reside in storboards. There are two ways to connect code to interface: *outlets* and *actions*.

An outlet is a one way connection from the code to the interface. It is a way for the code to refer to an object in the interface so that it can manipulate it while the programming is running.

An action is a one way conncetion from the interface to the code. Actions correspond to events such as a touch on the screen and describe what code should run when the event occurs. An action is bound to a specific element such as a button or text field. Its description includes the event that triggers it and the target object and method in your code that will be called.

## The Event Loop

Before we connect our custom interface to the code, I want to talk about the mechanism through which events are handled in iOS.

When an application is idle and in the foreground, it is continuously running through an input loop which is waiting for activity from a number of defined channels. We’re primarily concerned with user events right now, and those are mainly touch events, pressing on the screen.

The system manages these touch events and passes them on to your application when it receives them. The event doesn’t go straight to your main application object. Instead the touch event is located in a specific place on the screen and is routed to any view at that location which implements touch methods and handles those kinds of events.

The system calls a method on that object to handle the touch event, and the object can do whatever it wants with it. Buttons or views in other places handle touch events on their own. Events can be simple taps and touches or more complex gestures. In many cases, a button will be calling an action that is defined on a view controller. This is just a method that we write on our custom view controller class.

For example, a user will touch the screen, the touch occurs over a button, so the system routes the touch to the button, the button has an action defined on it that calls a method in your code, so the button executes that action and your code is called.

In our case with the utility application, the info button is handling the Touch Up inside event and is initiating the seque to the next view (controller).

## The Target-Action Pattern

Notice that the button itself doesn’t really do any of the work involved in flipping the screen. It doesn’t have any custom logic of its own. Again, we’re not subclassing the button. Remember, views are generally lightweight in Obj-C. Instead, we farm out the work to a View Controller class which contains the application logic, or in the case of the info button, the work is defined in the Storyboard and handled by the system.

We’re seeing another important design pattern at work here: the *target-action* pattern. All that means is that we’re specifying a target class with a method for the action. When the button handles the event, it calls that action method on the target class. That’s it.

This way we can re-use our views like buttons while keeping our application specific code separate from them. When we change the interface later on, maybe use a different button or input mechanism, we can still keep it connected to our method on our view controller. We don’t lose any code by discarding the old view and replacing it with a new one. The code is in the controller.

The target-action pattern is one of the tactics employed by the model-view-controller design pattern.

You should be noticing a developing ecosystem of design patterns: model-view-controller, delegates and target-actions are all related. They describe ways of organizing code for the most efficient re-use of existing classes.

## Interface Builder Actions

Let’s connect our custom button here to our controller. If you haven't already, add a custom button to your interface. Drag it in to your your first view from the Object library.

Let’s establish the connection ourself. Ctrl-drag from the button to the view's view controller icon:

![](https://s3.amazonaws.com/okcoders/ios/images/01-02-01-ib-view-controller.png)

We see that right now we only have action seques. This is not what we want. We want the button to call an action on our controller. Let’s use interface builder to create that method for us.

Switch to the *Assistant Editor*. Xcode supports three editor modes: Standard, Assistant and Version. The Assistant editor splits our screen and intelligently shows us files on the right related to the file we are viewing on the left. It is automatically showing us the implementation file for our view controller:

![](https://s3.amazonaws.com/okcoders/ios/images/01-02-02-ib-assistant-editor.png)

The assistant editor also has this butler icon over the second editor:

![](https://s3.amazonaws.com/okcoders/ios/images/01-02-03-ib-butler.png)

Hold your mouse over it. It’s set to automatic. The Assistant editor will try to pair you with a file that makes sense given the file you have selected on the left. If you’ve selected an implementation file, it will show you the header file for that class, and vice versa. In this case, we have selected a storyboard, and it’s showing us the header file for the view controller selected in it.

You can change that automatic setting to whatever you want. If the assistant editor is not showing you the file you expect, you’ve probably disabled the butler by specifically selected a file.

Ctrl-drag from the button to the bottom of the implementation file just above the `@end` declaration. Xcode indicates we can insert an action. Let go. Give it a camel case name that begins with a verb and hit Create. Xcode creates the method for us and connects the button’s action to it. Ctrl-click the button and you’ll see that its Touch Up Inside action is now connected. Log something in the method and run the app. Our text is sent to the log file:

```objective-c
- (IBAction)doSomething:(id)sender
{
  NSLog(@"Do something called");
}
```

Go back to the button. Ctrl-click the button and break the action:

![](https://s3.amazonaws.com/okcoders/ios/images/01-02-04-break-action.png)

Control-click the button again and you see the list of event handlers. Drag Touch Up Inside handler to the view controller and choose the method you defined. Test it. Use two finger scrolling to move through the list. Nice couple of short cuts.

Go back. Break the connection again. View the Connections Inspector for the button. Re-make the connection. And notice that IB automatically selects the touch up inside event. We can do it from the view hierarchy table as well.

Break it one more time and control drag from the button to the code. Break it. Now control drag from the button to the view controller. Lot’s of different ways to do this.

In general, this is how you will link the hooks between your interface and your application code. Control-drag from the UI element to the View Controller. When you forget, you always have the Connections inspector available.

**Code First**

Let’s set up another custom action. This time we’re going to hand code it.

Go to the main view controller header. Let’s add our own action method. Don’t worry about the specifics of creating an instance method in Obj-C just yet. We’ll get to that on Thursday. For now follow the format you see here and add the following line to the header file:

```objective-c
- (IBAction)doAnotherAction:(id)sender;
```

Notice how Xcode autocompletes for you. Xcode does this everywhere, and it does a good job of it. It’s like built-in documentation as you type, and it will often help keep you from looking up a method when you can only remember the first few letters. Just start typing and see what Xcode suggests.

If you leave a semicolon off the end of the line you'll see a red circle. Click the circle and Xcode makes a code suggestion.

When the line is completed notice the open circle to the left. This indicates the status of the connection. No action is targeting this method from the interface.

Build the app but don’t run it. The shortcut is Cmd-B. Notice the warning in the toolbar:

![](https://s3.amazonaws.com/okcoders/ios/images/01-02-05-xcode-warning.png)

Click it. Xcode is telling us that we’ve declared a method in a header file but haven’t actually implemented it. Do not ignore these warnings when you are building your own applications. Often they will ward off bigger problems. Ideally you should have no warnings in your application, although often you will have a couple from using 3rd party code or as notes to yourself.

Notice that the selected tab has changed on the left. We’re now using the Issue Navigator. More on these later. Click back to the first one, the Project Navigator.

Notice the warning symbol in our control panel:

![](https://s3.amazonaws.com/okcoders/ios/images/01-02-06-xcode-warning2.png)

Click it. XCode jumps to the Issue Navigator. Our issue is selected and it shows us the source file where the problem is occurring. Our implementation of main view controller is missing a method that we’ve declared. Click the warning symbol on the left to hide and show the warning.

Let’s implement it. Start typing, following the format, and use autocompletion. Let’s do the same thing the first method is doing, namely logging the fact that the method was called. Don’t copy and paste this code. Go ahead and type it out, using autocompletion as it becomes available. Pay attention to what autocompletes and what doesn’t. Often when autocomplete does not work when you expect it to that means there is a syntax error in your code or you are not typing the right thing.

You should end up with:

```objective-c
- (IBAction)doAnotherAction:(id)sender
{
	NSLog(@"doAnotherAction");
}
```

We have our method, but nothing is calling it. Go to the Storyboard. Ctrl-click and disconnect the button's previous action then reconnect it to the new action. Run the app. Test it. You now know how to write Objective-C code and connect your interface to it.

## Interface Builder Outlets

We also use interface builder to connect our code to the interface, and once again there are two broad ways to do this. We can start with interface builder or we can start with the code. Let's begin with interface builder.

You should have already added a text label to your interface. If you haven't then drag a label into the first view. Enable the Assistant Editor if it isn't already, but from the Assistant Editor's butlet menu select the header file instead of the implementation file: 

![](https://s3.amazonaws.com/okcoders/ios/images/01-02-07-butler-header.png)

Or even better, use the *cmd-control-uparrow* and *cmd-control-downarrow* shortcut to move quickly between an object's implementation file and its header file.

Now drag from the text label in the first editor to the header file in the second editor, making sure to position the mouse between the `@interface` and `@end` delcarations. Let go. Xcode automatically sets the conection to Outlet, you just need to provide a name. Call it `textLabel`. Hit connect and Xcode generates the following code:

```objective-c
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
```

Don't worry about what this means just yet, we'll learn more about the Objective-C language in later chapters. What's important in this chapter is that you now have a way to refer to the label from your code using dot notation. A property is an attribute on an object, and an object can refer to itself from its own instance methods as `self`, which means that methods in our code can reach our text label with `self.textLabel`.

**Code First**

Let's start with code. Create another outlet for another text label. Use the format that Xcode generated for the first one but call it `textLabel2`:

```objective-c
@property (weak, nonatomic) IBOutlet UILabel *textLabel2;
```

Return to the storyboard and drag in a second label from the Object Library. Now control-drag from the view controller icon at the bottom of the view to the label. Xcode lists the Outlets that are available for a connection. Select the textLabel2 outlet. You've just made a connection from the code to the interface.

**Responding to User Events**

We've got actions and outlets set up between our main view controller and its view. Let's implement some code in our action that refers to the outlet.

In the implementation file change the action method for the button so that it updates the text on the first label:

```objective-c
- (IBAction)doAnotherAction:(id)sender
{
  self.textLabel.text = @"Pressed the button";
}
```

Again don't worry too much about the syntax. Save and run your project in the simulator. Press the button and the text label should be updated! You might try a more radical change like altering the view's background color:

```objective-c
- (IBAction)doAnotherAction:(id)sender
{
  self.view.backgroundColor = [UIColor purpleColor];
}
```


<!-- Practice all this stuff in class -->


<!--
EXTRA

Continue: buttons and target-action with interface builder

Changing properties with simple accessors, like background color, use of self, variables, then chaining accessors.

Outlets through interface builder, labels, discussion of properties, setting text value of outlet, string literals

Changing outlet properties with simple accessors in response to interface action, introduction to string literals, chained accessors.

Reacting to properties through outlets, using UISwitch, on, setting label, if statements

Reading properties through outlets, use of sender, using UISlider value, numberWithFloat, description, setting label.

-->