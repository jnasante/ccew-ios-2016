## Lesson 6 Practice

The purpose of this assignment is to re-inforce your understanding of advanced view controllers and their relationships.

You only have two assignments but don't delay! We covered everything in class except for part 10 of assignment 1, but that may take you some time to figure out.

## Assignment 1

Create a new application using the Tabbed Application template, then complete the following:

1. Ensure you have a total of four tabs.

2. Add two additional tabs. Use Navigation Controllers for the two new tabs.

3. For the two navigation controllers you've added, delete the default table view controller it comes with and use your own custom root view controller.

4. For one of the custom root view controllers, add a button that segues to another view controller. You'll need to add the additional view controller and connect the segue action. Use a push transition.

5. For one of the custom root view controller, add a button and push to another view controller from code. You'll need to add an additional view controller and use Storyboard IDs.

6. Create a custom sublcass for all of your view controllers (subclass from UIViewController). The application comes with two. Create two additional subclasses for the root view controllers associated with the navigation controllers you added, and create two more subclasses for the two views that you push to. Set the subclasses on the view controllers in the Storyboard file correctly!

7. Ensure you have set your subclasses correctly by adding interface to each custom view controller and hooking it up through actions or outlets. Add buttons, labels, etc.

8. Title each tab correctly and each view controller in your navigation controller lists.

9. For the navigation controllers add buttons to the right side of the navigation bar in both the two root view controllers and the second view controllers. Try different identifiers to see what the system provides.

10. Set a custom image for each tab. You can try the free [Glyphish](http://www.glyphish.com/) icons. You'll need to research about Image Assets and Retina images.

**Screenshot**

![](https://s3.amazonaws.com/okcoders/ios/images/06-practice-01.png)

## Assignment 2

Explore [pttrns.com](http://pttrns.com). Go through the categories at the left. Think about how you might implement one of these interfaces.

Pick one and try to implement it, something with some interface in it, not just a big picture. We'll go over your choices and ideas in our next class.

Many of these interfaces are implemented with custom table views and collection views which we haven't covered yet. Try to prototype the interface with the views you are already familiar with.