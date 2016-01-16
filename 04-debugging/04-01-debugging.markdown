Debugging
===================================

...

## NSLog

Using `NSLog()`. Writes to the console in Xcode and to the system log in a production application.

Viewing console output: the Debug area and the Console. View toolbar item and the split view in the console.

Using formatters in `NSLog`, like `NSString` formatting. Printing objects, implicitly using the `description` method.

Logging to see check if a method is being called.

Logging will often be your first line of attack when debugging your programs but it should not be your last.

## Breakpoints

Setting breakpoints, temporarily disabling a breakpoint, disabling all breakpoints, removing breakpoints. Viewing a project’s breakpoints.

Breakpoints can show you if a method is being called and a lot more.

Examining objects. Auto, local variables. Use of `self` when debugging. Printing a variable to the console. Ctrl-click for context menu.

Stepping through the call stack and using the Debug Navigator. For example when pressing the Done navigation button when working with a Utility application.

Point out the other tabs in the navigator: breakpoints and call stacks then symbols, warning, and project search.

## Exceptions

Debugging exceptions. Break the app by accessing an out of bounds array and by calling a method on an object that does not exist. Note the message in the console.

But if we have a large project and we aren’t sure where this is happening, how can we find out? Enable exception breakpoints that often but not always drop us directly into the code where the exception is being raised.

Obj-C does offer facilities for exception handling but you’d be surprised how rarely we use it in our own code, and it is beyond the scope of this lecture.

