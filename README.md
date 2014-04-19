# fw [![Build Status](https://travis-ci.org/h2non/fw.svg?branch=master)][travis] [![Dependency Status](https://gemnasium.com/h2non/fw.svg)][gemnasium] [![NPM version](https://badge.fury.io/js/fw.svg)][npm]

> **Work in progress!**

<table>
<tr>
<td><b>Stage</b></td><td>beta</td>
</tr>
</table>

## About

**fw** is a tiny library inspired by `async.js` which
simplifies asynchronous control-flow management in JavaScript environment

It was designed to be easy-to-use and minimal, in order to embed it as a
part of other libraries or frameworks

It runs in node and browsers and it's full dependency-free

fw exploit the functional-style programming based on high-order functions and common patterns.
You can use it in conjunction with [hu][hu] for a better approach

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

```js
fw.series([
  function (next) {
    // do some stuff ...
    next(null, 1)
  },
  function (next, result) {
    // do some more stuff ...
    next(null, 2)
  }
], function (err, results) {
  // results is now equal to [1, 2]
});
```

### parallel(tasks, callback)

### whilst(test, fn, callback)

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

Publish a new version
```
$ make publish
```

## License

[MIT](http://opensource.org/licenses/MIT) © Tomas Aparicio

[travis]: http://travis-ci.org/h2non/fw
[npm]: http://npmjs.org/package/fw
[gemnasium]: https://gemnasium.com/h2non/fw
[hu]: https://github.com/h2non/hu
