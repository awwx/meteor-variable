# variable

Reactive variables that contain EJSON values.

This package encapsulates a common case for reactive dependencies:
when you want to have a simple variable that contains an
[EJSON-compatible value](http://docs.meteor.com/#ejson), and you'd
like that variable to be a reactive data source.

When set, the variable only triggers a reactive update if the new
value is actually different than the old one.

```
var weather = new Variable("sunny");

// prints "weather: sunny" as the autorun runs for the first time.
Deps.autorun(function () {
  console.log("weather: ", weather());
});

weather.set("sunny");    // nothing printed, the value hasn't changed
weather.set("hailing");  // prints "weather: hailing"
```

Note that while variables are similar to Meteor’s
[Session](http://docs.meteor.com/#session) object in that they provide
a reactive data source, variables are not a Session replacement:
variables are unnamed and aren’t persisted across hot code pushes like
Session key/values are.  Instead, variables are a basic building block
for developing reactive applications.


## Version

1.1.0

Built for the Meteor package system.  To install:

    meteor add awwx:variable


## API

### new Variable()

**[new] Variable(initialValue)** &nbsp; *Anywhere*

Creates and returns a new variable.  The JavaScript `new` keyword is
optional.

*Arguments*

<dl>
  <dt>initialValue: EJSON-compatible value</dt>
  <dd>The initial value for the variable.</dd>
</dl>


### variable()

**variable()** &nbsp; *Anywhere*

Returns the current value of the variable.  A reactive data source.


### variable.set()

**variable.set(value)** &nbsp; *Anywhere*

Sets the value of the value.  Triggers a reactive update (invalidates
dependent computations) if the new value is different than the old.

*Arguments*

<dl>
  <dt>value: EJSON-compatible value</dt>
  <dd>The new value for the variable.</dd>
</dl>


## Using with isolateValue

The
[isolate-value](https://atmosphere.meteor.com/package/isolate-value)
package can be used to further isolate reactive updates, if needed.

```
var post = new Variable({title: "Greetings", status: "draft"});

function title() {
  return isolateValue(function() {
    return post().title;
  });
}

// does not trigger an invalidation of a computation using title()

post.set({title: "Greetings", status: "published"});
```


## Donate

An easy and effective way to support the continued maintenance of this
package and the development of new and useful packages is to [donate
through Gittip](https://www.gittip.com/awwx/).

Gittip is a [platform for sustainable
crowd-funding](https://www.gittip.com/about/faq.html).

Help build an ecosystem of well maintained, quality Meteor packages by
joining the
[Gittip Meteor Community](https://www.gittip.com/for/meteor/).


## Hire

Need support, debugging, or development for your project?  You can
[hire me](http://awwx.ws/hire-me) to help out.
