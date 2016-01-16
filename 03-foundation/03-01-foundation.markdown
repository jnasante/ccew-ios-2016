NSFoundation: Basic Objects
=======================================

Covering core objective-c objects used in iOS applications.

## NSString (NSMutableString)

`NSString` is the primary means of encapsulating text in objective-c. It manages the character encoding and underlying data and provides a number of methods for interacting with the string. `NSString` is not mutable, so you will not be able to change the underlying data once you create a string instance.

**String literals**

Most of the time you'll be using string literals when you work with strings. A string literal is instantiated as an instance of NSString but lets you represent text directly in your code.

Use the `@` symbol followed by the string in double quotes:

```objective-c
@"string literal"
```

For example, to assign a string literal to an instance of NSString:

```objective-c
NSString *aString = @"string literal";
```

String literals are no different than objects. Use them for variable assignment or use them directly with other objects.

**Key methods**

We cannot use subscripting operators such as `[]` to get characters in a string. Instead we must use methods on `NSString`. The primary methods for accessing characters at an index or for discovering the length of a string are:

```objective-c
- (unichar)characterAtIndex:(NSUInteger)index;
- (NSUInteger)length;
```

**Example methods**

`NSString` is a huge API that provides dozens of methods such as:

```objective-c
- (NSString *)lowercaseString
- (NSString *)description
```

Example usage:

```
NSString *uppercase = @"UPPERCASE";
NSString *lowercase = [uppercase lowercaseString];

// or more simply:
NSString *lowercase = [@"UPPERCASE lowercaseString];
```

Notice that you can call a method directly on the string literal because the string literal really is an instance of `NSString` once the application is running.

We'll cover a few of the methods here but refer to the documentation for the full API.

**Testing object equality**

There is no operator overloading in obj-c. Using the equals operator (`==`) will check the memory addresses and not the strings themselves. You must use the various `isEqualTo:` methods to check object equality in obj-c.

```objective-c
- (BOOL)isEqualToString:(NSString *)aString
```

For example:

```objective-c
NSString *A = @"A";
NSString *B = @"B";
  
BOOL equal = [A isEqualToString:B];
```

**Combining strings**

Because there is no operator overloading in obj-c methods must be used for basic string operations such as concatenation.

```objective-c
- (NSString *)stringByAppendingString:(NSString *)aString
- (NSString *)stringByAppendingFormat:(NSString *)format ...
```

For example:

```objective-c
NSString *A = @"A";
NSString *B = @"B";
NSString *C = [A stringByAppendingString:B];
```

**Format strings**

A number of methods take format strings which work like `printf` in C. A format string contains escape codes that represent data which should be inserted into the string. The data follows the format string after a comma.

Most of the escape codes are similar to those for `printf` from C based programming languages. The `%@` escape code represents any objective-c object such as another `NSString`, `NSNumber` or anything that responds to the method `description`.

- `%@` for objects 
- `%f` for CGFloat 
- `%d` or `%ld` for NSInteger
- `%u` or `%lu` for NSUInteger
- `%C` for unichar

For example, to insert a number into a string:

```objective-c
NSInteger integer = 42;
NSString *answer = [NSString stringWithFormat:@"The answer is %ld", integer];
  ```
  
Notice how the `%ld` escape code appears in the format string and then the integer follows the string after a comma before the method's closing bracket (`]`). You can embed as many escape codes into a format string as you want. Each additional data value follows the string separated by commas.

To append two strings together with a space between them, try:

```objective-c
NSString *A = @"A";
NSString *B = @"B";
NSString *C = [NSString stringWithFormat:@"%@ %@", A, B];
```

If you don't get your escape codes right Xcode will often make a suggestion for a correction. You should normally allow it to make the recommended fix.

**Working with paths**

You will often have to deal with paths, special strings that represent the location of some resource on the file system. `NSString` provides a number of methods that you should use instead of building the path manually:

```objective-c
- (NSString *)stringByAppendingPathComponent:(NSString *)aString
- (NSString *)lastPathComponent
```

Use these methods instead of building the path manually or trying to substring a path in the right place. Apple reserves the right to change the character which identifies a directory (`/`), and some OS's use different directory identifiers in strings, e.g. `\` instead of `/`.

For example:

```objective-c
// don't do this:
NSString *path = @"path/to/resource";

// do this instead:
NSString *path = [[@"path"
    stringByAppendingPathComponent:@"to"]
    stringByAppendingPathComponent:@"resource"];
```

**Converting a string to a number primitive**

The API provides a number of methods for convering a string to a numeric value.

```objective-c
- (NSInteger)integerValue
// many more ...
```

**Substrings**

Because you cannot subscript into a string to select a character, you cannot substring over a range of characters with the subscript operator either. Instead you must use methods. Similarly you should use methods to identify the range (`NSRange`) of a substring inside another string:

```objective-c
- (NSString *)substringWithRange:(NSRange)aRange
- (NSRange)rangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask
```

For example:

```objective-c
NSString *example = @"ABCD";
NSRange r1 = [example rangeOfString:@"CD"];
NSRange r2 = [example rangeOfString:@"XY"];
```

