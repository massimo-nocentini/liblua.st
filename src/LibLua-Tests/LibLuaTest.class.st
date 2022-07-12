"
A LibLuaTest is a test class for testing the behavior of LibLua
"
Class {
	#name : #LibLuaTest,
	#superclass : #TestCase,
	#category : #'LibLua-Tests'
}

{ #category : #tests }
LibLuaTest >> liblua [

	^ LibLua uniqueInstance
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCall [

	| code |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			loadstring: 'do a = 3 + 4; print("The result is: ", a) end'.
		code := self liblua lua: state pcallnargs: 0 nresults: 0 ].

	self assert: code equals: 0
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallThenToString [

	| error code |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			loadstring: '(function (a, b) return error("hello") end) (3, 4)'.
		code := self liblua lua_pcall: state.
		error := self liblua lua: state tostring: -1 ].

	self assert: code equals: 2.

	self
		assert: error
		equals:
		'[string "(function (a, b) return error("hello") end) (..."]:1: hello'
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnInteger [

	| code seven |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			loadstring:
			'do a = 3 + 4; print("The result is: ", a); return a + 1 end'.
		code := self liblua lua: state pcallnargs: 0 nresults: 1.
		seven := self liblua
			         lua: state
			         tointegerx: -1
			         ifNotInteger: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: seven equals: 8
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnIntegerFail [

	| code seven witness |
	witness := Object new.

	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			loadstring:
			'do a = 3 + 4; print("The result is: ", a); return "just a simple string" end'.
		code := self liblua lua: state pcallnargs: 0 nresults: 1.
		seven := self liblua
			         lua: state
			         tointegerx: -1
			         ifNotInteger: [ witness ] ].

	self
		assert: code equals: 0;
		assert: seven equals: witness
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnIntegerInString [

	| code seven |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			loadstring:
			'do a = 3 + 4; print("The result is: ", a); return tostring(a + 1) end'.
		code := self liblua lua: state pcallnargs: 0 nresults: 1.
		seven := self liblua
			         lua: state
			         tointegerx: -1
			         ifNotInteger: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: seven equals: 8
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnString [

	| code seven |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			loadstring:
			'do a = 3 + 4; print("The result is: ", a); return tostring(a) .. " hello " end'.
		code := self liblua lua: state pcallnargs: 0 nresults: 1.
		seven := self liblua lua: state tostring: -1 ].

	self
		assert: code equals: 0;
		assert: seven equals: '7 hello '
]

{ #category : #tests }
LibLuaTest >> testNewCloseState [

	| three |
	three := self liblua withStateDo: [ :state | 
		         self deny: state equals: ExternalAddress null.
		         3 ].

	self assert: three equals: 3
]

{ #category : #tests }
LibLuaTest >> testNewWithOpenLibs [

	| three |
	three := self liblua withOpenedLibsStateDo: [ :state | 
		         self deny: state equals: ExternalAddress null.
		         3 ].

	self assert: three equals: 3
]

{ #category : #tests }
LibLuaTest >> testSetGlobalMySinAsCallback [

	| code result called |
	called := false.

	self liblua withOpenedLibsStateDo: [ :state | 
		[ :ongoingState | 
		| number |
		called := true.
		self assert: ongoingState equals: state.

		number := self liblua luaL: state checknumber: 1.

		number sin pushOnLua: state.

		1 "number of results" ] pushOnLua: state.

		self liblua lua: state setglobal: 'mysin'.

		self liblua luaL: state loadstring: 'return mysin(3)'.
		code := self liblua lua: state pcallnargs: 0 nresults: 1.

		result := self liblua
			          lua: state
			          tonumberx: -1
			          ifNotNumber: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: called;
		assert: result equals: 3 sin
]
