fw = require '../'
{ expect } = require 'chai'

delay = (f) ->
  set-timeout f, Math.random! * 100

suite 'series', ->

  test 'basic', (done) ->
    fw.series [
      (next) -> delay -> next null, 1
      (next, err, result) -> delay -> next null, result + 1
      (next, err, result) -> next err, result * 2
    ], (err, result) ->
      expect err .to.be.null
      expect result .to.be.equal 4
      done!

  test 'error', (done) ->
    fw.series [
      (next, err, result) -> delay -> next err, 1
      (next, err, result) -> delay -> next 'error', result
      (next, err, result) -> next err, result
    ], (err, result) ->
      expect err .to.be.equal 'error'
      expect result .be.equal 1
      done!

suite 'parallel', ->

  test 'basic', (done) ->
    fw.parallel [
      (next) -> delay -> next!
      (next) -> delay -> next!
      (next) -> next!
    ], (err) ->
      expect err .to.be.undefined
      done!

  test 'error', (done) ->
    fw.parallel [
      (next) -> delay -> next!
      (next) -> delay -> next 'error'
      (next) -> next!
    ], (err) ->
      expect err .to.be.equal 'error'
      done!
