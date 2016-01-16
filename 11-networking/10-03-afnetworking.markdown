Introduction to AFNetworking
====================================

AFNetworking is a set of networking classes created by Matt Thompson. The are based on the built-in suite of CFNetwork and NSURL classes but encapsulate most of the behavior needed to build a robust HTTP client application in objective-c.

In AFNetworking a client is built around a singleton subclass of `AFHTTPSessionManager`. The singleton is configured with a *base url* that points at the primary API access point for the web service. The session manager subclass will handling caching, security, authentication, cookies and other network configuration for requests made to the base url.

The session manager also natively implements the important HTTP request methods such as `GET`, `POST`, `PUT`, and `DELETE`. The methods can be used directly or called from custom methods on the session manager subclass. Wether you choose to manage all your data through your session manager subclass, as we have with other singletons in this class, the session manager should be your single point of access to network resources because of how it handles the above mentioned network configuration.

HTTP requests occur asynchronously, which means they happen as background tasks on a separate thread. The function call that makes the request will return before the request itself is answered over the network. We then need a way for our custom code to be called when the response is received.

One option would be to set delegate methods. AFNetworking instead uses blocks, but in a sense they behave like delegate methods. We need our code to be executed when an event in another class occurs, e.g. when a network response to a request we made is received. So we'll wrap our code is a block function and provide it to the orginal request. The original request will store it until the response is received, and then it will call it.

## JSON

Distributed applications often use either JSON or XML to serialize data and transport it across the network. Serialization just turns the in-memory representation of a data structure into a bit based representation that can be stored on a file system or moved across the network. Deserialization goes the other direction. We've already seen how objective-c serializas `NSArray` objects.

Both JSON and XML are text based formats often employed for serialization. JSON is now the predominant format used in many of the open source technologies that are used to build web-based applications. It is the *JavaScript Object Notation* and is just a way of representing array and dictionary like structures in plain text. AFNetworking includes built-in support for JSON serialization and deserialization. You simply need to use instances of `NSArray` or `NSDictionary` and AFNetworking takes care of the rest.

## Install AFNetworking

Download AFNetworking from the GitHub repository:

