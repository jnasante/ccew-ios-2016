Introduction to Xcode
===================================

Objective-C can be used for command line applications, but iPhone applications always have a User Interface, and graphical applications are more fun. Moreover Xcode offers a number of templates for iOS development, so we can quickly get an application running with very little programming. Let’s see just how much we can do.

## Creating a New Project

- Launch Xcode, choose Create a New Xcode Project. Cancel that dialog.
- Choose the File > New > Project menu. Same dialog.
- Select *Single View Application* from the iOS Application item.
- Press *Next*

You'll need to fill out the project details:

- **Name**: Select any name for your project.
- **Organization Name**: Company or group name, such as *ccew*.
- **Company Identifier**: Uniquely identifies you as a developer or developer group. It is usually a reverse DNS listing such as *com.appl* or *edu.ou.ccew*. Together the company identifer and project name make up a unique identifier for your application.
- **Class Prefix**: Two or three capital letters such as *PD* or *CC* that will be prepended to all your class names. Objective-C does not have namespaces so prefixes are used to keep class names from conflicting.
- **Devices**: What kind of application are you building? iPad, iPhone or Universal (both). Select iPhone for now.

Continue, selecting a location for your project. Xcode templates the application and sets up the project workspace, including your build toolchain.

At the top left of the Xcode window to the right of the run and stop buttons, and to the right of the project name, make sure an *iPhone Simulator* option is selected from the menu. 

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-01-select-simulator.png)

Press the *Run* button (Cmd-R). Xcode launches the iPhone simulator and you see a lovely gray app that doesn't do anything. Quit the simulator or return to Xcode and press the stop button.

It may not seem like Xcode is doing much for us here, but what exactly is it doing? There’s no toolchain to set up, no make files, no multistage compilation with object file creation and linking. There are no libraries to install. You don’t need to check for the availability of an SDK. There is no boilerplate code to write.

At this point all you've done is install Xcode, select a template and press run. That’s it. If you have a provisioning profile set up, you can run this on your iPhone right now.

<!-- Demonstrate Application on iPhone -->

## The Project Navigator: Files

Let’s look at what Xcode has created for us to make this work. On the left we have all the *Navigators*, which give you quick access to project components. Select the *Project Navigator*, which reveals all the files in your project. Expand every folder in your project to show everything it contains.

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-02-project-navigator.png)

We’re interested in our custom classes. Look at *main.m*. As in C or Java this is where the program begins. But all that’s happening here is the system is passing control off to the application’s event loop with some memory management.

## Documentation

What is this method `UIApplicationMain`? Hold down the command key (⌘) and click on it. XCode takes you to the header file for this method. This works on any method in Xcode. Examine the method arguments. Do it again for `NSString` in this file.

At the top of the main editor pane you'll see back and forward buttons like in a web browser. 

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-03-back-forward.png)

Click back once. Try the the two finger keypad swipe shortcut. Use two fingers on the keypad like you can for scrolling up and down but instead swipe left and right. This is a gesture shortcut for going backward and forward. Learn these! They will make your life easier.

Let's learn more about this method, `UIApplicationMain`. After all header files aren’t everything. Let’s look it up in the documentation.

From the *Help* menu select *Documentation and API Reference* (⇧+⌘+0). Type in the name of the method, `UIApplicationMain` and select the single hit. Examine the documentation. Apple’s documentation is excellent. Everything you need to know about programming on iOS is right here. Acquaint yourself with this documentation. Browse through it when you’re sitting on the toilet. Go to the documentation before you go to Stack Overflow and after you’ve pasted in code from the net so you will actually understand it.

Try `NSString`. There are many more hits. We want the class, which has the `C` icon. Usually the first hit is what you want. The hit leads us to the documentation for the entire core `NSString` API, documentation almost everything you can do with strings in Obj-C. We'll take a much closer look at this on Thursday.

