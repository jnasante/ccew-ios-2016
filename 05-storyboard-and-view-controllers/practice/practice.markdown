Lesson 5 Practice
====================================

The purpose of this assignment is to reinforce your understanding of the Utility style application and especially the delegate design pattern.

## Assignment 1

Implement a Utility style application like the one we built in class but start from a Single View application.

**Do not use the built in Utility template**

If you followed along with the example code in class, do not build from that project either. Start a new project and work through the process again to reinforce your understanding of it.

The purpose of your application is to gather information from the user on the backside view and communicate it to the front side view. You'll need to create a custom view controller class, add a custom view and view controller to the storyboard and hook everything up.

You'll also need to create a number of subviews and outlets in the backside view controller. Create an interface like the one below. 

Collect all that information from the interface on the backside and pass it to the frontside controller via a delegate method. Define and implement the necessary delegate protocol.

![](https://s3.amazonaws.com/okcoders/ios/images/04-practice-01.png)

## Assignment 2

Create a third view and view controller in the assignment 1 application. Create a second button on the front side that segues to the third view. This means you will have two segues from the first view controller, one each to the second and third. Identify the segue and correctly prepare for it from the first view controller.

Add additional user interface elements to the third view such as more text fields or switches. Implement another delegate protocol for this view controller and communicate the information from this interface back to the frontside view.

This means that you should now have two delegate protocols one each for the second and third view controllers. Be careful that you are correctly setting the delegates and getting the correct information back from each one.

## Assignment 3

Create a new Master-Detail application. Play around with it and try to customize the interface and add your own application logic.

Create a new Tabbed application. Do the same. See if you can create third and fourth tabs with associated view controllers and add your own application logic.

We will be discussing these kinds of interfaces in our next class so don't worry if you don't understand everything about them now, but I do want you to explore!