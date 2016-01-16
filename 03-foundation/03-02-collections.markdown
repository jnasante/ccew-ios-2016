NSFoundation: Collections
=======================================

Objective-c provides a number of objects for dealing with collections of objects. A collection is just a data structure that contains many objects. The implementation details of the data structure are abstracted away so that the application programmer does not have to deal with them. Instead, as objective-c developers, we simply have access to a number of useful objects for storing and manipulating collections of objects.

## NSArray (NSMutableArray)

An array is an ordered collection of objects and is represented by the `NSArray` class in Obj-C. Unlike Java, an array in Obj-C is not limited to a collection of similar objects, such as an array of strings or an array of numbers. In Obj-C an array is a collection of any type of object and can include a mix of numbers, strings, other array, dictionaries, or any other class, including classes of your own creation.

**Building arrays**

There are two ways to create arrays. You can use a class or instance methods, or you can use a literal notation like we’ve seen with strings.

In the past methods were always used, and you will still encounter code that uses these methods:

```objective-c
+ (id)arrayWithObject:(id)anObject
+ (id)arrayWithObjects:(id)firstObj, ...

- (id)initWithObjects:(id)firstObj, ...
```

For example,

```objective-c
NSArray *array = [NSArray arrayWithObjects:aDate, aValue, aString, nil];
NSArray *array = [[NSArray alloc] initWithObjects:aDate, aValue, aString, nil];
```

**Nil**

Notice how the list is nil terminated. `nil` with a lowercase 'n' is like `NULL` and is a primitive value in Obj-C. It evaluates to false. Unlike many programming languages, it is ok to send messages to `nil`, and in fact this is idiomatic. That means you don’t necessarily need to check the return value of a method that might return a `nil` value before calling a method on it. Of course, you might still need to check for `nil` anyway as part of the application logic.

Also notice that are arrays are not statically typed to a single kind of object, as in Java. Arrays may contain any blend of objects in Objective-C.

**Array literals**

The newer array literals syntax allows you to create arrays more simply. Use the `@` symbol as you do for string literals and bracket the objects in the array:

```objective-c
NSArray *array = @[aDate, aValue, aString];
```

Note that it is not necessary to `nil` terminate an array literal, and in fact doing so will prevent your application from compiling. 

Also note that `nil` and other primitive values cannot appear in an array. `nil` is a primitive, not an object, and arrays can only contain objects. Attempting to populate an array with `nil` will result in an exception being thrown and your application crashing.

You can embed other literals inside the array literal, such as numeric and string literals, to quickly build arrays out of basic objects:

```objective-c
NSArray *array = @[ [NSDate date], @3.14, @"A string"];
```

Whereas in the past, in order to do this you would have had to write:

```objective-c
NSArray *array = [NSArray arrayWithObjects:[NSDate date], [NSNumber numberWithDouble:3.14], @"A string", nil];
```

The recommended practice is to now use array literals when creating arrays, although you will still see the older method based code.

**Accessing elements**

As with array creation you may access arrays with methods or with a standard subscripting syntax. Modern objective-c prefers subscripting:

```objective-c
id anObject = array[0];
```

The common array methods, including accessing an element at an index, are:

```objective-c
- (NSUInteger)count
- (id)objectAtIndex:(NSUInteger)index
```

When you have an object and want information about its position in the array, use:

```objective-c
- (BOOL)containsObject:(id)anObject
- (NSUInteger)indexOfObject:(id)anObject
```

There are a number of variations on these methods allowing you to restrict the range you’d like to examine and so on. Refer to the documentation.

**Array enumeration**

There are three ways to enumerate an array in Obj-C. You may use the classic `for` loop or you may use what is called fast enumeration with a `for ... in` loop. A third approach uses blocks, an advanced topic we will address in later chapters.

To enumerate an array with a `for` loop:

```objective-c
for ( NSInteger i = 0; i < [array count]; i++ ) {
    NSString *aString = array[i];
    // use aString
}
```

To enumerator an array with a `for ... in` loop:

```objective-c
for ( NSString *aString in myArray ) {
    // use aString
}
```

The first approach is clearly more verbose than the second. In general you will use fast enumeration with a `for ... in` loop but sometimes you may need to track the index for other reasons, so be familiar with both.

**Mutable arrays**

Arrays are not mutable by default. Once you create an array you cannot add or remove objects from it. If you want to work with a mutable array you must use the `NSMutableArray` class instead.

You create a mutable array using the class methods or two stage creation:

```objective-c
NSMutableArray *myArray = [NSMutableArray arrayWithObjects:aDate, aValue, aString, nil];

NSMutableArray *myArray = [[NSMutableArray alloc] initWithObjects:aDate, aValue, aString, nil];
```