Return to the code and *main.c*. This time hold down the *option* key (⌥) and click on the `UIApplicationMain` method. This is the same documentation we just saw in the help files but built into the editor. Click away. Now select the Quick Help inspector from the Utilities view. Click on the UIApplicationMain text so that the caret is there. Once again you have almost immediate access to the help files but now in the utilities pane.

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-04-quick-help.png)

Xcode is a complex application, but it wants to help you. We’re learning how to use it so that it can help you. Let me emphasize that you should learn these tricks. Remember them. The value of good, accessible documentation cannot be overstated.

## The Application Delegate

Look at the XXAppDelegate.h file, where *XX* is the two or three character prefix you specified for your project. This is the *header* file for the application delegate. Obj-C shares similarities with the C language such as the use of header files for the declaration of objects and their methods and properties, and *implementation* files in which the object is actually implemented. These are the *.h* and *.m* files in your Xcode project.

The AppDelegate object is a delegate. The delegate pattern is widely used in Obj-C. Design patterns are re-usable solutions to common software problems. In this case, our problem is that a core class already does most of the work required in a particular situation, but it needs additional behavior in response to certain user actions. In this example we’re talking about the main application class, *UIApplication*, which we haven't encountered yet.

In many languages the solution would be to subclass *UIApplication* and add your custom functionality where needed. In Obj-C the *idiomatic* solution is to use a delegate. The delegate pattern is everywhere in Obj-C and Apple's *UIKit* frameworks. 

The delegate pattern is straightforward. A class requires additional behavior and informs your custom delegate class at the appropriate time so that you can provide that behavior. You set your custom class as the delegate for the main class. In our case, the system sets up the AppDelegate as the delegate for the system instantiated UIApplication instance.

Our AppDelegate is just a subclass of *UIResponder*, indicated by the `: UIResponder` expression in AppDelegate.h. UIResponder is itself a class which handles much of the user interaction in an application and is subclassed by the system in many places, and *UIResponder* is a subclass of the base class *NSObject*.

Nothing special here. But what makes our AppDelegate a delegate to *UIApplication*? How does our AppDelegate class know what kind of behavior the *UIApplication* class will expect of it?

For this Obj-C has *protocols*. In Java, these are known as *interfaces*. Don’t worry if you aren’t familiar with them. A protocol simply declares an interface but does not implement it. A protocol tells a class what kinds of methods it is expected to implement, and then if the class declares itself as *conforming* to that protocol, it implements them. 

We’ll be looking more at Obj-C syntax on Thursday, but look at the complete `@interface XXAppDelegate : UIResponder <UIApplicationDelegate>` expression in AppDelegate.h. 

`@interface` declares a new class with the name. The colon indicates that this is a subclass of *UIResponder*. And the information between the greater and less than symbols tells the system that this class conforms to the *UIApplicationDelegate* protocol.

Click *UIApplicationDelegate* for the documentation overview in the Quick Help inspector. Cmd-click it to see the header file. These are the methods our application delegate can optionally implement. For more details search for *UIApplicationDelegate* in the help files.

Examine the AppDelegate.m implementation file. Note all the delegate methods our application delegate implements out of the box. Most allow you to specify behavior when your application undergoes a system defined transition, such as when a user leaves it to go to another application or returns.

Consider the `application:didFinishLaunchingWithOptions:` method. This method is called once whenever your application is loaded from the iPhone’s hard disk. An application’s set up code goes here. It will almost always be minimal. Most of an application’s work won’t be done in the application delegate but inside one or many view controllers, following the Model-View-Controller (MVC) pattern we’ll learn more about later. 

This implementation demonstrates just as much. In the past code here would set up a window to contain a view associated with a view controller, add the view to the window, and make the window visible. Now iOS applications use something called Storyboards, special files in which we create our user interface. The application knows which storyboard contains the main interface and automatically loads it when the application launches. This information is specified in the Info.plist file.

We’ll get to Storyboards in a minute. Let’s look at another application example from Xcode. Create a new application as you've already done, but this time make it a *Utility Application* and examine the AppDelegate.m file again.

## Quick Intro to Objective-C Syntax

