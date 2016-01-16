<!--
Lesson Plan:

1. Do homework assignment simplest way possible
2. Introduce new lesson material with basic examples
3. Incorporate new lesson material into previous homework assignment

4. Reschedule last lesson
-->

Review
=================================

For this lesson we'll focus on previous homework assignments and introduce a couple of new concepts and techniques that will make you a better programmer and are commonly used in iOS development.

We'll begin by going over the last homework assignment. I'll implement it from scratch. Your code should approximately match what I do here.

I'll then introduce the following new concepts and provide some basic examples of their use.

We'll then incorporate what we've learned into the previous homework assignment and *refactor* our code to improve it.

## Singletons

Singletons are used to manage access to shared resources across an application or for objects which should only ever have a single instance in existence.

For example, the `UIApplication` object is a singleton. A running application should only ever have a single instance of `UIApplication` that represents the application internally to itself. That single shared instance can be accessed from different parts of the application with:

```objective-c
UIApplication *app = [UIApplication sharedApplication];
```

That `sharedMethod` application is gauranteed to return the same object every time.

We'll see below that the notification center uses a singleton. A notification center dispatches events between different parts of an application. It is a central location for dispatch. If there were more than one notification center an object might register itself for notifications with the wrong one and not receive events it is interested in.

The shared notification center instance can be accessed with:

```objective-c
NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
```

Again, that `defaultCenter` method is guarnateed to return the same object every time.

We're going to use a singleton object to manage access to our application's database. A database is a shared resource that different parts of the application need access to. At the same time we must ensure that each part of the application has access to the same in-memory representation of the underlying data on the file system.

If we were to use multiple instance of a database object, a change to one might not be reflected in the other, leaving its representation of the underlying data in an inconsistent state. To solve this problem, we can route all database code through a single class which will only ever have a single object of itself ever instantiated.

<!-- Demonstrate this on the board -->

Let's begin with a basic example and then we'll implement the singleton pattern in our code. Create a new iOS project and add an iOS objective-c class to it. Call it `CCDataManager`.

In the header file add the following class method:

```objective-c
+ (instancetype)sharedInstance
```

In the implementation file add the following method implementation:

```objective-c
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
```

What's going on here? Let's break this code down line by line.

`instancetype` is a special type identifier that behaves like `id` but provides extra instruction to the compiler. We'll use it to mean that we will be returning an instance of this class.

We then use two static variables. Even those these variables are local to the method, `static` instructs the compiler to retain the memory used by the variable across the entire lifetime of the program. The variables are not global; we cannot access them from other methods. But they will not be released when they fall out of scope, that is when the method returns.

Effectively, this means that once a static variable is set to a value, it retains the value across multiple calls to the method.

The static variables are used by this strange looking `dispatch_once` method. We won't go into too much detail here, but `dispatch_once` belongs to the iOS's grand central dispatch API which manages access to multiple process cores simultanously. One of the ways it does this is by accepting blocks of code known as *closures* and routing them to unused processer cores for execution.

This isn't important for us here. If you're interested refer to the Grand Central Dispatch (GCD) documentation. Import for us is that `dispatch_once` uses a kind of token to ensure that the code block is only ever executed one time. Internally the method checks the token and if it isn't set it executes the code block, otherwise it just returns.

We'll learn about code blocks in our lesson on networking, so let's not worry about the syntax just yet. We can see though that our code block here does a single thing: it allocates and instantiates and instance of this class. Note the use of `self` here. In the context of a class method it means the class itself, not an instance of it. So we could have written something like:

```objective-c
dispatch_once(&once, ^{
	sharedInstance = [[CCPersonManager alloc] init];
});
```

But `self` is idiomatic and prefered.

Finally the method returns the shared instance.

Don't worry if you don't quite understand this code. It's fairly advanced objective-c and we haven't covered all of the material yet. What we do need to understand is the behavior.

*This method is guaranteed to return the same object instance every time it is called.*

The first time the method is executed, `sharedInstance` is `nil` and the `once` token hasn't been set. `dispatch_once` sets the token and calls the block, which creates an instance of the class and assigns it to `sharedInstance`. Because the variable is marked as `static` it won't be freed from memory after the method returns. Finally the method returns the `sharedInstance`.

Every other time the method is called `dispatch_once` will see that the  `once` token is set and skip the block. All that happens is that the previously instantiated static instance is returned.

This means that we can access the same instance of the object from multiple places in our application using:

```objective-c
CCPersonManager *manager = [CCPersonManager sharedInstance];
```

That object is otherwise treated as a normal object. We can add methods, properties, and so on. Importantly, if we set the value of a property from one part of the application the instance will retain that value in another part of the application even if those two bits of code are otherwise unrelated.

Let's see an example (in class).

We'll understand why this is useful when we make changes to our homework assignment.

## Notifications

Notifications are used to pass information between objects without those objects needing to know anything about one another. Normally in order for an object to pass information to another object it must call method, and so it needs to know the name of that method. This is always the case with object-oriented programming and we've seen how it especially applies with delegate methods and protocols.

With notifications, an object can simply let a 3rd party central dispatcher know that something has happened. That is, it calls a method on the central dispatcher, also known as posting a notification. The dispatcher will then let other interested objects know that the event has taken place. It can do this because those other objects have registered with the dispatcher to receive the notification.

In this case, the dispatcher is mediating the flow of information between two objects. The objects must know how to register and post with the dispatcher, and they'll need a way to identify which notification they're listening for or posting, but otherwise they don't need to know anything else about each other, notably any of the methods they implement or even what class they are.

We'll see that two important classe implement notifications on the iOS. Notifications are dispatched through `NSNotificationCenter`. Register an object with the notification center to receive notifications use it from other objects to post notifications to the center. `NSNotification` will encapsulate information about the posted notification such as its name, the object that posted and other data known as *user info* that is stored in a dictionary.

