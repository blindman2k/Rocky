# Rocky Framework

Rocky is a [Squirrel](http://squirrel-lang.org) framework aimed at simplifying the process of building powerful APIs in your [Electric Imp](http://electricimp.com) agent. It allows you to specify callback handlers for specific routes (verb + path), for events such as unhandled errors, and do some other useful things like build authentication and timeouts into your API. Think of it a bit like Node’s [Express](http://expressjs.com), only for Squirrel.

## Rocky Application

## Usage

### Constructor

Instantiate a Rocky application:

```squirrel
app <- Rocky()
```

### Class Properties

The following settings can be passed into Rocky to alter how it behaves:

- ```timeout``` Modifies how long Rocky will hold onto a request before automatically executing the *onTimeout* handler
- ```allowUnsecure``` Modifies whether or not Rocky will accept HTTP requests (as opposed to HTTPS)
- ```strictRouting``` Enables or disables strict routing &ndash; by default Rocky will consider `/foo` and `/foo/` as identical paths
- ```accessControl``` Modifies whether or not Rocky will automatically add Access-Control headers to the response object.

The default settings are listed below:

```squirrel
{
	timeout = 10,
	allowUnsecure = false,
	strictRouting = false,
	accessControl = true
}
```

### Class Methods

## VERB(*path*, *callback*)

The ```VERB``` methods provide the basic routing functionality in Rocky. The following verbs are available: GET, PUT and POST, as *get()*, *put()* and *post()*, respectively. Each takes a URL path as a string and a callback function which will be executed to handle the appropriate request. In each case, the callback takes a single parameter: a Rocy *context* object.

The following snippet illustrates the simplest route handler possible.

```squirrel
app.get("/", function(context) {
	context.send("Hello World")
})
```

Regular expressions may also be used in the path. If you wanted to respond to both `/color` and `/colour` you could create the following handler:

```squirrel
app.get("/colo[u]?r", function(context) {
	context.send(200, { color = led.color })
})
```

## Rocky Context

A Rocky Context object enshrines a single requester-Rocky interaction.

## Usage

### Class Methods

### send(*code*, [*message*])

The *send()* method returns a response to a request made to a Rocky application. It takes two parameters. The first is an integer HTTP status code. The second parameter, which is optional, is the data that will be relayed back to the requester, either a string, an array of values, or a table. Arrays and tables are JSON encoded before being sent.

The method returns `false` if the context has already been used to respond to the request.

```
app.get("/color", function(context) {
    context.send(200, { color = led.color })
})

app.get("/state", function(context) {
    context.send({ state = led.state })
})
```

### setHeader(*key*, *value*)

Adds a header to the internally managed response that will at some point be returned to the requester.

### setTimeout(*timeout*, [*callback*])

Sets the interaction timeout (in seconds) to the value passed into the *timeout* parameter. If the timeout is exceeded, either a standard timeout message will be sent to the requester or, if the optional callback function is specified, the callback will be executed. 

## License

Rocky is licensed under [MIT License](./LICENSE).