By now you've probably noticed how strange Objective-C syntax is. Obj-C syntax include a mixture of *bracket notation* and *dot notation*. We’ll get more into this in the next chapter, but for now just read through the code and try to guess what each line is doing, knowing that the use of surrounding brackets `[foo bar]` calls the `bar` method on the `foo` object.

Note how descriptive the code is. This is a common practice in Obj-C and one you will be expected to follow. We do not use abbreviations in Obj-C. Be descriptive. This practice is known as *self-documenting code* and makes is much easier to understand what is going on. And because Xcode intelligently autocompletes method and variable names, the length of the name doesn’t really matter. Remember, you can always cmd-click and option-click on a method to get more information about it.

Also note the *camel casing*. Camel casing (first word lower case, rest upper case) is idiomatic in Objective-C and a practice you’ll be expected to follow. Class names and protocol declarations begin with upper case letters, and often static constants, but almost everything else, including method names and variables, begin with a lower case letter and are camel cased so that each following word in the string is capitalized. No underscores!

## View Controllers

In the utility application look at the MainViewController header. Simple, right? Just a class declaration. Recall, what does the `: UIViewController` mean?

Click over to the MainViewController implementation. Not too much code either until the bottom of the file. There is some new syntax, like `@interface MainViewController ()`. That’s a private category which you don't need to worry about just yet.

Otherwise we have a few mostly empty methods and that’s it. Some of these methods look like the delegate methods we saw on our application delegate class, did do this or will do that type methods, but actually this is a different design pattern that is common throughout Obj-C as well called the *Template Method*.

Template methods are called automatically by the system when needed but are not called directly by your own code. You are able to implement critical functionality that the system expects specific to your subclass in these methods. Sometimes you must call super’s implementation as well. `viewDidLoad` and `didReceiveMemoryWarning` are both template methods. What kind of methods are `flipsideViewControllerDidFinish:` and `popoverControllerDidDismissPopover:`?

Don’t let the simplicity of the class fool you. View controllers are where most of your custom application code will go. In the Model-View-Controller pattern, views are generally lightweight and rarely customized. Business logic goes inside your model, such as data validation and data relationships, but almost everything else will go in your controllers, which mediate between the view and the model. These view controller files will get to be hundreds and thousands of lines long.

## Interface Builder and Storyboards

Typically a single view controller manages a single view, or interface component. Your custom view controllers will manage a range of views that will correspond to screens or panels in your application’s interface. You build these interfaces inside what’s called a Storyboard using the Interface Builder section of Xcode. Select the Main.storyboard file. Notice just how radically different this editor is.

A Storyboard contains the interface for our application, often arranged in groups that correspond to single screens, or views, which are themselves each associated with a single view controller. In many cases we can lay out the entire interface here. We then make connections between the interface and our code using what are called *outlets* and *actions* so that we can respond to user events such as touches and change the interface dynamically. The storyboard also lets us specify the transitions between the screens.

For example, our utility application has two screens, a front and a back. Each screen is managed by a view controller, which itself controls a single main view. One of our views has a button subview in it. The other view has a navigation bar, which itself has a title and a done button. Between the two view controllers is a *segue* connecting them. The segue represents a graphical connection between the two screens. Here it executes when the user presses the info button on the front screen and is reversed when the user presses the done button on the back screen.

We can see all these relationships explicitly. First make sure the document outline is expanded. Click the panel button at the bottom left of the main interface:

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-06-show-outline.png)

Document Outline:

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-05-document-outline.png)

From the Document Outline table at the left we can examine the view hierarchies and the relationships between items. Control-click the main view controller. You’ll see that one of its outlets (a connection between code and the interface) is the view it controls. We can see this in the interface itself, and if you look at the far right Inspector Panel, selecting the Conections Inspector you'll also see this outlet relationship:

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-07-connections-inspector.png)

