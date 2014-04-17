# fw [![Build Status](https://secure.travis-ci.org/h2non/fw.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/h2non/fw.png)][gemnasium] [![NPM version](https://badge.fury.io/js/fw.png)][npm]

<table>
<tr>
<td><b>Stage</b></td><td>beta</td>
</tr>
</table>

## About

**fw** is an ultra minimalist library inspired in async.js which
simplifies asynchronous control-flow management in JavaScript environments

It runs in node and browsers and is dependency-free

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
