fw = require '../'
{ expect } = require 'chai'

delay = (f) ->
  set-timeout f, Math.random! * 100 * Math.random! * 10

suite 'series', ->

  fw.series [
    (next, err, result) -> delay -> console.log ['a', next, err, result]; next(err, 1)
    (next, err, result) -> delay -> console.log ['b', next, err, result]; next(err, 2)
    (next, err, result) -> delay -> console.log ['c', next, err, result]; next(err, 3)
    (next, err, result) -> console.log ['d', next, err, result]; next(err, 4)
  ], (next, err, result) ->
    return console.log ['series complete with error', next, err, result] if err
    console.log ["series complete.", next, err, result]

  test 'basic', ->
    expect fw.series .to.be.a 'function'

suite 'parallel', ->

  fw.parallel [
    (next) -> delay -> console.log ['e', next]; next!
    (next) -> delay -> console.log ['f', next]; next!
    (next) -> console.log ['g', next]; next!
  ],(err) ->
    return console.log ['parallel complete with error', err] if err
    console.log ["parallel complete.", err]

  test 'parallel', ->
    expect fw.parallel .to.be.a 'function'
