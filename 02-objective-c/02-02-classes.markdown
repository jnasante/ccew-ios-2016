Building Classes
===================================

Let's take what we've learned about properties, instance methods, dot notation and bracket notation and build a custom class with properties and methods. We'll also learn about class initialization and class methods.

Create a new class `CCPerson` from the File > New > File > Objective-C Class. Specify a subclass of `NSObject`.

Add three properties to the class for name and nationality, all of them `strong` and `nonatomic`:

```
@interface CCPerson : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *nationality;

@end
```

## Constructors (Initialization)

Let’s set some default values for these properties. Every object has a default constructor method that is implemented by `NSObject` and can be overridden by a subclass to set up default values. It is the `init` method.

When you override the `init` method you always call `super`'s implementation first and set the result to `self`. You should then ensure that `self` is not `nil` (in case there was a memory error) before setting up your custom values. Finally you will return `self`.

The template you will see in every case looks like the following. It belongs in the class implementation file:

```
@implementation CCPerson

- (id) init
{
    self = [super init];
    if ( self ) {
    
    }
    return self;
}

@end
```

Note that the generic type `id` is used for the constructor. This is always the case. In many cases, especially with the frameworks, constructors may actually implement the *façade pattern* and return a different kind of object.

*When you create a custom model class that directly subclasses `NSObject`, you should always write your constructor this way.*

Inside the constructor you set up default values for your properties and do any other set up work. It is customary to access the instance variables directly within the constructor. This will be one of the only times you access instance variables directly.

Recall that Xcode creates instance variables for you when you use the `@property` declaration. Those variables will have the same name as your property but be prefixed with an underscore (`_`).

Set default values for the properties of a `CCPerson`:

```
@implementation CCPerson

- (id) init
{
    self = [super init];
    if ( self ) {
    	_firstName = @"Unkonwn";
		_lastName = @"Unknown";
		_nationality = @"United States";
    }
    return self;
}

@end
```

We’re just assigning string literals to our properties. Now we can create an instance of this object in another class and use it.

## Instantiation

We create instances of an object using the two-stage `alloc` and `init` pattern:

```
ClassName *instance = [[ClassName alloc] init];
```

The two stage pattern is responsible first for allocating memory for the object and second for calling `init` on the newly created object, the same `init` method we override in our custom subclass.

From a view controller create an instance of a `CCPerson` and log its `firstName` to the console. First we'll need to import the header file into the view controller's implementation file:

```
#import "CCPerson.h"
```

Then in the `viewDidLoad` method instantiate a person and log the value:

```
- (void)viewDidLoad
{
  [super viewDidLoad];

  CCPerson *person = [[CCPerson alloc] init];
  NSLog(person.firstName);
}
```

This two stage `alloc` and `init` pattern is idiomatic to objective-c, although you will often see *convenience* methods added to the class that hide the pattern behind a simpler class method:

```
NSString *stringOne = [[NSString alloc] initWithString:@"Text"];
NSString *stringTwo = [NSString stringWithString:@"Text"];
```

The convenience pattern is usually `stringWith` or `arrayWith` or `objectTypeWith` whatever kind of object you are working with. For example, `stringWithString` is a class method on the `NSString` class that simply calls `[[NSString alloc] initWithString:@"Text"]`.

Not all object's provide convenience methods, so it is essential to be familiar with the `[[... alloc] init]` idiom.

## Custom Constructors

Note that the string constructor methods above take parameters. Let’s write our own constructor method that can take two parameters, the first and last name:

```
- (id) initWithFirstName:(NSString*)inFirstName lastName:(NSString*)inLastName
{
    if ( self = [self init] ) {
        _firstName = inFirstName;
        _lastName = inLastName;
    }
    return self;
}
```

We can write as many custom constructors as we like. The pattern is to declare the method with `- (id) init...`, filling in the rest with a description appropriate to the constructor's functionality.

It is the responsibility of the custom constructor to call the class's *designated initializer*. In a class with more than one constructor, one of those constructors acts as the primary constructor which all other constructors should call.

In our case the designated initializer is simply the overridden `init` method, so the custom constructor calls it. Be careful! Notice that the custom constructor is not calling `[super init]` but `[self init]`. That way we can take advantage of the functionality defined in the subclass's constructor method rather than duplicating it.

We can then instantiate an instance of `CCPerson` with the custom constructor:

```
CCPerson *person = [[CCPerson alloc] initWithFirstName:@"Philip" lastName:@"Dow"];
NSLog(person.firstName);
```

Which is effectively the same as using the default constructor and setting property values:

```
CCPerson *person = [[CCPerson alloc] init];
person.firstName = @"Philip";
person.lastName = @"Dow";
NSLog(person.firstName);
```

## Convenience Class Constructor

