# Procedure.js

## How to use

```javascript
proc = require('procedure');

// run procedure stack
proc([
	function(next) {
		setTimeout(function() {
			next('hello world'); // run next procedure with passed args
		}, 1000);
	},

	function(str, next) {
		console.log(str); // outputs 'hello world!'
		next(1, 2, 3); // run next procedure
	},

	function(a, b, c) {
		console.log(a, b, c) // outputs '1 2 3'
	}
]);
```