# fw [![Build Status](https://secure.travis-ci.org/h2non/fw.png?branch=master)][travis] [![NPM version](https://badge.fury.io/js/fw.png)][npm]

> Work in progress!

## About

**fw** is a tiny library inspired in `async.js` which
simplifies asynchronous control-flow management in JavaScript environments

It was designed to be minimalist, easy-to-use and easy-to-embed as a
part of other libraries or frameworks.

It runs in node and browsers and it's dependency-free

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

## API

### parallel

### series

### map

### each

### eachSeries

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

Copyright (c) 2014 Tomas Aparicio

Released under the MIT license

[travis]: http://travis-ci.org/h2non/fw
[npm]: http://npmjs.org/package/fw