If you control-click the info button at the bottom right of the first view's interface, you’ll see it has an action corresponding to the segue. On the second view, if you control-click the done button or examine its connections, you’ll see it refers to an *action* called `done:` on its view controller. Like an outlet, an action is a way to connect your interface to your code.

## Inspectors

Select the first view in the inspector by click the large grey rectangle. It's difficult to tell you've selected it, but a slight shadow will appear around it. In the Inspectors Panel at the right select the Attributes Inspector:

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-08-attributes-inspector.png)

These are properties you can set visually on this user interface element. You’ll be working a lot with these. Every one of them corresponds to a property you can also specify in code, and in fact the system does just that when it loads the Storyboard. Under the hood a storyboard is just XML that is translated into objects and method calls at runtime.

Let’s have a quick look at these other Inspectors, from left to right:

*File Inspector*: about the file itself and its relationship to the project. Mostly you don’t need to worry about this, although sometimes you might forget to actually add a file to a project. Target Membership is the solution.

*Quick Help*: we’re familiar with this.

*Identity Inspector*: change the class name, internal Xcode attributes, e.g. Label for a more useful name.

*Attributes*: let’s come back to it.

*Size Inspector*: for positioning, important when you start adding subviews to your main view.

*Connections Inspector*: the hooks established between your interface and the code through *outlets* and *actions*.

Review the connections. Recall that we have interface hooks that are outlets and actions. An outlet connects our code to an interface element so that it can change it. It is a reference from the code to the interface. The `view` property on a view controller is an outlet. 

Actions go in the other direction: they connect the interface to code. They instruct the runtime to call a method on an object when an event takes place in the interface. We’ll work more with these in a moment.

Return to Attributes Inspector for our view controller. Let’s play with this for a bit:

Select the Main View Controller itself from the Document Outline and set the simulated metrics. Landscape is for holding the iPhone sideways versus portrait, right side up, etc. This is helpful for laying out our custom UI elements. Set the status bar to black as well and the top bar to Opaque Navigation Bar.

Run the application in the simulator. Notice that changing the simulated metrics didn't actually affect anything. These are just interface simulations to help you lay out your interface. Actually controlling the orientation or status bar requires changes to your code.

Let’s change the background color. Anything you like. Maybe something gaudy. Run the app. Ahh, it’s still running in the simulator. That’s ok, just stop it and let Xcode handle it. Switch over to the simulator. We haven't written a line of our own code but we can change the background of our app. We can’t do much with just a `UIView`, the base view class we have here, but it’s nice to be able to customize it without having to code.

## Drag and Drop Interface

Look underneath the Inspector view at the Library Panel. It has four tabs, from left to right the File Template library, Code Template library, Object library and Media library. Normally we’ll have the Object Library selected when working with interfaces. These are the system UI components that we can simply drag and drop onto our interface to create buttons, labels, text fields and other views:

![](https://s3.amazonaws.com/okcoders/ios/images/01-01-09-library-panel.png)

Let’s add a text label. Search for "label" in the library search field at the bottom of the screen and find the label widget. Drag it from the library to near the top of the first view. Notice the guidelines. Use these. Apple has very specific recommendations for the spacing in a user interface, and you should only violate them with very good reason.

Release the label. It's automatically selected so that we can immediately change its attributes. Double-click it to change the text.  Note it’s resized to fit our text. Let’s go ahead and resize the label to take up all the recommended width.

Look at the Attributes Inspector for the label. There's quite a bit more here. Click around a bit. Play with these for a moment. Change the attributes. Save and run you project in the simulator to see how it looks.

Let’s change the text color, add some vertical shadow, and change the alpha value, attributes you’ll commonly be changing to customize an application’s appearance. Run the app. Nice, huh? Now remember, all these attributes correspond to class properties, and the system is actually calling code on instances of these objects when it loads the storyboard.

Add a Button. Size it and give it a title. Run the app. Now the user can click our button, but it doesn’t do anything. That’s because we haven’t established the connections between our UI elements and the view controller. We haven’t set up the hooks that make our UI elements and their events accessible in code.

For that we'll need to understand interface builder connections.