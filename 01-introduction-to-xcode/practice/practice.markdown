Lesson 1 Practice
===================================

The goal of these assignments is to increase your familiarity with Xcode and Interface Builder and especially with outlets and target-actions. For each assignment except #6 create a new project. Do not use the internet for help. Work in pairs and use the built-in documentation. Try not to worry about the Obj-C syntax as you work. Simply follow the example of existing code and what you see in the documentation.

## Assignment 1

Create a new Utility Application. Lighten the background color using Interface Builder. Add a single `UILabel` to each view. The label on the front view should say “This is the front side”. Set the text in Interface Builder. The label on the back view should say “This is the back side”. Set the text from code using a string literal and an `IBOutlet` property. Both labels should use centered text alignment, which you can set in Interface Builder.

![](https://s3.amazonaws.com/okcoders/ios/images/01-practice-01.png)

## Assignment 2

Create a new Single View Application. Add a `UIButton` and a `UILabel`. Hook them up to your code so that when you press the button, the label is updated to show the current date-time.

Hint: Use the `NSDate` class to get the current date. Check the documentation for usage. Call the `description` method on a date to get a string representation of it.

![](https://s3.amazonaws.com/okcoders/ios/images/01-practice-02.jpg)

## Assignment 3

Create a new Single View Application. Add a `UITextField` and a `UILabel`. When the user clicks the text field, a keyboard should appear to edit it (the system does this automatically). When the user presses the Return button on the keyboard, the keyboard should disappear (you will have to do this) and the label should show the text the user has typed.

Hint: To respond when the user presses the Return button, your `UITextField` must have its delegate property connected (drag from the text field to the View Controller). The delegate (`UIViewController` subclass) must implement the following method:


```objective-c
// this is a UITextField delegate method
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // calling resignFirstResponder on the text field
    // and returning YES hides the keyboard
    [textField resignFirstResponder];
    return YES;
}
```

Add your custom logic to this method to get the text from the text field and update the label with it.

![](https://s3.amazonaws.com/okcoders/ios/images/01-practice-03.jpg)

## Assignment 4

Create a new Single View application and fill the interface with a `UIImageView`. A `UIImageView` displays images. Add an image to your project and set the image on the `UIImageView` to your image. Try setting the image in Interface Builder first, and then set it using code. Make sure the *View Mode* attribute is set to *Aspect Fit* so that your image scales properly.

Hint: Use the *File > Add Files to ...* menu command to add an image to your project. Use the `UIImage` class to load your image into memory. You can access your image using a string literal. Refer to the `UIImage` documentation for more information about accessing an image by name.

![](https://s3.amazonaws.com/okcoders/ios/images/01-practice-04.jpg)

## Assignment 5

Create a new Single View Application and fill it with a `UIWebView`. A `UIWebView` is used for loading and displaying web pages as well as a variety of other content. Check the *Scale to Fit* attribute in Interface Builder and open the Google News home page inside the `UIWebView`: *http://news.google.com* using code.

Hint: A `UIWebView` uses the `NSURLRequest` class to encapsulate URL loading. The `NSURLRequest` class uses the `NSURL` class to encapsulate information about the URL. An instance of `NSURL` can be created using a string literal, eg `@"String Literal"`. Notice the use of the `@` symbol.

Working backwards from the most familiar object -- the string literal -- build an `NSURLRequest` and use it to load a webpage. Examine the documentation and the following classes and methods. Do not use the internet for help! Work together and use the resources in Xcode. The following methods might be useful:

**UIWebView**:
```objective-c
- (void)loadRequest:(NSURLRequest *)request
```

**NSURLRequest**:
```objective-c
+ (id)requestWithURL:(NSURL *)theURL
```

**NSURL**:	
```objective-c
+ (id)URLWithString:(NSString *)URLString
```

Think about it: What do you think the difference is between methods that start with a plus `+` and those that start with a minus `-`?

Note that you must specify the full url, including the http scheme, for this to work.

![](https://s3.amazonaws.com/okcoders/ios/images/01-practice-05.jpg)

## Assignment 6

Using everything you’ve learned so far, modify your existing project from Assignment 5 so that there is now a `UITextField` at the top of the screen. The user can click it to enter a web site address. When the user presses the Return button, the keyboard disappears and the web view loads the new web site.

Hint: You can modify the appearance of the keyboard so that it is easier to enter web addresses. You can also modify the appearance so that in place of a Return key there is a *Go* or a *Done* key with the same functionality. Look at the Attributes inspector for the `UITextField` where it says Keyboard and Return Key.

Make sure you are entering a complete URL, including the http part.

![](https://s3.amazonaws.com/okcoders/ios/images/01-practice-06.jpg)