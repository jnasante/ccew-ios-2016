Lesson 3 Practice
===================================

The goal of these assignments is to reinforce your understanding of objective-c's class system and to better acquaint you with the cocoa objects you will use in any iOS project.

## Assignment 1

Create a new Single View application. Create a custom class for your application called `SBCity`. The city encapsulates information about a city, including the name, the country, the population and the latitude and longitude. Create properties for these attributes. Use `NSString` for the name and country and use the primitive types `NSInteger` for the population and double for the latitude and longitude. Add a custom constructor method that take the city’s name and sets it. It should look like:

```objective-c
- (id) initWithCity:(NSString*)aCity;
```

Override the `description` method to return the name of the city.

Create a subclass of your `SBCity` called `SBUSCity`. This class is specifically for a city in the United States. Add properties for the state and for the zipcode. They should both be string values. Add a custom constructor method that takes the city’s name and the state and sets them. It should call the `SBCity`’s constructor method `initWithCity:`. This constructor should look like:

```objective-c
- (id) initWithCity:(NSString*)aCity state:(NSString*)aState;
```

Override the `description` method to return the name and state of the city and a single, combined string.

In your main view controller's `viewDidLoad` method create a couple of cities and a couple US cities. Use the built in constructor and use your custom constructor. Set the properties, then get the properties and log their values.

Hint: Use NSLog to log a value to the console. Log object values like this:

```objective-cNSLog(@"%@",aCity.name);
```
Remember, the string literal is a special format string, and the `%@` stands for an object value that is specified after the string, in this case, `aCity.name`.

You will also need to log primitives such as NSInteger, which looks like this:

```objective-cNSLog(@"%i",aCity.population);
```

Here, `%i` stands in for an integer value. What is the formatting code for a double value?

## Assignment 2

Create a Single View Application. In the `viewDidLoad:` method assign the following string literal to a local N`SString` variable: "This is a string literal with some text in it". Iterate through each character in the string using a for loop and log each individual character to the console.

Hint: use the standard for loop for this assignment, e.g:

```objective-c
for ( NSInteger i = ?; i < ?; i++ ) {
	// Your code goes here
}
```

Use the primitive data type `unichar` to represent a single character in the string, and use the string format specifier `%C` when you log it.

## Assignment 3

Create a Single View Application. Add two text fields to the interface and connect them to your view controller as outlets. Also connect both text field delegate outlets to your view controller. Remember, the delegate outlet is on the text field itself, so drag from the text field to the File’s Owner.

On the first text field, set the Return Key to "Next" in the Attributes Inspector. Finally, add a label underneath the text fields. Increase its height and in the Attributes inspector increase the number of lines to 2 or 3.

In your view controller implement the `UITextFieldDelegate` method:

```objective-c
- (BOOL) textFieldShouldReturn:(UITextField *)textField 
```

This should be familiar from previous assignments. Implement that method so that when the user presses the Next key after selecting the first text field, your application shifts the focus to the second text field. This is called changing the *first responder*.

When the user presses the Done key for the second text field, dismiss the keyboard and store the text values from the text fields in two local string variables. Combine them with a space in between the two strings. Log that value to the console and set the label’s text value to it.

Here’s an example implementation to get you started:

```objective-c
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == self.firstTextField) {
        [self.secondTextField becomeFirstResponder];
    } else if ( textField == self.secondTextField ) {
        [textField resignFirstResponder];
        // Add your custom code here
    }
    
    return YES;
}
```

![](https://s3.amazonaws.com/okcoders/ios/images/03-practice-01.jpg)

## Assignment 4

Create a Single View Application. Add two text fields to the interface and connect them to your view controller as outlets. Also connect both text field delegate outlets to your view controller. Remember, the delegate outlet is on the text field itself, so drag from the text field to the File’s Owner. On the first text field, set the Return Key to "Next" in the Attributes Inspector.

**Do not copy your project from Assignment 2!**

I want you to get into the habit of quickly creating custom interfaces and connecting the interface components to your code. Repeating an exercise is the best way to learn a new skill.

In your view controller implement the UITextFieldDelegate method:

```objective-c
- (BOOL) textFieldShouldReturn:(UITextField *)textField;
```

Implement it so that, like Assignment 2, the first responder changes when you click the Next button and the keyboard disappears when your click the Done button.

This time, perform a number of equality checks on the two text values from the text fields. In each case, log the result of the check, e.g. "The lowercase string values are equal" or "The lowercase string values are not equal".

1. Check if the strings are equal using the `NSString` equality method
2. Convert both strings to lowercase and check their equality using the equality method
3. Get the integer values from the strings and check if they are equal
4. Convert the strings to `NSNumber` objects and check if they are equal using the `NSNumber` equality method.

Instead of doing all these checks in the `textFieldShouldReturn:` delegate method, create a custom method for each check and call each of those methods from your delegate method. The methods should return a `BOOL` value indicating the equality. For example:

```objective-c
- (BOOL) checkIfStringA:(NSString*)stringA isEqualToStringB:(NSString*)stringB;

- (BOOL) checkIfLowercaseStringA:(NSString*)stringA isEqualToLowercaseStringB:(NSString*)stringB;
```

Interface should be similar to the previous assignment's but without the text label.