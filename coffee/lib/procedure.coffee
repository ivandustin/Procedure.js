Array.prototype.procedure = () ->
	# initialize variables
	stack = this
	index = 0

	# create next() function to be passed in the procedures
	create_next_func = ->
		called = false
		next = (args...) ->
			# skip if this next() function if already called
			if called then return

			# skip if there is no next procedure
			if index is stack.length
				return

			# set called to true
			called = true

			# initialize args if there's none
			if not args?
				args = []

			# push the next() function at the end of the arguments
			args.push(create_next_func())

			# fire the next procedure with passed arguments
			# and point the index to the next procedure
			stack[index++].apply(stack, args)

	# call the first procedure by creating the first next() function
	next = create_next_func()
	next()