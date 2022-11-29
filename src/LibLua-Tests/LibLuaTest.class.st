"
A LibLuaTest is a test class for testing the behavior of LibLua
"
Class {
	#name : #LibLuaTest,
	#superclass : #LibLuaAbstractTest,
	#category : #'LibLua-Tests'
}

{ #category : #testing }
LibLuaTest class >> isAbstract [

	^ false
]

{ #category : #'Lua creation' }
LibLuaTest >> average: state [

	"From https://www.lua.org/manual/5.4/manual.html#lua_CFunction,

	static int foo (lua_State *L) {
       int n = lua_gettop(L);    /* number of arguments */
       lua_Number sum = 0.0;
       int i;
       for (i = 1; i <= n; i++) {
         if (!lua_isnumber(L, i)) {
           lua_pushliteral(L, ""incorrect argument"");
           lua_error(L);
         }
         sum += lua_tonumber(L, i);
       }
       lua_pushnumber(L, sum/n);        /* first result */
       lua_pushnumber(L, sum);         /* second result */
       return 2;                   /* number of results */
     }"

	| n sum |
	n := self liblua lua_gettop: state.
	sum := 0.0.

	1 to: n do: [ :i | sum := sum + (self liblua lua_tonumber: state at: i) ].

	self liblua
		lua: state pushnumber: sum / n;
		lua: state pushnumber: sum.

	^ 2
]

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

{ #category : #'Lua creation' }
LibLuaTest >> pushCommandTableOnLua: state random: random acc: aKey [

	"According to https://stackoverflow.com/questions/20147027/creating-a-simple-table-with-lua-tables-c-api"

	| s name |
	self liblua luaL: state check: 1 type: self liblua LUA_TTABLE.

	self liblua lua_newtable: state.

	name := self liblua lua: state get: -2 i: 1.
	self assert: name equals: self liblua LUA_TSTRING.
	self liblua lua: state set: -2 field: 'name'.

	s := random next.
	aKey key: aKey key + s.

	self liblua
		on: state push: s;
		lua: state set: -2 field: 'context'.

	self liblua
		lua: state get: -2 i: 2;
		lua: state set: -2 field: 'followups'.

	self liblua
		on: state push: 'noop';
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
LibLuaTest >> testCFunctionAverage [

	| avg sum |
	self liblua withOpenedLibsStateDo: [ :state | 
		| average |
		average := self liblua fficallbackOnBlock: [ :s | self average: s ].

		self liblua lua_register: state name: 'foo' cfunction: average.

		"We push here some values on the stack to test the behaviour of #lua_gettop: 
		 when the stack contains some more values other than the arguments for the 
		 function call."
		self liblua
			lua_pushnil: state;
			lua: state pushstring: 'hello'.

		self liblua
			luaL_loadstring: state chunk: 'return foo(12, 43, 43, 450)';
			lua_pcall: state nargs: 0 nresults: 2.

		avg := self liblua lua_tonumber: state at: -2.
		sum := self liblua lua_tonumber: state at: -1 ].

	self
		assert: avg equals: { 12. 43. 43. 450 } average;
		assert: sum equals: { 12. 43. 43. 450 } sum
]

{ #category : #tests }
LibLuaTest >> testCFunctionPCallCoroutine [

	| s e |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_dostring: state
			chunk:
				'co = coroutine.create(function (...) print(pcall(coroutine.yield, ...)) end)';
			luaL_loadstring: state chunk: 'return coroutine.resume(co, "hello")';
			lua_pcall: state nargs: 0 nresults: 2.

		s := self liblua lua: state toboolean: -2.
		e := self liblua lua: state tostring: -1 ].

	self
		assert: s equals: 1;
		assert: e equals: 'hello'
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
			          on: state push: [ :ongoingState | 
				          self
					          pushCommandTableOnLua: ongoingState
					          random: random
					          acc: r ];
			          lua: state setglobal: 'command';
			          luaL_dostring: state chunk: self recSumLuaSource;
			          luaL_dostring: state chunk: self commandsLuaSource;
			          luaL_loadstring: state chunk: 'return recSum(commands)';
			          lua_pcall: state nargs: 0 nresults: 1;
			          lua: state tonumberx: -1 ifNotNumber: [ Error signal ] ].

	self assert: result equals: r key
]

{ #category : #tests }
LibLuaTest >> testCommandsUsingLuaDefs [

	| result |
	result := self liblua withOpenedLibsStateDo: [ :state | 
		          self liblua
			          luaL_dostring: state chunk: self commandDefLuaSource;
			          luaL_dostring: state chunk: self recSumLuaSource;
			          luaL_dostring: state chunk: self commandsLuaSource;
			          luaL_loadstring: state chunk: 'return recSum(commands)';
			          lua_pcall: state nargs: 0 nresults: 1;
			          lua: state tointegerx: -1 ifNotInteger: [ Error signal ] ].

	self assert: result equals: 4
]

{ #category : #tests }
LibLuaTest >> testCommandsUsingLuaDefsReadingTableBack [

	| result |
	result := self liblua withOpenedLibsStateDo: [ :state | 
		          self liblua
			          luaL_dostring: state chunk: self commandDefLuaSource;
			          luaL_dostring: state chunk: self commandsLuaSource;
			          lua: state getglobal: 'commands';
			          lua: state get: -1 i: 1;
			          lua: state get: -1 field: 'name';
			          lua: state tostring: -1 ].

	self assert: result equals: 'create'
]

{ #category : #tests }
LibLuaTest >> testCommandsUsingLuaDefsTableDo [

	| result |
	result := OrderedCollection new.

	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_dostring: state chunk: self commandDefLuaSource;
			luaL_dostring: state chunk: self commandsLuaSource;
			lua: state getglobal: 'commands';
			table: state at: -1 do: [ :k :v | 
				| keyType valueType |
				keyType := self liblua
					           lua: state
					           typename: (self liblua lua_type: state at: k).
				valueType := self liblua
					             lua: state
					             typename: (self liblua lua_type: state at: v).
				result add: keyType -> valueType ] ].

	self
		assert: result first equals: 'number' -> 'table';
		assert: result second equals: 'number' -> 'table';
		assert: result size equals: 2
]

{ #category : #tests }
LibLuaTest >> testCopy [

	| result original |
	result := Set new.
	original := Set new.

	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_dostring: state chunk: 'tbl = { hello = 3.14, "!" }';
			luaL_dostring: state chunk: 'tbl[ { } ] = 2';
			lua: state getglobal: 'tbl';
			lua_pushnil: state;
			lua: state copy: -2 to: -1;
			table: state at: -1 do: [ :k :v | 
				| keyType valueType |
				keyType := self liblua
					           lua: state
					           typename: (self liblua lua_type: state at: k).
				valueType := self liblua
					             lua: state
					             typename: (self liblua lua_type: state at: v).
				result add: keyType -> valueType ];
			table: state at: -2 do: [ :k :v | 
				| keyType valueType |
				keyType := self liblua
					           lua: state
					           typename: (self liblua lua_type: state at: k).
				valueType := self liblua
					             lua: state
					             typename: (self liblua lua_type: state at: v).
				original add: keyType -> valueType ] ].

	self
		assert: result equals: (Set new
				 add: 'number' -> 'string';
				 add: 'table' -> 'number';
				 add: 'string' -> 'number';
				 yourself);
		assert: result equals: original;
		assert: result size equals: 3
]

{ #category : #tests }
LibLuaTest >> testCopyCompare [

	| outer inner |
	self liblua withOpenedLibsStateDo: [ :state | 
		outer := self liblua
			         luaL_dostring: state chunk: 'tbl = { nested = { } }';
			         lua: state getglobal: 'tbl';
			         lua_pushnil: state;
			         lua: state copy: -2 to: -1;
			         lua_compare_eq: state index: -2 anotherIndex: -1.

		inner := self liblua
			         lua: state get: -2 field: 'nested';
			         lua: state get: -2 field: 'nested';
			         lua_compare_eq: state index: -2 anotherIndex: -1 ].

	self
		assert: outer equals: 1;
		assert: inner equals: 1
]

{ #category : #tests }
LibLuaTest >> testHeapBench [

	| random array luaTimeToRun smalltalkTimeToRun kleinbergTardosTimeToRun heap position indexer code |
	self
		skip;
		timeLimit: 1 minute.

	random := Random seed: 541.
	array := (1 to: 1e7) asArray shuffleBy: random.

	self liblua withOpenedLibsStateDo: [ :state | 
		| c |
		self liblua
			require: 'heapq' heapq: state;
			require: 'heapkt' heapkt: state.

		c := self liblua
			     lua: state getglobal: 'heapq';
			     lua: state get: -1 field: 'create';
			     on: state push: array;
			     lua_pcall: state nargs: 1 nresults: 1.

		self assert: c equals: 0.

		self liblua
			lua: state setglobal: 'H';
			lua: state getglobal: 'heapq';
			lua: state get: -1 field: 'heapify';
			lua: state getglobal: 'H'.

		luaTimeToRun := [ 
		                code := self liblua
			                        lua_pcall: state
			                        nargs: 1
			                        nresults: 1.

		                self assert: code equals: 0 ] timeToRun.

		self assert: code equals: 0.

		c := self liblua
			     lua: state getglobal: 'heapkt';
			     lua: state get: -1 field: 'new';
			     on: state push: array;
			     lua_pcall: state nargs: 1 nresults: 1.

		self assert: c equals: 0.

		self liblua
			lua: state setglobal: 'H';
			lua: state getglobal: 'heapkt';
			lua: state get: -1 field: 'heapify';
			lua: state getglobal: 'H'.

		kleinbergTardosTimeToRun := [ 
		                            code := self liblua
			                                    lua_pcall: state
			                                    nargs: 1
			                                    nresults: 1 ] timeToRun.

		self assert: code equals: 0 ].

	position := Dictionary new.
	indexer := [ :anObject :index | position at: anObject put: index ].

	array withIndexDo: indexer.
	heap := Heap new
		        indexUpdateBlock: indexer;
		        sortBlock: [ :a :b | a < b ];
		        setCollection: array copy tally: array size;
		        yourself.

	smalltalkTimeToRun := [ heap reSort ] timeToRun.
	"pythonTimeToRun := [ CTHeapQ new heapify: array ] timeToRun."
	self halt
	"self
		assert: luaTimeToRun < smalltalkTimeToRun;
		assert: kleinbergTardosTimeToRun < smalltalkTimeToRun;
		assert: position size equals: array size ;
		assert: smalltalkTimeToRun < pythonTimeToRun"
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCall [

	| code |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_loadstring: state
			chunk: 'do a = 3 + 4; print("The result is: ", a) end'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 0 ].

	self assert: code equals: 0
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallThenToString [

	| error code |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_loadstring: state
			chunk: '(function (a, b) return error("hello") end) (3, 4)'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 0.
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
			luaL_loadstring: state
			chunk:
			'do a = 3 + 4; print("The result is: ", a); return a + 1 end'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 1.
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
			luaL_loadstring: state
			chunk:
			'do a = 3 + 4; print("The result is: ", a); return "just a simple string" end'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 1.
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
			luaL_loadstring: state
			chunk:
			'do a = 3 + 4; print("The result is: ", a); return tostring(a + 1) end'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 1.
		seven := self liblua
			         lua: state
			         tointegerx: -1
			         ifNotInteger: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: seven equals: 8
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnNumber [

	| code seven |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_loadstring: state
			chunk:
			'do a = 3 + 4.2; print("The result is: ", a); return a + 1 end'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 1.
		seven := self liblua
			         lua: state
			         tonumberx: -1
			         ifNotNumber: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: seven equals: 8.2
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnNumberFail [

	| code seven witness |
	witness := Object new.

	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_loadstring: state
			chunk:
			'do a = 3 + 4; print("The result is: ", a); return "just a simple string" end'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 1.
		seven := self liblua
			         lua: state
			         tonumberx: -1
			         ifNotNumber: [ witness ] ].

	self
		assert: code equals: 0;
		assert: seven equals: witness
]

{ #category : #tests }
LibLuaTest >> testLoadThenPCallWithReturnString [

	| code seven |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL_loadstring: state
			chunk:
			'do a = 3 + 4; print("The result is: ", a); return tostring(a) .. " hello " end'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 1.
		seven := self liblua lua: state tostring: -1 ].

	self
		assert: code equals: 0;
		assert: seven equals: '7 hello '
]

{ #category : #tests }
LibLuaTest >> testLuaSeti [

	| list random array |
	random := Random seed: 541.
	array := (1 to: 100) asArray shuffleBy: random.

	list := self liblua withOpenedLibsStateDo: [ :state | 
		        self liblua
			        on: state push: array;
			        lua: state setglobal: 'array';
			        luaL_loadstring: state
			        chunk: 'return  table.concat(array, " ")';
			        lua_pcall: state nargs: 0 nresults: 1;
			        lua: state tostring: -1 ].

	self assert: '#(' , list , ')' equals: array asString
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
LibLuaTest >> testReadFromArray [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL_loadstring: state chunk: 'return {1, 2, 3, 4, 5}';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: #( 1 2 3 4 5 ).

		result := self liblua
			          luaL_loadstring: state
			          chunk: 'return {1, {1, 2, 3, 4, 5}, 3, 4, 5}';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: #( 1 #( 1 2 3 4 5 ) 3 4 5 ).

		result := self liblua
			          luaL_loadstring: state
			          chunk: 'return {[-1]=1, 2, nil, [100]=4, 5}';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: (Dictionary new
				 at: -1 put: 1;
				 at: 1 put: 2;
				 at: 100 put: 4;
				 at: 3 put: 5;
				 yourself) ]
]

{ #category : #tests }
LibLuaTest >> testReadFromBoolean [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL_loadstring: state chunk: 'return false';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self deny: result.

		result := self liblua
			          luaL_loadstring: state chunk: 'return true';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result ]
]

{ #category : #tests }
LibLuaTest >> testReadFromInteger [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL_loadstring: state chunk: 'return 12345';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: 12345 ]
]

{ #category : #tests }
LibLuaTest >> testReadFromNil [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL_loadstring: state chunk: 'return nil';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: nil ]
]

{ #category : #tests }
LibLuaTest >> testReadFromNumber [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL_loadstring: state chunk: 'return 12345.1';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: 12345.1 ]
]

{ #category : #tests }
LibLuaTest >> testReadFromString [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL_loadstring: state chunk: 'return "nil"';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: 'nil' ]
]

{ #category : #tests }
LibLuaTest >> testReadFromTable [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL_dostring: state chunk: 'tbl = {1, 4}';
			          luaL_dostring: state chunk: 'tbl[{}] = "hello"';
			          luaL_dostring: state chunk: 'tbl[true] = { 1 }';
			          luaL_loadstring: state chunk: 'return tbl';
			          lua_pcall: state nargs: 0 nresults: 1;
			          on: state at: -1.
		self assert: result equals: (Dictionary new
				 at: 1 put: 1;
				 at: 2 put: 4;
				 at: #(  ) put: 'hello';
				 at: true put: #( 1 );
				 yourself) ]
]

{ #category : #tests }
LibLuaTest >> testRecursiveTables [

	| tbl |
	tbl := self liblua withOpenedLibsStateDo: [ :state | 
		       self liblua assert: [ :ll | 
			       ll luaL_loadstring: state chunk: '
		
			local t, u = {  }, {  }
			t.u, u.t = u, t
			return { t = t, u = u }

		' ].

		       self liblua assert: [ :ll | 
			       ll lua_pcall: state nargs: 0 nresults: 1 ].

		       self liblua on: state at: -1 ]
]

{ #category : #tests }
LibLuaTest >> testSearchPath [

	| list longFlag |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			appendOnLuaRepositoryOnPackagePathOf: state;
			require: 'heapq' heapq: state;
			require: 'operator' operator: state.

		longFlag := self liblua
			            luaL_loadstring: state
			            chunk:
				            'return table.contains(package.loaded, "heapq")';
			            lua_pcall: state nargs: 0 nresults: 1;
			            lua: state toboolean: -1.

		self liblua
			luaL_dostring: state
			chunk: 'for k, v in pairs(package.loaded) do print(k) end'.

		list := self liblua
			        luaL_dostring: state chunk: 'list = {5, 4, 3, 2, 1}';
			        luaL_dostring: state chunk: 'heapq.heapify(list)';
			        luaL_loadstring: state chunk: 'return table.concat(list, ", ")';
			        lua_pcall: state nargs: 0 nresults: 1;
			        lua: state tostring: -1 ].

	self assert: longFlag equals: 1
]

{ #category : #tests }
LibLuaTest >> testSetGlobalMySinAsCallback [

	| code result called |
	called := false.

	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua on: state push: [ :ongoingState | 
			| number |
			called := true.
			self assert: ongoingState equals: state.

			number := self liblua luaL: state checknumber: 1.

			self liblua on: ongoingState push: number sin.

			1 "number of results" ].

		self liblua lua: state setglobal: 'mysin'.

		self liblua luaL_loadstring: state chunk: 'return mysin(3)'.
		code := self liblua lua_pcall: state nargs: 0 nresults: 1.

		result := self liblua
			          lua: state
			          tonumberx: -1
			          ifNotNumber: [ Error signal ] ].

	self
		assert: code equals: 0;
		assert: called;
		assert: result equals: 3 sin
]

{ #category : #tests }
LibLuaTest >> testTableMap [

	| list |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			appendOnLuaRepositoryOnPackagePathOf: state;
			require: 'op' operator: state.

		list := self liblua
			        luaL_dostring: state chunk: 'list = {5, 4, 3, 2, 1}';
			        luaL_dostring: state chunk: 'print(table.contains)';
			        luaL_dostring: state chunk: 'print(op.increment)';
			        luaL_dostring: state chunk: 'print(coroutine.zip)';
			        luaL_dostring: state
			        chunk: 'list = table.map(list, op.increment)';
			        luaL_loadstring: state chunk: 'return table.concat(list, ", ")';
			        lua_pcall: state nargs: 0 nresults: 1;
			        lua: state tostring: -1 ].

	self assert: list equals: '6, 5, 4, 3, 2'
]
