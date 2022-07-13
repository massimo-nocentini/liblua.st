"
A LibLuaTest is a test class for testing the behavior of LibLua
"
Class {
	#name : #LibLuaTest,
	#superclass : #TestCase,
	#category : #'LibLua-Tests'
}

{ #category : #'Lua chunks' }
LibLuaTest >> commandDefLuaSource [

	^ '

function command (tbl)
	return { name = tbl[1], context=1, followups=tbl[2] or {}, action=nil }
end

'
]

{ #category : #'Lua chunks' }
LibLuaTest >> commandsLuaSource [

	^ '

commands = {
	command { "create", 
		{ 
			command { "document" }, 
		  	command { "folder" }
		} 
	},
	command { "delete" },
}

'
]

{ #category : #'ffi lib' }
LibLuaTest >> liblua [

	^ LibLua uniqueInstance
]

{ #category : #'Lua creation' }
LibLuaTest >> pushCommandTableOnLua: state random: random acc: aKey [

	"According to https://stackoverflow.com/questions/20147027/creating-a-simple-table-with-lua-tables-c-api"

	| s name |
	self liblua
		luaL: state
		check: 1
		type: (self liblua typeAt: #LUA_TTABLE).

	self liblua lua: state create: 0 table: 4.

	name := self liblua lua: state get: -2 i: 1.
	self assert: name equals: (self liblua typeAt: #LUA_TSTRING).
	self liblua lua: state set: -2 field: 'name'.

	s := random next.
	aKey key: aKey key + s.

	self liblua
		push: s on: state;
		lua: state set: -2 field: 'context'.

	self liblua
		lua: state get: -2 i: 2;
		lua: state set: -2 field: 'followups'.

	self liblua
		push: 'noop' on: state;
		lua: state set: -2 field: 'action'.

	^ 1 "number of results"
]

{ #category : #'Lua chunks' }
LibLuaTest >> recSumLuaSource [

	^ '

function recSum (tbl) 
	r = 0.0
	for _, c in ipairs(tbl) do
		print(c.name)
		r = r + c.context + recSum (c.followups or {})
	end
	return r
end

'
]

{ #category : #tests }
LibLuaTest >> testCommandsUsingLuaAPI [

	| result random r |
	random := Random seed: 541.

	"The following lookupkey is necessary to keep the sum of
	 random numbers generated call after call."
	r := LookupKey new
		     key: 0.0;
		     yourself.

	result := self liblua withOpenedLibsStateDo: [ :state | 
		          self liblua
			          push: [ :ongoingState | 
				          self
					          pushCommandTableOnLua: ongoingState
					          random: random
					          acc: r ]
			          on: state;
			          lua: state setglobal: 'command';
			          luaL: state dostring: self recSumLuaSource;
			          luaL: state dostring: self commandsLuaSource;
			          luaL: state loadstring: 'return recSum(commands)';
			          lua: state pcallnargs: 0 nresults: 1;
			          lua: state tonumberx: -1 ifNotNumber: [ Error signal ] ].

	self assert: result equals: r key
]

{ #category : #tests }
LibLuaTest >> testCommandsUsingLuaDefs [

	| result |
	result := self liblua withOpenedLibsStateDo: [ :state | 
		          self liblua
			          luaL: state dostring: self commandDefLuaSource;
			          luaL: state dostring: self recSumLuaSource;
			          luaL: state dostring: self commandsLuaSource;
			          luaL: state loadstring: 'return recSum(commands)';
			          lua: state pcallnargs: 0 nresults: 1;
			          lua: state tointegerx: -1 ifNotInteger: [ Error signal ] ].

	self assert: result equals: 4
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
		self liblua
			push: [ :ongoingState | 
				| number |
				called := true.
				self assert: ongoingState equals: state.

				number := self liblua luaL: state checknumber: 1.

				self liblua push: number sin on: ongoingState.

				1 "number of results" ]
			on: state.

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
