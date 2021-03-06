// Copyright (c) 2015 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT

#require "Rocky.class.nut:1.0.0"

/******************** Application Code ********************/
led <- {
    color = { red = "UNKNOWN", green = "UNKNOWN", blue = "UNKNOWN" },
    state = "UNKNOWN"
};

device.on("info", function(data) {
    led = data;
});

app <- Rocky();

app.get("/color", function(context) {
    context.send(200, { color = led.color });
});
app.get("/state", function(context) {
    context.send({ state = led.state });
});
app.post("/color", function(context) {
    try {
        // Preflight check
        if (!("color" in context.req.body)) throw "Missing param: color";
        if (!("red" in context.req.body.color)) throw "Missing param: color.red";
        if (!("green" in context.req.body.color)) throw "Missing param: color.green";
        if (!("blue" in context.req.body.color)) throw "Missing param: color.blue";

        // if preflight check passed - do things
        setColor(context.req.body.color);
        context.send({ verb = "POST", color = led.color });
    } catch (ex) {
        context.send(400, ex);
        return;
    }
});
app.post("/state", function(context) {
    try {
        // Preflight check
        if (!("state" in context.req.body)) throw "Missing param: state";
    } catch (ex) {
        context.send(400, ex);
        return;
    }

    // if preflight check passed - do things
    setState(context.req.body.state);
    context.send({ verb = "POST", state = led.state });
});

