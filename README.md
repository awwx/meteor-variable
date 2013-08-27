# variable

Simple reactive variables that contain EJSON values.

This package encapsulates a simple but common case for reactive
dependencies: when you want to have a simple variable that contains an
[EJSON-compatible value](http://docs.meteor.com/#ejson),
and you'd like that variable to be a reactive data source.

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

Note that variables are unnamed, and so are not a general Session
replacement: they aren't persisted across hot code pushes like
Session key/values are.


## Version

1.0.0

Meteor linker supported:
This implementation works with both pre-linker Meteor (0.6.4.1 and
below) and the new "linker" version of Meteor (0.6.5-rc12 and above).


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


## Support

Support the ongoing maintenance of this package by making a weekly
contribution of your choice with
[Gittip](https://www.gittip.com/awwx/).

Not sure what to give?  While the amount is entirely up to you, a
weekly contribution of $1 is useful if you're relying on this package
for something important and you want to help ensure that the package
doesn't suffer from bitrot.  25&cent; is a cool amount for a personal
contribution.

Help build an ecosystem of well maintained, quality Meteor packages by
joining the
[Gittip Meteor Community](https://www.gittip.com/for/meteor/).