Notice that the methods are the same as though used for `NSArray`; only the class has changed. `NSMutableArray` subclasses `NSArray` and overrides these methods. In fact anything you can do with an immutable array you can also do with a mutable array.

Because the mutable array allows for mutation, you can add, insert, remove and replace objects:

```objective-c
- (void)addObject:(id)anObject
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
- (void)removeObjectAtIndex:(NSUInteger)index
```

There are a number of variations on these methods. Refer to the documentation.

## NSDictionary (NSMutableDictionary)

Cocoa supports hashes through `NSDictionary`. A hash is a collection of keys and values, with each key mapped to a single value. Keys in a dictionary must be unique: you can only have one copy of a specific key at a time. But values can appear as many times as you like.

Question: under what conditions might this occur?

**Creating dictionaries**


As with arrays, dictionaries can contain any kind of key and any kind of value, and the types can be mixed. With a caveat, keys must be capable of being copied. Basic objects such as strings, numbers, dates and so on can all be copied, but interface objects such as views, buttons and labels cannot be copied. In general, you will use strings as keys.

As with strings, we now have dictionary literals which look a lot like hashes in ruby or python. But again, you will encounter a lot of old code which builds dictionaries using the class or instance methods, so you should be familiar with these. There are a number of ways to do this, but my preferred method is:

```objective-c
+ (id)dictionaryWithObjectsAndKeys:(id)firstObject , ...
```

For example:

```
NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
```

Each entry in the dictionary is an value-key pair. So that `key1` points to `value1` and `key2` points to `value2`. Make sure you don’t confuse the order!

**Dictionary literals**

The new dictionary literals are similar to array literals and look very much like ruby or python hashes/dictionaries. Again, use the @ symbol and this time surround your key value pairs with curly braces. Key-value pairs are separated by commas and are distinguished using the colon:

```objective-c
NSDictionary *dictionary = @{ @"key1" : @"value1", @"key2" : @"value2" };
```

Because dictionaries can contain any kind of value, including strings, numbers, array, and even other dictionaries, dictionary literals can become quite complex. Break the keys and values by line -- Obj-C doesn’t care, and it starts to look a lot like JSON, or the javascript object notation language:

```objective-c
NSDictionary *dictionary = @{
	@"key1" : @"value1",
	@"key2" : @"value2",
	@"key3" : @3.14,
	@"key4" : @[ @"this", @"is", @"an", @"array", @"of", @"string" ],
	@"key5" : @{
		@"another" : @"dictionary",
		@"embedded" : @"in",
		@"the" : @"first"
	}
};
```

**Accessing elements**

Once you’ve created a dictionary you can pull objects out of it with methods or using a named subscript syntax. The methods are:

```objective-c
- (NSUInteger)count
- (id)objectForKey:(id)aKey
```

For example, this method returns the `@"value2"` string:

```objective-c
NSString *value = [dict objectForKey:@"key2"];
```

Dictionaries also support the subscripting syntax for accessing elements:

```objective-c
NSString *value = dict[@"key2"];
```

**Dictionary enumeration**

You can pull out all the keys or values for a dictionary with:

```objective-c
- (NSArray *)allKeys
- (NSArray *)allValues
```

Generally you won’t need to do this. Dictionary enumeration, on the other hand, is quite common, and there is a fast enumeration equivalent for dictionaries:

```objective-c
NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    
for ( id aKey in dictionary ){
    id aValue = [dictionary objectForKey:aKey];
    // use the key and value
}
```

Dictionary enumeration iterates through the dictionary’s keys, which you can then use to get the values. This is equivalent to doing:

```objective-c
for ( id aKey in [dictionary allKeys] ) { ...
```

**Mutable dictionaries**

Like arrays, dictionaries are by default immutable. If you want a dictionary that you can add and remove key-value pairs from, create a mutable dictionary using the alloc-init pair or using a convenience method:

```objective-c
NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
```

You alter a mutable dictionary using the following methods:

```objective-c
- (void)setObject:(id)anObject forKey:(id < NSCopying >)aKey
- (void)removeObjectsForKeys:(NSArray *)keyArray
```

Notice the use of id here and the `NSCopying` protocol. A key can be any object type as long as it conforms to the `NSCopying` protocol, which is another way saying, as long as it can be copied. Notably, interface elements do not conform to this protocol and so cannot be used as keys in dictionaries.

## NSSet (NSMutableSet)

Objective-c also provides classes for dealing with sets. Arrays typically suffice. We will not cover the set classes in this chapter but you should be aware of them for applicable use cases.