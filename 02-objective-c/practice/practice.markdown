Lesson 2 Practice
===================================

The goal of these assignments is to improve your ability to program in Objective-C. The assignments will cover basic object-oriented features of the language, including classes, properties and methods. Remember, do not use the internet for help! Work in pairs and use the built-in documentation.

## Assignment 1

Create a new Single View Application. Add an `NSString` property to your main view controller called `myTitle` and set the string in the `viewDidLoad` method. Add a button and a label to your interface. Connect the label as an outlet on your view controller and connect the button’s touch up inside event to an action on your view controller. When the user presses the button, set the text of the label to the string property you already set.

![](https://s3.amazonaws.com/okcoders/ios/images/02-practice-01.jpg)

## Assignment 2

Create a new Utility Application. Add a `UITextField` on the front side interface and add an `NSString` property to the front side view controller. Allow the user to enter text, and when they press the return button, hide the text field and save its value into your string property.

Add an `NSString` property to the back side view controller and add a `UILabel`. When the user clicks the info button to switch to the back side, set the string property on the back side view controller to the value you have stored in the front side view controller. Then, when the back side view appears, set the label’s text to the string value.

Hint: Use the `UITextFieldDelegate` code from the first assignment to respond to the return button. Add your code to the `prepareForSegue:` method on the front view controller and to the `viewDidLoad` method on the flip side view controller.

![](https://s3.amazonaws.com/okcoders/ios/images/02-practice-02.jpg)

## Assignment 3

Create a new Single View Application. Create a new class for your application called `CCBusiness`. It should subclass from the base `NSObject` class. Your class encapsulates the information for a local business, such as the business name, the type of business, e.g. “food service” or “clothing”, the phone number and the address, city, state and zip code.

Create properties for each of these pieces of information. They should all be strings. Create a constructor method (`init`) that sets all these properties to empty strings, and create another constructor that lets you specify the business name when you create a new instance of `CCBusiness`.

In the `viewDidLoad` method of your view controller, create a local instance of a business, set its properties, and then retrieve and log each of its properties to the console. Don't forget to import your CCBusiness.h file!

Hint: Use `NSLog` to log a value to the console. Log object values like this:

```objective-c
NSLog(@"%@",business.name);
```

The string literal is a special format string, and the `%@` stands for an object value that is specified after the string, in this case, `aBusiness.name`.

## Assignment 4

Create a copy of assignment three. Make sure you duplicate the entire folder and not just the project or the individual project files. Add two methods to your business class with the following declarations:

```objective-c
- (NSString*) formattedAddress;
- (void) updateTheCity:(NSString*)inCity state:(NSString*)inState 
	zipcode:(NSString*)inZipcode;
```

Implement these methods. The first method should return a formatted version of the address which combines the address, city, state and zip code. Use newlines to separate the components like you normally would in a US address. A newline in a string is `\n`

The second method should let you update the city, state and zip code at the same time with one method instead of using three properties, although you’ll need to use the property setters in the method’s implementation.

Implement a third method, the `description` method that `NSObject` already implements. Override that method so that you return the business name. Look in the documentation for the method signature. (The signature is its definition).

Add a `UITextView` to your interface. A `UITextView` is used to display large amounts of text. After creating an instance of the business class in your `viewDidLoad` method and setting its properties, get all of those properties and combine them into a single string that you display in the text view. Use newlines to format the string.

![](https://s3.amazonaws.com/okcoders/ios/images/02-practice-03.jpg)