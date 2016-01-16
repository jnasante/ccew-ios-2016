## Lesson 8 Practice

For this homework assignment you will continue to practice working with table views and will also get practice working with the iOS filesystem. You will build another simple table application that supports adding and removing items. You will use a real data model and you will save changes to the filesystem.

This is a tough assignment. You'll need to look up a number of API's and bring together a decent bit of code to put the application together. Don't procrastinate on it!

**Table view application**

Create a new single view application. Make the same changes we made to it today in class to turn it into a navigation controller application with a table view root view and detail view. Do not start with the master-detail template. Practice setting this up.

You'll want to create a custom subclass of `UITableViewController`, set your custom subclass in the interface, hook up your delegates and data sources and set up your detail view segues.

**Data model**

Your table view will model address book entries with names and phone numbers. Create a `CCPerson` object with properties for first name, last name and telephone number. Create a method that combines the first name and last name into a presentable string.

**Resources file**

Create a plist resource file for the application bundle called "AddressBook.plist" that contains default address book entries. Your plist should be an array of dictionaries with each entry containing a value for the `firstName`, `lastName`, and `phoneNumber` properties on your data model. Use the same dictionary key names and property names. For example:

![](https://s3.amazonaws.com/okcoders/ios/images/08-practice-01.png)

Add four items to your default address book.

In your application delegate, copy this resource to the application's documents directory.

Then, in your table view controller when you initialize the `items` array, get the values from the copy of this file in the application's documents directory. Notice that you will get an `NSArray` of `NSDictionary` objects back when you read the plist file, which you will need to convert to an `NSArray` of `CCPerson` objects before setting it to `items`. How will you do this?

**Fully functioning table view**

Implement the table view data source and delegate methods to support viewing, adding and remove people in the address book list. Use one of the built-in table view cells that supports the `detailTextLabel` for showing the phone number. Show the full name in the cell's `textLabel`.

**Adding entries**

Add a view controller and necessary interface for create new entries in the address book. You'll need a few text fields and a number of delegate methods both for handling the text fields and for getting data back from the view controller to the main table view controller.

Try using a push segue to transition to the new entry view. Back should take you back to the table view without saving the new entry. You might add a save button to save the changes and a done button in the navigation bar to hide the keyboard. For example:

![](https://s3.amazonaws.com/okcoders/ios/images/08-practice-02.png)

**Saving changes**

Add support to save changes to the address book back to the plist file in the application's documents directory. When should you save those changes? How will you write the file (Hint: see the `NSArray` documentation for a convenient method)? Don't forget that you'll need to convert back to an array of property lists from an array of person objects, a process known as serialization.

**Details view**

Implement a details view to show the details of an address book entry when you click on it. Take advantage of the commented out `prepareForSegue:sender:` method in the table view controller to hand data off to the details view depending on the selected row. Add a button to call the person. Yes, you can do this! Search on the internet for the required API.

## Review

Bring your code to class. We will definitely go over this homework assignment at the beginning of the next lesson.