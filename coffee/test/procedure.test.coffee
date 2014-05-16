procedure = require('../lib/procedure')
assert = require('assert')
sinon = require('sinon')

describe 'procedure', ->
	it 'should call all procedures', (done) ->

		proc1 = sinon.spy (next) ->
			assert typeof next is 'function'
			func = ->
				next('hello world!')
				next() # calling subsequent next won't do anything
			setTimeout(func, 100)

		proc2 = sinon.spy (str, next) ->
			assert str is 'hello world!'
			assert typeof next is 'function'
			next(1,2,3)

		proc3 = sinon.spy (a, b, c, next) ->
			assert a is 1 and b is 2 and c is 3
			assert typeof next is 'function'
			next() # call next but it must do nothing because there is no next procedure

		procedure [
			proc1
			proc2
			proc3
		]

		func = ->
			assert proc1.calledOnce
			assert proc2.calledOnce
			assert proc3.calledOnce
			done()
		setTimeout(func, 200)
