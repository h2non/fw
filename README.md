# fw [![Build Status](https://travis-ci.org/h2non/fw.svg?branch=master)][travis] [![Dependency Status](https://gemnasium.com/h2non/fw.svg)][gemnasium] [![NPM version](https://badge.fury.io/js/fw.svg)][npm]

<table>
<tr>
<td><b>Stage</b></td><td>beta</td>
</tr>
</table>

## About

**fw** is a tiny library (<200 SLOC) which helps with asynchronous
control-flow management in JavaScript environment

It was designed to be easy-to-use and small, in order to embed it as a
part of other libraries or frameworks

It runs in node and browsers and it's full dependency-free

fw exploits the functional-style programming based on high-order functions and other common patterns.
You can use it in conjunction with [hu][hu], for a better approach

## Installation

#### Node.js

```bash
$ npm install fw --save
```

#### Browser

Via Bower package manager
```bash
$ bower install fw
```

Or loading the script remotely (just for testing or development)
```html
<script src="//rawgithub.com/h2non/fw/master/fw.js"></script>
```

## Environments

It works properly in any ES5 compliant engines

- Node.js
- Chrome >= 5
- Firefox >= 3
- Safari >= 5
- Opera >= 12
- IE >= 9

## API

```js
var fw = require('fw')
```

### series(tasks, callback)

Run the functions in the array in series, each one running
once the previous function has completed

If any functions in the series pass an error to its callback,
no more functions are run and callback is immediately
called with the value of the error

##### Arguments

- **tasks** - An array containing functions to run. Each function is passed a `callback(err, result)`
- **callback** - Optional callback to run once all the functions have completed.
This function gets an array of results containing all the result arguments passed
to the task callbacks. `undefined` or `null` values will be omitted from results

```js
fw.series([
  function (next) {
    setTimeout(function () {
      next(null, 1)
    }, 100)
  },
  function (next, result) {
    setTimeout(function () {
      next(null, 2)
    }, 100)
  }
], function (err, results) {
  console.log(err) // → undefined
  console.log(results) // → [1, 2]
})
```

### parallel(tasks, callback)

Run the tasks array of functions in parallel, without waiting until the previous function has completed

Once the `tasks` have completed, the results are passed to the final `callback` as an array

##### arguments

- **tasks** - An array containing functions to run. Each function is passed a `callback(err, result)`
- **callback** - Optional callback to run once all the functions have completed.
This function gets an array of results containing all the result arguments passed
to the task callbacks. `undefined` or `null` values will be omitted from results

```js
fw.parallel([
  function (done) {
    setTimeout(function () {
      done(null, 1)
    }, 100)
  },
  function (done, result) {
    setTimeout(function () {
      done(null, 2)
    }, 150)
  }
], function (err, results) {
  console.log(err) // → undefined
  console.log(results) // → [1, 2]
})
```

### whilst(test, fn, callback)

Repeatedly call a function, while test returns true.
Calls callback when stopped or an error occurs

##### arguments

- **test()** - synchronous truth test to perform before each execution of fn.
- **fn(callback)** - A function which is called each time test passes. The function is passed a `callback(err)`, which must be called once it has completed with an optional err argument
- **callback(err)** - A callback which is called after the test fails and repeated execution of `fn` has stopped

```js
var count = 0

fw.whilst(
  function () {
    return count < 3
  },
  function (callback) {
    count++
    setTimeout(callback, 1000)
  },
  function (err) {
    // 3 seconds have passed
  }
)
```

<!--
### map(arr, iterator, callback)

### each(arr, iterator, callback)

### eachSeries(arr, iterator, callback)
-->

## Contributing

Wanna help? Cool! It will be really apreciated :)

You must add new test cases for any new feature or refactor you do,
always following the same design/code patterns that already exist

### Development

Only [node.js](http://nodejs.org) is required for development

Clone/fork this repository
```
$ git clone https://github.com/h2non/fw.git && cd fw
```

Install dependencies
```
$ npm install
```

Compile code
```
$ make compile
```

Run tests
```
$ make test
```

Generate browser sources
```
$ make browser
```

## License

[MIT](http://opensource.org/licenses/MIT) © Tomas Aparicio

[travis]: http://travis-ci.org/h2non/fw
[npm]: http://npmjs.org/package/fw
[gemnasium]: https://gemnasium.com/h2non/fw
[hu]: https://github.com/h2non/hu
