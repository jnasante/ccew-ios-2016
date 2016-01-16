Lesson 7 Practice
============================

This is the first lesson where we will bring together all of the core principles we have learned so far. You will create a data model, create a moderately complex interface, and create custom controller classes to mediate between the two by way of data source and delegate methods.

Don't put this assignment off! If you've been having trouble with anything in class up to this point this assignment will highlight your difficulties. Give yourself ample time to complete it.

## Assignment 1

You will be creating a tabbed application with two tabs that uses navigation controllers with tables views for each tab.

Create a tabbed view application with two tabs. Delete the controller classes and storyboard items associated with the tabs. Add two navigation controllers, which use table views and table view controllers by default. Create two custom subclasses for your table view controllers and be sure to set them in interface builder. You custom subclasses should be:

```objective-c
CCProfilesTableViewController
CCBookmarksTableViewController
```

Create two custom detail view controllers for displaying a profile and a bookmark, respectively:

```objective-c
CCProfileViewController
CCBookmarkViewController
```

Your application will be displaying a list of profiles and bookmarks.

**Profile list**

Your first table view will be for displaying people's profile. 

Create a data model object `CCPerson` with properties for first name, last name and email address.

Add a property for profiles to the profile table view controller. In that controller's `viewDidLoad` method set that property to an array of 5 - 10 profiles. You will need to create the profiles in code. Don't forget to include header files.

Create a custom cell class for the profile table that has outlets for name and email address. Create and set the custom cell in the storyboard for that table and hook up the outlets.

Implement the profile table controller's data source and delegate methods so that the table displays the complete list of profiles you created in the `viewDidLoad` method.

When the user selects a profile you should segue to the profile detail view, which displays the full name and email address.

**Bookmarks list**

Your second table view will be for displaying website bookmarks.

Create a data model object `CCBookmark` with properties for name and website address.

Add a property for bookmarks to the bookmarks table view. In that controller's `viewDidLoad` method set that property to an array of 5 - 10 bookmarks. You will need to create the bookmarks in code. Don't forget to include header files.

Create a custom cell class for the bookmarks table that has outlets for name and website address. Create and set the custom cell in the storyboard for that table and hook up the outlets.

Implement the bookmarks table controller's data source and delegate methods so that the table displays the complete list of bookmarks you created in the `viewDidLoad` method.

When the user selects a bookmark you should segue to the bookmark detail view, *which loads the bookmark in a UIWebView*. Refer to previous homework assignments for instructions on how to do this.

## Assignment 2

Implement Assignment 1 using collection views.

Collection views are another class for displaying lists of items. They are more commonly used on iPads, and this homework assignment will familiarize you with them.

You will need to research the classes and storyboard items for how to use collections views. This work will prepare you for the kind of research you will need to do for the actual application when you are asked to build interfaces and functionality you haven't learned about.

The relevant classes and protocols are:

```objective-c
UICollectionViewController
UICollectionView
UICollectionViewCell
UICollectionViewDataSource
UICollectionViewDelegate
```

The collection view uses the same design patterns as a table view so you should be able to implement this assignment in a way that parallels the first.
