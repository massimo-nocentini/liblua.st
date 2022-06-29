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

	| seven |
	seven := LibLua withOpenLibsOn: [ :state | 
		         state luaL_loadstring:
			         'a = 3 + 4; print("The result is: ", a)'.
		         state lua_pcall ].

	self assert: seven equals: 0
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
