SQLite and FMDB
================================

## References

[http://www.sqlite.org/](http://www.sqlite.org/)

The sqlite homepage. Go here for documentation and API references.

[https://github.com/ccgus/fmdb](https://github.com/ccgus/fmdb)

The FDMB repository on GitHub. Download FDMB using the Download ZIP button on the bottom right. Add the *src / fmdb* files to your project and follow the additional instructions below.

[Liya (Mac App Store)](https://itunes.apple.com/us/app/liya/id455484422?mt=12)

Liya is a free sqlite database editor. Use it to review the contents of your database and 

## Introduction

We've been building more complex models as the class has progressed but compared to the rest of our applications the models continue to be fairly simple. Yes we are using our own custom classes for models rather than `NSDictionary`, but model *persistence* has been basic.

So far we've either ignored persistence completely and just saved our models in memory using `NSArray` or we've persisted our models to XML like *plist* files using built-in `NSArray` methods. That's fine for small bits of data and is in fact what an application's preferences use for remember preference choices, but once we have an application with a lot of data, be many entries or large data blobs like images or audio files, xml files are no longer efficient. We need a better system. Fortunately iOS includes built-in support for sqlite, a lightweight database system that supports a subset of the Structured Query Language (SQL).

**SQL and sqlite**

SQL is a comprehensive topic in itself, and we won’t have time to go into other practical details or even the specifics of the language. Instead we are just going to focus on the basics so you will have an introduction to SQLite persistence on the iPhone. That way if you need it for the project you will no where to look and how to get started.

Let's go over the basics very quickly. A sqlite database file will contain a single database. Each database contains many *tables*, which behave like classes. A table has a *schema* which is defined when the table is created that works like the property definitions for a class. The schema defines the data a table will hold by *name* and *type*. Each (name, type) pair in the schema is called a *column*.

Then when we *insert* data into the table, which is like creating instances of a class, the database creates one *row* for each object we insert, which must have values for each (name,type) pair defined in the schema.

You can think of a sqlite database as a spreadsheet. Each sheet in the spreadsheet represents a different table. Each sheet has a header which specifies the names and types for a given column. This behaves like the schema. Then each row in the table contains a single entity of data with many different entries, one for each column. Each cell in the sheet then belongs to a particular row and a particular column, that is, it belongs to a particular entry and has a value for a particular column with a given name and type.

**FMDB**

We're not going to interact with the iOS's sqlite library directly for the most part. The library is implented in C and exposes its functionality with C APIs. Instead we're going to use a 3rd party open source project called FMDB.

FDMB is a wrapper. A wrapper is just source code that abstracts the functionality of lower level source code, making it easier to use. The sqlite library is pretty hairy, so these guys wrote a few Obj-C classes to make working with it easier. The classes handle all the work of interfacing with the database and all the data translation that’s needed to convert Obj-C data types into their C equivalents, and vice versa. This is a very good thing.

With FMDB we will pass instructions to the sqlite database engine. These will come in the form of SQL statements, which we'll still have write. The instructions will perform various operations on the database such as creating tables, inserting entries, fetching entries, or updating or deleting entries. Importantly, when we fetch or *select* entries, the operation will return objects in a result set which we can iterate through to get the data.

We'll see all this below.

**Plan of attack**

To add sqlite support to our application we'll need to make modifactions in a couple of places:

1. Set up an initial database instead of just copying over a plist file. Alternatively we could include a copy of the default database in the application bundle and copy that.
2. Read in the data from the database, which will require more effort than simply getting an array from a file.
3. Update the database. We'll immediately add a record in the database when the user adds a new entry, and we'll immediately delete it when the user is finished.

## Install FMDB

Download FMDB from the [project's repository](https://github.com/ccgus/fmdb) on GitHub. Press the Download ZIP button, unzip the download, add all the files in the *src / fmdb* directory to your project. Ensure that you are adding the files to the project when you do this. Sometimes Xcode doesn't check that checkbox automatically.

At this point you could build the project but it will fail. If you examine the error messages you'll see references to sqlite3 data structures. If you look in the *FMDatabase.h* file you'll see the statement:

```objective-c
#import "sqlite3.h"
```

The trouble is we haven't instructed the compiler to link that file into our application. To resolve this problem we need to add the *sqlite* library to our project.

1. Select the Profile File in the Navigator at the left.
2. Select the application Target
3. Select the General tab
4. Scroll to the bottom and click the Plus button in the Linked Frameworks and Libraries section

![](https://s3.amazonaws.com/okcoders/ios/images/10-01-01-add-library.png)

This is where you add frameworks and libraries to you project. Almost certainly you will want to add functionality to your application that is not included in the core iOS frameworks. Examples include maps, audio, bluetooth, twitter, emails and so on. This functionality is contained in frameworks and libraries which you need to include in your application in order to have access to it

We want the sqlite framework, so nn the dialog box that appears search for *sqlite* and Add the *libsqlite3.dylib* file to your project:

![](https://s3.amazonaws.com/okcoders/ios/images/10-01-02-sqlite.png)

You should now be able to build the application without any errors.

## Creating the default database

Creating the default database will be similar to copying over the plist file with a few additional steps:

1. Check if the database does not exist and if it does not create and open a connection to it.
2. Create a table for our destinations. A table is a collection of similar items in a database.
3. For each entry in our plist file, create a a row in our destinations table. A row is like an entry for a specific kind of item in a database.
4. Close our connection to the database.

We will be making all our modifications to the singleton object that is now handling access to our data, continuing to build on the previous lesson's project.

Naturally, before we can do anything we'll need to import the FMDB files into our implementation file:

```objective-c
#import "FMDatabase.h"
```

Start by modifying the method that will return the link to the address book path. It's called `addressBookPath` in my project. We should return a path to *AddressBook.sqlite* file instead of a *plist* file:

```objective-c
- (NSString*) addressBookPath
{
    NSString *documentsPath =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
  
    NSString *addressBookPath = [documentsPath stringByAppendingPathComponent:@"AddressBook.sqlite"];
  
    return addressBookPath;
}
```

We'll then modify the `copyDefaultAddressBookToDocumentsDirectory` method. We're checking if the address book path already exists. We don't need to modify that code because the `addressBookPath` method is now returning the database file.

But we definitely need to change what we do if the file doesn't exist. Now, instead of copying a file we're going to have to create a database file, set up its tables, and for every item in the default plist file, insert a new row into the database.

Creating the database file is straightforward. FMDB takes care of this for us, we just need to check for errors:

```objective-c
- (void) copyDefaultAddressBookToDocumentsDirectory
	...
	if (![fm fileExistsAtPath:destinationPath]) {
		
		FMDatabase *database = [FMDatabase databaseWithPath:destinationPath];
		if ( ![database open] ) {
			NSLog(@"There was a problem creating the default database");
		} else {
			// ...
		}
	}
```

If the database is opened we can create the table. Add the following code in the `else` clause of that last `if` statement:

```objective-c
NSString *create = @"CREATE TABLE people( "
	"id INTEGER PRIMARY KEY AUTOINCREMENT, "
	"firstName TEXT, "
	"lastName TEXT, "
	"phoneNumber TEXT)";

BOOL success = [database executeUpdate:create];
if ( !success ) {
	NSLog(@"There was a problem executing the create query");
} else {
	// ...
}
```

The is your first taste of SQL syntax. SQL works by giving declarative instructions to the database engine. SQL is a programming language but it is *declarative*. We tell the database what we want and the database figures out how to do it.

This particular *create* statement instructs the database to create a new table named *people* with the following schema. The schema defines four columns . The *firstName*, *lastName* and *phoneNumber* columns match the properties for our person object. This is intentional. When you create a table that will persist the data for an objective-c object, use the same names for each column as you're using for your properties. The `TEXT` type functions like a string.

The first column is a special `id` column which because of the modifiers `INTEGER PRIMARY KEY AUTOINCREMENT` will be unique for each peole entry in this database. Every time the we create a new people object in the database, this value will automatically have 1 added to it. We'll use this value to uniquely identify a people entry in the database.

Be careful with the SQL syntax. It must look exactly like this. In addition we've actually created a single string over multiple lines in objective-c. This is how you do it, by closing the quotes and reopening them on the next line. But it's all the same singe line string when it's strung together:

```sqlite3
CREATE TABLE people( id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, lastName TEXT, phoneNumber TEXT)
```

In that last `else` clause we must now iterate over the items in the default plist file contained in the application bundle and insert a new entry into the database for each one. Add the following code:

```objective-c
NSArray *people = [NSArray arrayWithContentsOfFile:sourcePath];
NSString *insert = @"INSERT INTO people (firstName, lastName, phoneNumber) "
  "VALUES (:firstName, :lastName, :phoneNumber)";
     
for ( NSDictionary *person in people ) {
  BOOL success = [database executeUpdate:insert withParameterDictionary:person];
  if ( !success ) {
      NSLog(@"There was a problem adding default data to the destinations table: %@", person);
  }
}
```

Once again be careful with the syntax. What's happening here is that we are inserting a new row with an FMDB helper. When you insert a row into a database you specify the columns you want to create and the values those columns should have. Instead of hardcoding the values in the sql statement we're using special placeholders, e.g. `:firstName` and then providing a dictionary that has keys with those placeholder names. FMDB then injects the values from the dictionary into the insert statement.

Finally you must close the database file after you are finished with it. Add the following line just before the closing braces for the first `else` clause after the database was opened:

```objective-c
[database close];
```

Remove the unnecessary `error` and `success` variables from the first iteration of the method. The entire method should now look like:

```objective-c
- (void) copyDefaultAddressBookToDocumentsDirectory
{
  NSString *destinationPath = [self addressBookPath];
  NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"plist"];
  NSFileManager *fm = [[NSFileManager alloc] init];

  if (![fm fileExistsAtPath:destinationPath]) {
    
    FMDatabase *database = [FMDatabase databaseWithPath:destinationPath];
    if ( ![database open] ) {
        NSLog(@"There was a problem creating the default database");
    } else {
      
      NSString *create = @"CREATE TABLE people( "
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "firstName TEXT, "
        "lastName TEXT, "
        "phoneNumber TEXT)";

      BOOL success = [database executeUpdate:create];
      if ( !success ) {
        NSLog(@"There was a problem executing the create query");
      } else {
        
        NSArray *people = [NSArray arrayWithContentsOfFile:sourcePath];
        NSString *insert = @"INSERT INTO people (firstName, lastName, phoneNumber) "
          "VALUES (:firstName, :lastName, :phoneNumber)";
        
        for ( NSDictionary *person in people ) {
          BOOL success = [database executeUpdate:insert withParameterDictionary:person];
          if ( !success ) {
              NSLog(@"There was a problem adding default data to the destinations table: %@", person);
          }
        }
      }
      
      [database close];
    }
  }
}
```

## Viewing the iOS file system

Save your project and run the application. You might get a bug from `NSArray` trying to read a sqlite file. If so comment out the line that reloads the address book in the main person table view controller:

```objective-c
// [self reloadAddressBook];
```

Otherwise, if everything worked ok the application should run and you should see no error messages printed to the console. But how can we tell if the database was actually created? Can we look at the database contents in the simulator? That is, can we can access to the filesystem inside the iOS simulator and open up the database file with a sqlite viewer like Liya, mentioned above?

It turns out we can. The simulator keeps a copy of the iOS filesystem in: 

**~/Library/Application Support/iPhone Simulator**

From the Finder, choose the *Go : Go to Folder...* menu and paste that filepath in. You'll see a number of simulator's represented and will have to select the right one. For me it's *7.1*.

Inside that folder you'll find an *Applications* directory with a number of UUID named folders (hexadecimal strings that are unique identifiers). You'll have to find the one for your application. Inside that folder you'll find the *Documents* folder for your application which will contain the sqlite and plist files.

For Xcode 6 and iOS 8 simulator files are kept in:

**~/Library/Developer/CoreSimulator/Devices**

They are also organized a bit differently.

Open the sqlite file with a sqlite viewer such as Liya and you should see the people table and schema you created. You can run the `SELECT * FROM 'people'` SQL command and see each person that you created from the defaults plist file.

## Prep the person object

We're going to make a small change to our person object to make converting between the objective-c object and the database object more straighforward.

Recall that our database person object had matching column names for the person's properties, but there was an exeception. We also had an `id` object which is a customary column for uniquely identifying an object in a database.  Let's add an `id` property to our person object to match it:

```objective-c
@property (strong) NSNumber *id;
```

This is a bit dangerous though. `id` is a keyword in objective-c and represents the generic object. We shouldn't use it as a property name. Let's use `ID` instead:

```objective-c
@property (strong) NSNumber *ID;
```

We've already seen that we can insert rows into a database with fmdb using `NSDictionary`. We'll read rows the same way. And we've already seen some neat key-value coding tricks that let us initialize an object from a dictionary or get a dictionary representation of an object with methods like:

```objective-c
- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
- (NSDictionary *)dictionaryWithValuesForKeys:(NSArray *)keys
```

If you don't see it yet, it turns out it will be very easy to go back and forth between sql data and instances of `CCPerson` using `NSDictionary` as the intermediary. Everything will just work.

*But only if our column names defined by the schema match the property names on our objects.*

This has been the case so far but is no longer the case with the use of `id` in the database and `ID` in the object. Well we have an easy fix.

The two objective-c methods mentioned above use:

```objective-c
- (void)setValue:(id)value forKey:(NSString *)key
- (id)valueForKey:(NSString *)key
```

To set up an object from a dictionary or get the dictionary for an object. When we try to use a key on an object that does not have a corresponding property, such as `id` when the object actually uses `ID`, then a special method is called. We can override that method to see that `id` is being set or requested and instead set or request `ID`.

Add the following code to `CCPerson`:

```objective-c
- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
  if ([key isEqualToString:@"id"]) {
    [self setValue:value forKey:@"ID"];
  } else {
    [super setValue:value forUndefinedKey:key];
  }
}

- (id) valueForUndefinedKey:(NSString *)key
{
  if ([key isEqualToString:@"id"]) {
    return [self valueForKey:@"ID"];
  } else {
    return [super valueForUndefinedKey:key];
  }
}
```

In both cases we intercept requests to get or modify the `id` property on our object and change them so that we actually get or modify the `ID` property. For any other property name we call `super`'s implementation, which raises an exception.

## Reading in the database

We're now ready to read in the database. We're going to use the same methods already built into the singleton but we will load person objects from the database instead of the plist file.

Let's go ahead and add a `database` property to our address book manager. It will keep a reference to the open people database so we can easily read from it and make changes to it without having to open and close the file connection. Incude a class declaration to reference the class name from the header file:

```objective-c
@class FMDatabase;

@interface CCAddressBook : NSObject
@property (strong) FMDatabase *database;
// ... 
@end
```

Rewrite `reloadAddressBook` so it now looks like:

```objective-c
- (void) reloadAddressBook
{
  [self openAddressBook];
  
  NSString *query = @"SELECT * FROM people";
  FMResultSet *results = [self.database executeQuery:query];
  NSMutableArray *mutableItems = [NSMutableArray array];
  
  while ([results next]) {
    NSDictionary *aResult = [results resultDictionary];
    CCPerson *person = [[CCPerson alloc] initWithDictionary:aResult];
    [mutableItems addObject:person];
  }
  
  self.people = mutableItems;
}
```

Our method begins by opening the database, which itself is a method we haven't actually written yet. We'll see it in a moment.

We then create our SQL query to get every row from the `people` table. We execute that query and get a result set back, which is fmdb's way of organizing information returned from a sql operation.

Next we simply iterate through each object in the result set, which fmdb stores as a dictionary, and we use the dictionaries to create instances of `CCPerson` objects, which we collect in a mutable array. When we're finished we store the result in our `people` property, which is already being accessed from other parts of the application. Those parts expect instances of `CCPerson`, and that's exactly what we're still giving them.

Incidentally this highlights an important aspect of a well-designed application. Because we have isolated the behavior of our data manager into its own object and defined an API that all other parts of the application must go through, we can change the internal behavior of that object without having to change the rest of the application. This is good application architecture.

Let's add the method to open the address book. We'll go ahead and add one to close the address book:

```objective-c
- (void) openAddressBook
{
  if (self.database)
    return;
  
  NSFileManager *fm = [[NSFileManager alloc] init];
  
  if (![fm fileExistsAtPath:[self addressBookPath]]) {
    NSLog(@"CRITCIAL ERROR - database should exist at this point");
  } else {
    self.database = [FMDatabase databaseWithPath:[self addressBookPath]];
    if ( ![self.database open] ) {
      NSLog(@"There was a problem opening the default database");
      self.database = nil;
    }
  }
}

- (void) closeAddressBook
{
  if (!self.database)
    return;
  
  [self.database close];
  self.database = nil;
}
```

The open method checks to see if the database is already open and returns if it is. It then checks to see if the db file exists. If it doesn't it fails. At this point you should really raise an exception or return a boolean value so that the controller layer can inform the user.

Then the method initalizes a database at the correct path and opens it. If there's a problem it nils out the object, all along storing the database in the `database` property.

The close method is straightforward. If the db is already closed it returns. Otherwise it closes it and nils it out.

## Inserting Entries

...

## Deleting Entries

...