"
A LibLuaTest is a test class for testing the behavior of LibLua
"
Class {
	#name : #LibLuaTest,
	#superclass : #TestCase,
	#category : #'LibLua-Tests'
}

{ #category : #tests }
LibLuaTest >> testLoadThenPCall [

	| code |
	LibLua withOpenLibsOn: [ :state | 
		state luaL_loadstring:
			'do a = 3 + 4; print("The result is: ", a) end'.
		code := state lua_pcallNargs: 0 nresults: 0 ].

	self assert: code equals: 0
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallThenToString [

	| error code |
	LibLua withOpenLibsOn: [ :state | 
		state luaL_loadstring:
			'(function (a, b) return error("hello") end) (3, 4)'.
		code := state lua_pcall.
		error := state lua_tostring: -1 ].

	self assert: code equals: 2.

	self
		assert: error
		equals:
		'[string "(function (a, b) return error("hello") end) (..."]:1: hello'
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnInteger [

	| code seven |
	LibLua withOpenLibsOn: [ :state | 
		state luaL_loadstring:
			'do a = 3 + 4; print("The result is: ", a); return a + 1 end'.
		code := state lua_pcallNargs: 0 nresults: 1.
		seven := state lua_tointegerx: -1 ifNotInteger: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: seven equals: 8
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnIntegerFail [

	| code seven witness |
	witness := Object new.

	LibLua withOpenLibsOn: [ :state | 
		state luaL_loadstring:
			'do a = 3 + 4; print("The result is: ", a); return "just a simple string" end'.
		code := state lua_pcallNargs: 0 nresults: 1.
		seven := state lua_tointegerx: -1 ifNotInteger: [ witness ] ].

	self
		assert: code equals: 0;
		assert: seven equals: witness
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnIntegerInString [

	| code seven |
	LibLua withOpenLibsOn: [ :state | 
		state luaL_loadstring:
			'do a = 3 + 4; print("The result is: ", a); return tostring(a + 1) end'.
		code := state lua_pcallNargs: 0 nresults: 1.
		seven := state lua_tointegerx: -1 ifNotInteger: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: seven equals: 8
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnString [

	| code seven |
	LibLua withOpenLibsOn: [ :state | 
		state luaL_loadstring:
			'do a = 3 + 4; print("The result is: ", a); return tostring(a) .. " hello " end'.
		code := state lua_pcallNargs: 0 nresults: 1.
		seven := state lua_tostring: -1 ].

	self
		assert: code equals: 0;
		assert: seven equals: '7 hello '
]

{ #category : #tests }
LibLuaTest >> testNewCloseState [

	| three |
	three := LibLua on: [ :state | 
		         self deny: state state equals: ExternalAddress null.
		         3 ].

	self assert: three equals: 3
]

{ #category : #tests }
LibLuaTest >> testNewWithOpenLibs [

	| three |
	three := LibLua withOpenLibsOn: [ :state | 
		         self deny: state state equals: ExternalAddress null.
		         3 ].

	self assert: three equals: 3
]
