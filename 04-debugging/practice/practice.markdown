Lesson 4 Practice
=================================

The assignments will familiarize you with Xcode’s debugging facilities, including the use of `NSLog` and of breakpoints. Do not use the internet for help! Work in pairs and use the built-in documentation.

## Assignment 1

Create a new Single View Application. Leave the interface empty, but add a log call to each of the delegate methods implemented in the application delegate, for example:

```objective-c
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
}
```

Run the application in the simulator and see if you can get each method to be called so that it writes your log string to the console. You’ll have to press the home button on the simulator to close your app in order for some of the delegate methods to be called. The home button is the physical, round button with the square in it at the bottom of the device. You can also double click the home button to change the state of your app.

When are the various delegate methods called?

Now add a breakpoint on each of these methods (you don’t need to recompile the project), and allow yourself to be dropped into the debugger. Examine the variables that appear. Click around in them, print some of their descriptions to the console. Have a look at the call stack. Poke around.

There won’t be much info in either case, but familiarize yourself with navigating these views and examining variables.

## Assignment 2

Download the set of projects in the *debug* folder.

Each of these projects has a bug. Some do not do what they are supposed to do, and others are crashing. Fix these projects so that they behave as expected. In each case, have a look at the included *ReadMe* file to see what needs to be done.

Remember, use breakpoints and exception breakpoints to find out where a problem is, and examine the messages logged to the console for concrete hints from the system. To add an exception breakpoint, select the Breakpoint Navigator on the left pane and click the small plus button at the bottom of the screen.

Even if the solution is intuitive to you, go through the process of adding breakpoints and dropping into the debugger to figure out where things are going wrong. It is essential that you learn how to use the debugger in preparation for more complex projects.
