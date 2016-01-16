##Debug Assignment5

This simple application displays an image that we've set in Interface Builder, but the application is crashing as soon as it launches.

This time around, an exception break point won't help you. The exception is occurring in system code and not in your code.

How can an exception be occuring in system code? Pay attention to the exception log in the console and think about the message it gives you. This message is similar to saying that the class does not respond to a selector, which means that it doesn't implement the method.

What method is getting called that our class does not implement? Fix it so the class does implement the method.