**Notification constants**

Defining a notification constant. In the implementation file declare a string variable with a constant value. Use the same text for the value of the string and for its identifier. Place the declaration after your `import` statements but before your `@implementation` declaration.

```objective-c
NSString * const CCPersonManagerCreatedPerson = @"CCPersonManagerCreatedPerson";
```

Then to make this constant available to other classes, add an `extern` reference to it in the header file:

```objective-c
extern NSString * const CCPersonManagerCreatedPerson;
```

The `extern` statement lets the compiler know that the variable is defined elsewhere even though it is declared here, namely it is defined in the implementation file, and because other classes will import this header file they will have access to the identifier and can use it.

**Posting a notification**

Posting a notification allows an object to let any other object know that some event has take place without needed to know anything else about that object. The two classes are entirely decoupeld from one another. Posting a notification is a bit like calling a delegate method except that no explicit delegate is registered and there may be more than one object waiting to receive the notification.

Post a notification by calling the appropriate method on the shared notification center:

```objective-c
[[NSNotificationCenter defaultCenter]
      postNotificationName:CCPersonManagerCreatedPerson
      object:self
      userInfo:nil];
```

Provide a string value for the name, which should be a constant declared `extern` in some header file and defined in the corresponding implementation file.

You may optionally specify the object that is posting the notification, which will typically be the object itself but could be another object. And you may provide a *user info* dictionary which is just a set of relevant key-value pairs.

Upon posting the notification, the noficiation center will immediately dispatch it to registered listeners. The dispatch takes place before the post method returns.

**Receiving a notification**

Another class but maybe even some other part of the class posting the notification registers with the notification center to receive the notification. It uses the `addObserver: ...` method to register itself and at a minimum must provide the name of the notification it is interested in listening for and a method to call when the notification is posted:

```objective-c
[[NSNotificationCenter defaultCenter]
		addObserver:self
		selector:@selector(didCreatePerson:)
		name:CCPersonManagerCreatedPerson
		object:nil];
```

Typically the class registers itself with `self` to receive the notification.

It provides the name of the method that should be called when the notification is posted, namely `didCreatePerson:` which, do note, takes a single argument. The method is passed as an argument by using this `@selector(...)` statement which allows objective-c to refer to a method on an object by its name in variables.

Next the name of the notification is provided and finally the object that will be posting the notification. Use `nil` to receive the notification from any object, although here we could have used `[CCPersonManager sharedInstance]`.

It is then the responsibility of the class to actually implement the callback method it has specified with the `@selector()` statement. The method takes a single argument that is guaranted to be an instance of `NSNotification`:

```objective-c
- (void) didCreatePerson:(NSNotification*)aNotification
{

}
```

The notification object encapsulates information about the notification and provides methods for getting the name, object and user info dictionary from it:

```objective-c
- (void) didCreatePerson:(NSNotification*)aNotification
{
  NSString *notificationName = [aNotification name];
  NSDictionary *userInfo = [aNotification userInfo];
  id postingObject = [aNotification object];
}
```

## Refactoring

According to Wikipedia [1], 

>Code refactoring is the process of restructuring existing computer code – changing the factoring – without changing its external behavior. Refactoring improves nonfunctional attributes of the software. Advantages include improved code readability and reduced complexity to improve source code maintainability, and create a more expressive internal architecture or object model to improve extensibility.

Refactoring allows us to improve our code without changing what it does. The improvements are typically human-oriented. Refactoring doesn't improve the efficieny of our code or fix bugs, instead it usually changes how the code is organized so that it is easier for humans to understant it, and importantly, for humans to change it later on.

There are a number of standard refectorings, covered in Martin Fowler's book Refactoring, Improving the Design of Existing Code [2]. Here we will focus on refactorings that abstract behavior or functionality into another part of the application and expose it in an API. More simply, we're going to take a bunch of code and stick it into a method or another object. This will make our code more readable and more re-usable.

Refactoring is a practical exercise and so there will be no examples here. Instead we'll refactor the homework assignment from the last lesson.

**Composed methods and encapsulation**

As I said we'll be using two general approaches that you can apply to your own code. Both look for code that doesn't belong where it is and moves it somewhere else where it does belongs

In the first case this means taking code that is not directly related to what a *method* does and moving it to another method.

In the second case this means taking code that is not directly related to what a *class* does moving it to another class.

Both result in better encapsulation, in which application behavior is hidden behind well named classes and methods. The result is that one method will call many methods to accomplish pieces of its implementation rather than place all of that behavior in the method itself.

Both will also often yield composed methods. Composed methods are short methods that perform one thing and one thing well and often without side effects. That is, they do *x* and do nothing else. Short methods are easier to read, easier to change and easier to re-use.

Finally, both will often remove repetitive code. If you find you are copy and posting blocks and code with minor changes each time, you're doing it wrong. Look for ways to encpasulate the behavior.

An ideal you should aim for is to have no method be longer than one screen full of information, laptop size. That way you can see at a glance everything the method does.

**Write, refactor and repeat**

Refactoring is for code what editing is for writing. And just as a writer goes back and forth between creative work and editing, you should also consciously operate in two modes of coding and go back and forth between writing code and editing it.

The first code you write when you tackle a problem should not be the last, because typically your first solution to a problem will not be your best one. Pause to examine code you've already written and look for ways to improve it using the approaches we've discussed here. And especially as your application grows and grows in complexity be on the look out for ways to refactor it.

<hr>

[1] [Code Refactoring on Wikipedia](http://en.wikipedia.org/wiki/Code_refactoring)

[2] [Fowler's Refactoring on Amazon](http://www.amazon.com/Refactoring-Improving-Design-Existing-Code/dp/0201485672)