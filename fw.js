/*! fw.js - v0.1.0 - MIT License - https://github.com/h2non/fw */
!function(e){if("object"==typeof exports)module.exports=e();else if("function"==typeof define&&define.amd)define(e);else{var f;"undefined"!=typeof window?f=window:"undefined"!=typeof global?f=global:"undefined"!=typeof self&&(f=self),f.fw=e()}}(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'fw.lib.macros',
            doc: void 0
        };
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'fw.lib.fw',
            doc: void 0
        };
    var fw_lib_series = _dereq_('./series');
    var series = fw_lib_series.series;
    var eachSeries = fw_lib_series.eachSeries;
    var mapSeries = fw_lib_series.mapSeries;
    var fw_lib_parallel = _dereq_('./parallel');
    var parallel = fw_lib_parallel.parallel;
    var each = fw_lib_parallel.each;
    var map = fw_lib_parallel.map;
    var fw_lib_whilst = _dereq_('./whilst');
    var whilst = fw_lib_whilst.whilst;
}
var fw = exports;
fw.VERSION = '0.1.0';
fw.series = series;
fw.eachSeries = eachSeries;
fw.mapSeries = mapSeries;
fw.parallel = parallel;
fw.each = each;
fw.map = map;
fw.whilst = whilst;
},{"./parallel":2,"./series":3,"./whilst":5}],2:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'fw.lib.macros',
            doc: void 0
        };
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'fw.lib.parallel',
            doc: void 0
        };
    var fw_lib_util = _dereq_('./util');
    var isFn = fw_lib_util.isFn;
    var once = fw_lib_util.once;
    var filterEmpty = fw_lib_util.filterEmpty;
}
var iterator = function iterator(lambda, len) {
    return function () {
        var resultsø1 = [];
        var errorø1 = void 0;
        return function (err, result) {
            resultsø1.push(result);
            err ? errorø1 = err : void 0;
            return resultsø1.length === len ? isFn(lambda) ? lambda(errorø1, filterEmpty(resultsø1)) : void 0 : void 0;
        };
    }.call(this);
};
var parallel = exports.parallel = function parallel(arr, lambda) {
        return Array.isArray(arr) ? function () {
            var arrø2 = arr.slice();
            var lenø1 = arrø2.length;
            var nextø1 = iterator(lambda, lenø1);
            return arrø2.forEach(function (cur) {
                return isFn(cur) ? cur(once(nextø1)) : void 0;
            });
        }.call(this) : arr;
    };
var each = exports.each = function each(arr, lambda, cb) {
        return Array.isArray(arr) ? (function () {
            return function () {
                var stackø1 = arr.map(function (item) {
                        return function (done) {
                            return lambda(item, done);
                        };
                    });
                return parallel(stackø1, cb);
            }.call(this);
        })() : arr;
    };
var map = exports.map = each;
},{"./util":4}],3:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'fw.lib.macros',
            doc: void 0
        };
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'fw.lib.series',
            doc: void 0
        };
    var fw_lib_util = _dereq_('./util');
    var isFn = fw_lib_util.isFn;
    var once = fw_lib_util.once;
    var last = fw_lib_util.last;
    var isUniq = fw_lib_util.isUniq;
    var filterEmpty = fw_lib_util.filterEmpty;
}
var iterator = function iterator(arr) {
    return function () {
        var resultsø1 = [];
        return function next(err, result) {
            resultsø1.push(result);
            return err || isUniq(arr) ? last(arr)(err, filterEmpty(resultsø1)) : function () {
                var curø1 = arr.shift();
                return isFn(curø1) ? curø1(once(next), result) : void 0;
            }.call(this);
        };
    }.call(this);
};
var series = exports.series = function series(arr, lambda) {
        return Array.isArray(arr) ? function () {
            var arrø2 = arr.slice();
            arrø2.push(lambda ? lambda : function () {
                return void 0;
            });
            return iterator(arrø2)();
        }.call(this) : arr;
    };
var eachSeries = exports.eachSeries = function eachSeries(arr, lambda, cb) {
        return Array.isArray(arr) ? (function () {
            return function () {
                var stackø1 = arr.map(function (item) {
                        return function (done) {
                            return lambda(item, done);
                        };
                    });
                return series(stackø1, cb);
            }.call(this);
        })() : arr;
    };
var mapSeries = exports.mapSeries = eachSeries;
},{"./util":4}],4:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'fw.lib.macros',
            doc: void 0
        };
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'fw.lib.util',
            doc: void 0
        };
}
var isFn = exports.isFn = function isFn(x) {
        return typeof(x) === 'function';
    };
var last = exports.last = function last(arr) {
        return arr.slice(-1).shift();
    };
var isUniq = exports.isUniq = function isUniq(arr) {
        return arr.length === 1;
    };
var filterEmpty = exports.filterEmpty = function filterEmpty(arr) {
        return Array.isArray(arr) ? arr.filter(function (x) {
            return !(x === void 0 || x === null);
        }) : arr;
    };
var once = exports.once = function once(lambda) {
        return function () {
            var callø1 = false;
            return function () {
                var args = Array.prototype.slice.call(arguments, 0);
                return !callø1 ? (function () {
                    callø1 = true;
                    return lambda.apply(void 0, args);
                })() : void 0;
            };
        }.call(this);
    };
},{}],5:[function(_dereq_,module,exports){
{
    var _ns_ = {
            id: 'fw.lib.macros',
            doc: void 0
        };
}
void 0;
void 0;
void 0;
void 0;
void 0;
void 0;
{
    var _ns_ = {
            id: 'fw.lib.whilst',
            doc: void 0
        };
    var fw_lib_util = _dereq_('./util');
    var isFn = fw_lib_util.isFn;
    var once = fw_lib_util.once;
}
var whilst = exports.whilst = function whilst(test, lambda, cb) {
        return isFn(test) && isFn(lambda) && isFn(cb) ? test() ? lambda(once(function (err) {
            return err ? cb(err) : whilst(test, lambda, cb);
        })) : cb() : void 0;
    };
},{"./util":4}]},{},[1])
(1)
});