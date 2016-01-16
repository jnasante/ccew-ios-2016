Introduction to Blocks
==============================

Blocks, or closures as they are known in most programming languages, provide a way to capture a block of code both as a function and as a value like a number or string and pass it around between other functions or assign it to variables. A block passed around like this can be stored and then called at a later time, allowing other parts of the application to decide when the code will be used.

Importantly, closures are so-named because they enclose around the environment, or scope, in which they are defined. That means they capture both local and non-local variables and carry those variables with them into other scopes, so that a block has access to local variables even after the function in which the block was defined has returned.

The trick with blocks is to remember that a block is both a function and a value. It is a function that encapsulate a section of code in your application, and a function has a return type and a parameters list. But it is also a value, which means it can be assigned to variables and passed to other functions.

We'll see that it is common to pass a block *anonymously* to a function, where the block is used almost like a string literal and embedded in the functional call rather than assigned to a variable first.

## Block Syntax

Blocks introduce a new syntax into objective-c that you will need to become familiar with. There are a couple of language additions that differ slightly depending on whether you are defining a new block type, like you might define a variable type or `struct` in C, or are using a block value.

**Defining a block type**

In all cases, the caret (`^`) is used to indicate that a particular section of code involves a block. When defining a block type you must include information that a function definition would expect. You must supply a return value, a parameters list, and because you are declaring a new type, an identifier for the type that you will use to declare variables of that type.

In a block type definition, you will see the return type followed by an open parenthesis, the caret, the type identifier, a closing parenthesis, and then a C-like function argument list. It looks like this:

```objective-c
typedef void(^CCMyBlock)(NSString *param);
```

Compare that to a function definition:

```objective-c
void cc_my_block(NSString *param);
```

They are quite similar, but with the block we are defining a new type of value rather than naming the function.

I added the above to a header file in a project. Use Xcode's autocomplete template that appears once you start typing `typedef`.

The block statement above defines a new type of variable, like defining a `struct` in C. I can use that varaible type in function definitions or create locally scoped variables of that type in functions:

In a function definition:

```objective-c
- (void)functionWithBlock:(CCMyBlock)myBlock;
```

As a local variable:

```objective-c
CCMyBlock block;
```

Notice that neither uses the asterisk (`*`), which is confusing because a block is treated like a pointer variable and its memory is managed by automatic reference counting (ARC).

**A block value**

Where we have variables we have values. What gets assigned to a block variable? Naturually a block of code. I said that a block is just a bunch of code. That's true, but it is code that is wrapped inside a locally defined function, and the function's signature must match the block's type definition.

What I mean is that any code can appear in a block but it must belong to a function whose return type and parameter list match the return type and parameter list defined when the block type was declared.

In our example above we have a block that returns `void` and takes a single parameter of type `NSString`. We can assign a block function to the block variable that matches this signature like:

```objective-c
CCMyBlock block = ^void(NSString *param) {
	NSLog(@"You called the block with %@", param);
};
```

What we are doing here is assigning an unnamed function to the block variable. Once again we use the caret (`^`), only this time it is followed by the return type `void` and then the parameter list in parenthesis `(NSString *param)`. We then use curly braces as we normally would and place our code inside them.

*This is a function that we have assigned to a variable*

Normally when the block's return type is `void` we leave it out of the assignment:

```objective-c
CCMyBlock block = ^(NSString *param) {
	NSLog(@"You called the block with %@", param);
};
```

<!-- Make change to the block type definition and change the block assignment accordingly -->

**Calling a block**

Now that we have a `block` variable of type `CCMyBlock` we can pass it to functions that type blocks of that type as arguments. We defined one such function. Let's call it:

```objective-c
[self functionWithBlock:block];
```

`block` looks just like a normal variable that we pass around, but remember, it actually contains a function *that we can call*.

Let's implement the `functionwithBlock` method. Templaing it out it looks like any other objective-c method:

```objective-c
- (void) functionWithBlock:(CCMyBlock)myBlock
{

}
```

Remember that *a block is a function*, so myBlock is a variable that whose value has captured a block of code as a function. That means we can call it.

Moreover, `myBlock` takes a single parameter of type `NSString`, so when we call, and we will call it like a normal C function, we must provide a string argument:

```objective-c
- (void) functionWithBlock:(CCMyBlock)myBlock
{
  myBlock(@"The parameter");
}
```

Wild, right?

**Other syntax differences**

There are other, subtle differences in declaring block types inline for properties and functions. Refer to this stack overflow answer for the details:

