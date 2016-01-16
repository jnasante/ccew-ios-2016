##Debug Assignment 3

This application is the same as in Debug 2, but it still isn't working! Now the method is getting called, but the lowercase text is not being set on the label. Can you fix it?

Hint: set a breakpoint in the method and look for a `nil` value inside the self object in the Debugger Variables view. A `nil` value shows up as `0x00000000` and means that nothing has been set to this variable (a property in this case). Why is this variable `nil`?