`NSRange` is a `struct` with two fields, `location` and `length`. In the above example, `r1` is (location: 2, length: 2) and `r2` is (location: `NSNotFound`, length: 0).

`NSNotFound` is a constant defined as the largest integer value and reprsents "not found" for operations involving ranges and strings.

**Mutable strings**

Mutable strings are rarely used. The can be useful if you’re in a tight loop where you’re modifying a single string many times before returning it for further use.

Be aware of object copying rules. *Copying an object always produces an immutable copy.* When you copy an instance of `NSMutableString`, you get an `NSString` back:

```objective-c
NSMutableString *mutable = [NSMutableString stringWithString:@"mutable"];
NSString *string = [mutable copy];
```

This is the case with all mutable classes. Copying any mutable class produces an immutable copy of the original. If you want a mutable copy you must call the `mutableCopy` method instead.

The distinction between copying and mutable copying is important for those memory instructions we discussed earlier, namely those that appear with `@property` declarations.

For example, this will crash your application:

```objective-c
// header
@property (copy, nonatomic) NSMutableString *string;

// implementation
self.string = [NSMutableString stringWithString:@"Some Text"];
[self.string appendString:@"More Text"];
```

with the following message:

Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Attempt to mutate immutable object with appendString:

Why?

**Localizable strings**

You should not hardcode strings that will be presented to the user. In the future your application may be translated into other languages. We need an easy way to ensure that user facing strings can be translated.

Use the function `NSLocalizedString(key, comment)` and hardcode your string as the key. Later on you can then provide localized versions of the *Localizable.strings* file in your project and the system will automatically use the translated version of the string in place of the original.

## NSLog: logging 

The logging facility is provided by the function `NSLog()`. The function takes a format string followed by a comma delimited list of values that should be inserted into the string:

```objective-c
NSLog(@"string: %@ , integer: %ld", string, integer);
```

Xcode may warn you if you try to log a string value directly, in which case you should replace it with a format string and use that to refer to the string value:

```objective-c
// do this:
NSLog(@"%@",aString);

// instead of:
NSLog(aString);
```

## NSNumber

In addition to numeric primitives such as `float`, `int`, and `double` and their foundation counterparts such as `NSInteger` and `CGFloat`, obj-c provides a number class for encapsulating numeric primitives in object instances.

Normally you’ll use the numeric primitives. They are easier to work with, for example, testing equality. However, storing numeric data is simpler with objects as there are built-in means of persisting objects, and you will use objects exclusively with the collection classes.

**Numeric literals**

What is the difference between `3.14` and `@3.14`? Just as obj-c provides a string literal for dealing with an instance of a string object, obj-c also provides numeric literals that instantiate instances of `NSNumber`.

**Methods**

If you examine the class documentation you’ll notice that most `NSNumber` methods deal with wrapping primitive data types and making them accessible again, eg:

```objective-c
NSNumber *number = [NSNumber numberWithInteger:42];
NSInteger integer = [number integerValue];
```
 
Note the `isEqualTo:` variant for `NSNumber` objects:
 
```objective-c
- (BOOL)isEqualToNumber:(NSNumber *)aNumber
```

Just like it is generally easy to convert a string to a number using the `NSString` methods or string formatting, it is also easy to convert an `NSNumber` to a string:

```objective-c
- (NSString *)stringValue
```

Go over the difference between using a primitive property and an object property. Note the absence of the pointer symbol * and the missing memory management hint.

```objective-c
@property (strong, nonatomic) NSNumber * numberObject;
@property (nonatomic) NSInteger numberPrimitive;
```

## NSDate (NSTimeInterval, NSDateComponents)

`NSDate` provides a simple API for getting dates and for getting dates in the future:

```objective-c
NSDate *today = [NSDate date];
```

Other methods:

```objective-c
+ (id)dateWithTimeIntervalSinceNow:(NSTimeInterval)seconds;
```

Time intervals are specified in seconds, and `NSTimeInterval` is type defined to `double`, so you can use decimals for milli- and microseconds.


Dates are timezone agnostic. Log the date. To display a date to a user generally you’ll use `NSDateFormatter` and `NSTimezone` to put it in the appropriate format. To get the components from a date such as the day, month, minute and hour you’ll use the `NSDateComponents` class. 

We won’t cover these classes here, but be aware of them.

## NSURL

NSURL encapsulates URL information including internet addresses and local file paths. Generally you’ll create a URL object with a string literal, or you’ll get it from another method.

```objective-c
+ (id)URLWithString:(NSString *)URLString
```

You’ll use URLs as building blocks for other operations, for example, those involing `NSURLRequest`. Go over the documentation to see the methods.

As for `NSURL` itself you’ll rarely need to do more than get the complete string for the URL or get file path information:

```objective-c
- (NSString *)absoluteString
- (BOOL)isFileURL
- (NSString *)path
```

<!-- IN CLASS EXERCISES -->
<!-- Add some properties for these objects, use them in actions and in our custom classes. -->