[Block Syntax on Stack Overflow](http://stackoverflow.com/questions/9201514/block-declaration-syntax-list)

## Block Scope

I said that a block captures the environment in which it is defined. What does that mean? Define a variable outside the block but use it inside the block, like so:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    NSString *localVariable = @"local variable";
  
    CCMyBlock block = ^(NSString *param) {
      NSLog(@"%@", localVariable);
      NSLog(@"You called the block with %@", param);
    };
  
    [self functionWithBlock:block];
}
```

The string `localVariable` is defined locally inside the `viewDidLoad` method. Normally this variable would fall out of scope when we call `functionWithBlock`, but because a block is a closure, it captures that variable and carries it around with it, so that when we call `myBlock()` from `functionWithBlock`, the block function still has access to the variables defined within its referencing scope even though that scope is no longer valid.

## Anonymous, Inline Blocks

Blocks are often used without first assigning them to a variable. This is no different from using a value without first assigning it to a variable. A parallel construnction with string literals looks like:

```objective-c
// assign to a variable
NSString *parameter = @"some value";
[self doSomething:parameter];

// use directly
[self doSomething:@"some value"];
```

We can do the same thing with blocks. Let's take the value we assigned to `block` and use it directly in the call to the function:

```objective-c
[self functionWithBlock:^(NSString *param) {
	NSLog(@"%@", localVariable);
	NSLog(@"You called the block with %@", param);
}];
```

Notice that we have simply replaced the use of the variable with the value we were assigning to it. You end up with some strange looking syntax like the caret and parameter list in the function call and the `}];` at the end of everything.

This will be how you normally use blocks in objective-c. Don't worry too much if you had a tough time understanding block type definitions, as you may never declare your own block type for your project, but you will use blocks often, in fact in all of your networking code, so it is more important that we know how to call functions that take blocks than define our own block types.

## Example: Using Blocks Instead of Loops

We've seen a couple of ways to loop over an array of objects in objective-c. There is the standard for loop:

```objective-c
NSArray *ints = @[@0, @10, @20, @30];
  
for (NSInteger i = 0; i < [ints count]; i++) {
	NSNumber *number = ints[i];
	// do something with number
}
```

There is the "fast enumeration" syntax:

```objective-c
NSArray *ints = @[@0, @10, @20, @30];
  
for (NSNumber *number in ints) {
	// do something with number
}
```

But we can also use blocks. A for loop in fact encapsulates a block of code and executes it once for each item in an element. In the standard for loop you might imagine that the for loop construct calls the block with the current index as a parameter, while in the fast enumeration loop it calls it with the item from the array itself. We could make this construction explicit with a block:

```objective-c
NSArray *ints = @[@0, @10, @20, @30];
  
[ints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
	// do something with obj
}];
```

The method `enumerateObjectsUsingBlock:` is part of the `NSArray` API. It takes a single block as a parameter, and that block has a function signature with `void` return type and three paramaters of type `id`, `NSUInteger`, and `BOOL*` respectively.

For each object in the array the function calls the block with the object, the index and `BOOL` value by reference which your code can set to `NO` to stop the enumeration.

What would the implementation of that function look like? Try to work this out on your own before seeing the sample code at the end of this section.

**Dictionary enumeration**

We can also enumerate `NSDictionary` with a block:

```objective-c
NSDictionary *dict = @{
	@"A": @"1",
	@"B": @"2",
};
  
[dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
	// do something with key and obj
}];
```

Here the `enumerateKeysAndObjectsUsingBlock:` method calls the block once for each key-obj pair in the dictionary.

## Blocks and Memory

We should be aware of a possible memory leak with blocks that automatic reference counting (ARC) cannot fix.

Recall that blocks capture the environment in which they are defined. Locally defined variables that are used in the block are held onto and managed by ARC so that their memory is freed once the block itself is freed. That is, ARC implicitly keeps a *strong* reference to the variables.

The trouble is that a block which references `self` also takes hold of `self` strongly and won't release it until the block is freed. In some circumstances, such as if the block is assigned to a property on `self`, then self will maintain a strong reference to the block. When two objects maintain strong memory references to one another the result is a *retain cylce* and neither object will ever be freed from memory.

The solution is to explicitly indicate to ARC that `self` should be captured weakly from the block, thus breaking that side of the retain cycle. A variable can be marked for weak capture with the `__weak` attribute added to the variable declaration.

A common practice is then to replace all references to `self` within a block with a `weakself` variable defined outside the block as a weak reference to self, like this:

```objective-c
__weak id weakself = self;
[dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
	[weakself callSomeMethod]; // instead of [self ...]
}];
```

If you want dot notation access to properties on `weakself` you'll need to include its type explicitly rather than using `id`.

## NSArray enumerateObjectsUsingBlock:

Here's what the implementation of `enumerateObjectsUsingBlock:` might look like.

Header:

```objective-c
- (void) myEnumerateObjectsUsingBlock:( void (^)(id obj, NSInteger idx, BOOL *stop) )block;
```


Implementation:

```objective-c
- (void) myEnumerateObjectsUsingBlock:( void (^)(id obj, NSInteger idx, BOOL *stop) )block
{
  for (NSInteger i; i < [self count]; i++) {
    id obj = self[i];
    BOOL stop = NO;
    
    block(obj, i, &stop);
    
    if (stop) {
      break;
    }
  }
}
```

Notice that all this function is really doing is encapsulating the commonly repeated for loop pattern into a method on `NSArray`. Internally the actual function probably optimizes to make it as fast and efficient as possible.