[https://github.com/AFNetworking/AFNetworking](https://github.com/AFNetworking/AFNetworking)

Add the AFNetworking folder to your Xcode project. You can just drag it on or Add Files from the File menu. Make sure *Copy items into destination group's folder* is checked.

Link to the following frameworks from the project's application target General, Linked Frameworks and Libraries section:

- MobileCoreServices
- Security
- SystemConfiguration

You may optionally add the UIKit+AFNetworking classes, which provide custom interface components such as network activity indicators. If you do be sure to link to the CoreGraphics framework as well.

## Subclass AFHTTPSessionManager

We'll begin by subclassing `AFHTTPSessionManager`. Create a new subclass and call it `CCSessionManager`. Let's set up a singleton method for creating a shared instance. Recall the basic template:

Header:

```objective-c
+ (instancetype) sharedInstance;
```

Implementation:

```objective-c
+ (instancetype) sharedInstance
{
  static dispatch_once_t once;
  static id sharedInstance;
  
  dispatch_once(&once, ^{
      sharedInstance = [[self alloc] init];
  });
  
  return sharedInstance;
}
```

Let's modify the initilization to establish a base url. The base url is the primary server url our application uses. Then we can use *relative* url paths to reference resources on the server. Change the initialization line to call the class's built-in `initWithBaseURL:` method: 

```objective-c
dispatch_once(&once, ^{
	static NSString *baseURL = @"http://mysterious-hollows-5807.herokuapp.com/";
	sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
  });
```

Note that the baseurl will be application dependent. 

## Making GET Requests

We're now ready to use our session manager. Let's try a basic `GET` request. We'll make a request for the `people` resource on the server. For now let's just put the code in our application delegate. Be sure to import your session manager subclass. We'll use the `AFHTTPSessionManager` `GET` method. Use tab to autocomplete the success and failure block parameters:

```objective-c
[[CCSessionManager sharedInstance] GET:@"people.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
	NSLog(@"%@", responseObject);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
	NSLog(@"%@", error);
}];
```

This function surely looks a little strange. Let's break it down. The first parameter is the relative URL we want to get. I've set up a `/people.json` url on my server. Combined with the base url we initially set, our session manager knows to make an http get request to `http://mysterious-hollows-5807.herokuapp.com/people.json`.

The next parameter is the parameters dictionary for the request. URL parameters are the key-value option pairs that appear after a question mark (`?`) in a URL string, like:

```
http://www.google.com?search=monday
```

Here we have a single `search = monday` key-value pair. Rather than building a string like that manually with all the necessary formating and escape encoding, you can simply pass a dictionary of key-value pairs to the function and the session manager handles the encoding itself.

The third success parameter is a block. Instead of declaring a block variable and assigning a block value to it, we are using an anonymous inline function. The `GET` method will hold onto this block while the rest of our application continues to execute. When the request is received successfully, the GET method decodes the JSON, deserializes it into an `NSArray` or `NSDictionary`, and calls the block function we've provided with the array or dictionary. All we're doing for now is logging the result.

Functions used as callbacks like this are often called *handlers*. We could call this block the *success handler*.

Similarly for the fourth parameter the `GET` method takes a block in case the request fails. If it does the method calls our block with an `NSError` object that describes the reason for the failure. Our code is just logging that object, but we would normally retry the request or inform the user of the problem.

We could call this black the *error* or *failure handler*.

Run the application. You should see the console log an array of dictionaries. Notice that I have designed the server's person properties so that they match the `CCPerson` properties. You will design your objective-c classes so that they match the server data properties already established by your client. Then converting from the dictionaries to your data model and back becomes trivial.

## Using the Results

Still working in our application delegate, let's convert the array of dictionaries to an array of `CCPerson` instances. We already know how to do this. Replace the call to the log in the success handler with the following:

```objective-c
NSMutableArray *mutableItems = [NSMutableArray array];

for ( NSDictionary *aDictionary in responseObject ) {
	CCPerson *person = [[CCPerson alloc] initWithDictionary:aDictionary];
	[mutableItems addObject:person];
}
      
NSLog(@"%@",mutableItems);
```

All we're doing is iterating through the response object and instantiating `CCPerson` instances from each dictionary in it. What would this look like if we used the block enumeration method on `NSArray`?

Run the application. It crashes! What's happening? Examine the crash log:

```
Terminating app due to uncaught exception 'NSUnknownKeyException',
reason: '[<CCPerson 0x8c15eb0> setValue:forUndefinedKey:]: 
this class is not key value coding-compliant for the key url.'
```

It looks like our code is trying to call `setValue:forKey:` with the `url` key on a `CCPerson` object, which is like trying to set the `url` property, but `CCPerson` does not have a url property.

In fact, the json object returned from the server includes a `url` property, and our `initWithDictionary:` method blindly tries to set every property we're getting back from the server.

What are our possible solutions to this problem? I think we could either add a url property to our person object or filter the dictionary in the initialization method so that only a subset of the key-values are set.

The correct solution is application dependent. If the server side data format is locked down you might be ok to simply modify the person object to include a url property. If it is a work in progress with properties changing regularly, you might better filter for the keys you want.

In either case, the application will crash if the server returns a key that is not accounted for in your code. For that reason it is probably generally safer to filter for the keys you know your objective-c object responds to. Unfortunately `NSDictionary` doesn't include an easy way to filter for a subset of keys so we'll just add a url property for now to the `CCPerson`'s header file:

```objective-c
@property (strong) NSString *url;
```

That is the simplest possible solution. Really you might create an `NSURL *URL` property and then in the `setValue:forUndefinedKey:` and `valueForUndefinedKey:` methods convert back and forth between the `url` and `URL` keys and instances of `NSURL` and `NSString`.

For now though run the application and see if it works. Looks like it does. 

## Making POST requests

Following RESTful practices, you create a new resource on a server by posting to the primary URL that is used for viewing a list of those resources. We've seen that you issue a GET request to that url to view the resources. We use a POST request to create one.

We will need to provide a dictionary of values for the post request. We'll create an instance of a `CCPerson`, set its properties, grab the dictionary representation and make the request. Once again will provide success and failure handlers in the form of blocks.

Because of the way the server's API is built, we'll need to pack the person dictionary into another dictionary that takes a single "person" key:

```objective-c
CCPerson *person = [[CCPerson alloc] initWithFirstName:@"Jane" lastName:@"Doe"];
person.phoneNumber = @"(555) 555-6419";
  
NSDictionary *personDictionary = [person dictionaryRepresentation];
NSDictionary *paramsDictionary = @{
	@"person": personDictionary
}; 
 
[[CCSessionManager sharedInstance] POST:@"people.json" parameters:paramsDictionary success:^(NSURLSessionDataTask *task, id responseObject) {
	NSLog(@"Original person: %@", personDictionary);
	NSLog(@"Returned person: %@", responseObject);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
	NSLog(@"%@", error);
}];
```

Comment out the retrieve code and now run the application. Watch the console log. Notice how the returned dictionary is not the same as the sent dictionary. The server typically reservers the right to modify the object you sent it, performing validations, transforming data and adding properties.

*It is always the client's responsibility to merge the data returned from the server with the data originally sent.*

Normally the client's response will be the canonical, correct representation of the resource created and should be used by the client. In a real application we would problably just send a dictionary to the server and only create an instance of `CCPerson` with the data the server sends back, once again checking for valid properties, something more like this:

```objective-c
NSDictionary *personDictionary = @{
	@"firstName": @"Jane",
	@"lastName:": @"Doe",
	@"phoneNumber":@"(555) 555-6419"
};
NSDictionary *paramsDictionary = @{
	@"person": personDictionary
};
  
[[CCSessionManager sharedInstance] POST:@"people.json" parameters:paramsDictionary success:^(NSURLSessionDataTask *task, id responseObject) {
	CCPerson *person = [[CCPerson alloc] initWithDictionary:responseObject];
	// do something with person, but check for the key-value pairs in response object!
} failure:^(NSURLSessionDataTask *task, NSError *error) {
	NSLog(@"%@", error);
}];
```

Comment out this code and uncomment the view code. Run the application again and you will see that the server now responds with three people.

## Getting a Single Person

We can make a GET request for a single person. RESTful API's typically identity objects by their ids. The combination of a resource type encoded into the url and an id identifier uniquely identifies the resource in the application.

Make a GET request to the `/people/:id` url where `:id` is replaced by the person's identifier, which could be a number of more complex string. In our example I know we have a person who's id is `1`, so I'll request that individual. Typically you'll get the ideas from the request to the complete list.

```objective-c
[[CCSessionManager sharedInstance] GET:@"people/1.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
	NSLog(@"%@",responseObject);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
	NSLog(@"%@",error);
}];
```

I could then initialize a `CCPerson` from the response object, again checking for valid key-value pairs.

## Modifying and Deleting a Single Person

RESTful API's use `PUT` and `DELETE` requests to modify an existing resource. Send the request to that resource's url, e.g. `/people/1.json`. Supply a parameter dictionary if you are updating an object and none if you are deleting it.

Here's an example deleting an entry:

```objective-c
[[CCSessionManager sharedInstance] DELETE:@"people/3.json" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
	NSLog(@"%@",responseObject);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
	NSLog(@"%@",error);
}];
```

The response object will be `nil`, which makes sense, but you will definitely run either the success or failure handler and your code should take the appropriate action whatever the value of the response object.

## Final Notes

**Know your client's API**

It will be your responsibility to now your client's API. While they will likely follow the general RESTful pattern's I've introduced here the actual behavior, URL's and returned values will likely be significantly different. Moreover you will have to deal with authentication and other forms of client-server security.

**Organize your code**

Due to time constraints I've only demonstrated the use of the `AFNetworking` library here without properly integrated it into an application. Consider how you might better organize this code, where you would store the resonse data, how you will merge data from the server and from your iOS application, and so on. Always be aware of architectual patterns. What you've learned in class may work, but you might also have better options. 