Objective-c supports class methods as well as instance methods. Instance methods are marked with the minus sign in the method declaration (`-`) and class methods are marked with the plus sign (`+`). Instance methods are called on instance of a class while class methods are called on the class itself and I believe are called static methods in Java.

Class methods are often defined to create convenience constructors that hide the use of the `[[... alloc] init]` pattern. These are also known as factor methods because they create objects. Let's add a convenience method to the `CCPerson` class that does the same thing as our custom construtor.

First declare it in the header file as a class method:

```
+ (id) personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName;
```

Then implement it in the implementation file, but for the implementation just use the constructor we've already defined:

```
+ (id) personWithFirstName:(NSString*)firstName lastName:(NSString*)lastName
{
  CCPerson *person = [[CCPerson alloc] initWithFirstName:firstName lastName:lastName];
  return person;
}
```

Now we can use the convenience method instead of allocating and initializing the object directly:

```
CCPerson *person = [[CCPerson personWithFirstName:@"Philip" lastName:@"Dow"]];
NSLog(person.firstName);
```

Of course we could define class methods to do other things as well.

## Destructors

We could override the default destructor just as we have overridden the default constructor. That method is called `dealloc`:

```objective-
- (void) dealloc
{
  // ...
}
```

In modern objective-c it is usually not necessary to override `dealloc` to implement custom functionality. ARC will automatically handle the cleanup that used to be required by dealloc, and in fact ARC is writing `dealloc` for us.

There will be special cases where overriding `dealloc` is necessary which will be covered in future chapters.

## Instance Methods

Let's add an instance method to the person class. An instance method begins with the minus sign (`-`) and its implementation has access to other instance methods and an instance's properties through the keywords `self`.

Add an instance method that returns the full name of the person. The header definition looks like:

```
- (NSString*) fullName
```

The implementation looks like:

```
- (NSString*) fullName
{
  return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
```

Don't worry about the use of the `NSString` class method `stringWithFormat` just yet. We'll learn more about that in future chapters.

Pay attention to how the instance method is defined. After the minus sign the return type appears in parenthesis `(NSString*)`. Don't forget the asterisk to indicate we are returning a pointer. The name of the method follows.

The implementation uses the same definition and then implements the body of the function in curly braces `{...}` which should be familiar to you from other languages.

We can then use the instance method by calling it on an instance of the object with bracket notation:

```
[person fullName]
```

## Parameters

Define an instance method that takes parameters using a semicolon `(:)`. After the semicolon specify the type of the parameter in parenthesis, .e.g `(NSString*)` and then name it. The parameter will then be available as a local variable inside the method implementation by its name.

Create an instance method that takes a parameter for adding a prefix such as "Mr." or "Mrs." to the person's name. The method definition looks like:

```
- (NSString*) titledFullName:(NSString*)prefix;
```

The implementation can take advantage of the `fullName` method:

```
- (NSString*) titledFullName:(NSString*)prefix
{
  return [NSString stringWithFormat:@"%@ %@", prefix, [self fullName]];
}
```

The instance method can then be called with arguments by using the semicolon again and placing the argument after it:

```
CCPerson *person = [[CCPerson personWithFirstName:@"Philip" lastName:@"Dow"]];
NSString *name = [person titledFullName:@"Mr."];
```

**Multiple Parameters**

Define a method with multiple parameters be placing a space between the parameters. The second, third, etc parameters include a description, semicolon, type and name that effectively duplicates the content of a single parameter method.

For example, define a second method that takes a prefix and a suffic and append it to the full name. The method definition looks like:

```
- (NSString*) titledFullName:(NSString *)prefix suffix:(NSString*)suffix;
```

Notice that there is a space after the first part of the method definition followed by `suffix:(NSString*)suffix` that mirrors the first part of the method definition after the minus sign and return type.

This method definition illustrates an important aspect of Objective-C method names. This method does not overload the original `titledFullName:` method. It is an entirely different method that is called `titledFullName:suffix:`. Notice the use of semicolons to describe the method name. They are included.

*It is not possible to overload methods in objective-c, but a method can duplicate the name of another method as long as it adds additional parameters*

The implementation for this method looks like:

```
- (NSString*) titledFullName:(NSString *)prefix suffix:(NSString*)suffix
{
  return [NSString stringWithFormat:@"%@ %@ %@", prefix, [self fullName], suffix];
}
```

And it is called as we might call the first method, only name we have something that looks like a named parameter for the suffix:

```
CCPerson *person = [[CCPerson personWithFirstName:@"Philip" lastName:@"Dow"]];
NSString *name = [person titledFullName:@"Mr." suffix:@"PhD"];
```

This style of method declarations and method calls will be strange at first but you will come to appreciate its readiability as you use and write more complex methods