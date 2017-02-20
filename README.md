# do-deep [![Build Status](https://travis-ci.org/braveg1rl/do-deep.png?branch=master)](https://travis-ci.org/braveg1rl/do-deep) [![Dependency Status](https://david-dm.org/braveg1rl/do-deep.png)](https://david-dm.org/braveg1rl/do-deep)

[![Greenkeeper badge](https://badges.greenkeeper.io/braveg1rl/do-deep.svg)](https://greenkeeper.io/)

Functions to access properties of nested objects.
Reading and modifying values work very similar to what how things normally work.
Things work differently if a property along the path does not exist:
- `dd.get` will return `undefined`
- `dd.set` will create the objects it needs to assign the value to the final property

There are two ways to address a property:

1. By a string, similar to what you'd write in JavaScript. Here, camel-casing is enforced
2. With an array of property names. Here you can use any kind of strings.

## Usage

```javascript
var dd = require("do-deep")

var someObject = {} // you probably want some data here, but do-deep can live without
var nestedValue = dd.get(someObject, "a.a.a")
var otherNestedValue = dd.get(someObject, ["b"]["b"]["b"])

dd.set(someObject, "a.b.b", "c")
// returns 3, because 3 properties were changed (two objects created, one string assigned)

var nextLetter = {"a":"b"}
dd.set(nextLetter, "a", "b")
// returns 0, to inform that no change was made to the object at all.

```

There's also `increment`, `decrement`.

`dd.increment(object, "c.c", 2)` increases the value in `object.c.c` by `2`.

## License

do-deep is released under the [MIT License](http://opensource.org/licenses/MIT).
Copyright (c) 2017 Braveg1rl
