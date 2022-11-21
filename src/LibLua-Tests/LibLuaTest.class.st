"
A LibLuaTest is a test class for testing the behavior of LibLua
"
Class {
	#name : #LibLuaTest,
	#superclass : #TestCase,
	#category : #'LibLua-Tests'
}

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

	1 to: n do: [ :i | sum := sum + (self liblua lua: state tonumber: i) ].

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

	self liblua lua_newtable: state.

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
LibLuaTest >> testCFunctionAverage [

	| avg sum |
	self liblua withOpenedLibsStateDo: [ :state | 
		| average |
		average := self liblua ffiCallback: [ :s | self average: s ].

		self liblua lua: state register: 'foo' cfunction: average.

		"We push here some values on the stack to test the behaviour of #lua_gettop: 
		 when the stack contains some more values other than the arguments for the 
		 function call."
		self liblua
			lua_pushnil: state;
			lua: state pushstring: 'hello'.

		self liblua
			luaL: state loadstring: 'return foo(12, 43, 43, 450)';
			lua: state pcallnargs: 0 nresults: 2.

		avg := self liblua lua: state tonumber: -2.
		sum := self liblua lua: state tonumber: -1 ].

	self
		assert: avg equals: { 12. 43. 43. 450 } average;
		assert: sum equals: { 12. 43. 43. 450 } sum
]

{ #category : #tests }
LibLuaTest >> testCFunctionPCallCoroutine [

	| s e |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			dostring:
				'co = coroutine.create(function (...) print(pcall(coroutine.yield, ...)) end)';
			luaL: state loadstring: 'return coroutine.resume(co, "hello")';
			lua: state pcallnargs: 0 nresults: 2.

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
LibLuaTest >> testCommandsUsingLuaDefsReadingTableBack [

	| result |
	result := self liblua withOpenedLibsStateDo: [ :state | 
		          self liblua
			          luaL: state dostring: self commandDefLuaSource;
			          luaL: state dostring: self commandsLuaSource;
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
			luaL: state dostring: self commandDefLuaSource;
			luaL: state dostring: self commandsLuaSource;
			lua: state getglobal: 'commands';
			table: state at: -1 do: [ :k :v | 
				| keyType valueType |
				keyType := self liblua
					           lua: state
					           typename: (self liblua lua: state type: k).
				valueType := self liblua
					             lua: state
					             typename: (self liblua lua: state type: v).
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
			luaL: state dostring: 'tbl = { hello = 3.14, "!" }';
			luaL: state dostring: 'tbl[ { } ] = 2';
			lua: state getglobal: 'tbl';
			lua_pushnil: state;
			lua: state copy: -2 to: -1;
			table: state at: -1 do: [ :k :v | 
				| keyType valueType |
				keyType := self liblua
					           lua: state
					           typename: (self liblua lua: state type: k).
				valueType := self liblua
					             lua: state
					             typename: (self liblua lua: state type: v).
				result add: keyType -> valueType ];
			table: state at: -2 do: [ :k :v | 
				| keyType valueType |
				keyType := self liblua
					           lua: state
					           typename: (self liblua lua: state type: k).
				valueType := self liblua
					             lua: state
					             typename: (self liblua lua: state type: v).
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
			         luaL: state dostring: 'tbl = { nested = { } }';
			         lua: state getglobal: 'tbl';
			         lua_pushnil: state;
			         lua: state copy: -2 to: -1;
			         lua: state compare: -2 eq: -1.

		inner := self liblua
			         lua: state get: -2 field: 'nested';
			         lua: state get: -2 field: 'nested';
			         lua: state compare: -2 eq: -1 ].

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
			     push: array on: state;
			     lua: state pcallnargs: 1 nresults: 1.

		self assert: c equals: 0.

		self liblua
			lua: state setglobal: 'H';
			lua: state getglobal: 'heapq';
			lua: state get: -1 field: 'heapify';
			lua: state getglobal: 'H'.

		luaTimeToRun := [ 
		                code := self liblua
			                        lua: state
			                        pcallnargs: 1
			                        nresults: 1.

		                self assert: code equals: 0 ] timeToRun.

		self assert: code equals: 0.

		c := self liblua
			     lua: state getglobal: 'heapkt';
			     lua: state get: -1 field: 'new';
			     push: array on: state;
			     lua: state pcallnargs: 1 nresults: 1.

		self assert: c equals: 0.

		self liblua
			lua: state setglobal: 'H';
			lua: state getglobal: 'heapkt';
			lua: state get: -1 field: 'heapify';
			lua: state getglobal: 'H'.

		kleinbergTardosTimeToRun := [ 
		                            code := self liblua
			                                    lua: state
			                                    pcallnargs: 1
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
	self halt.
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
LibLuaTest >> testLoadThenPCallWithReturnNumber [

	| code seven |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			luaL: state
			loadstring:
			'do a = 3 + 4.2; print("The result is: ", a); return a + 1 end'.
		code := self liblua lua: state pcallnargs: 0 nresults: 1.
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
			luaL: state
			loadstring:
			'do a = 3 + 4; print("The result is: ", a); return "just a simple string" end'.
		code := self liblua lua: state pcallnargs: 0 nresults: 1.
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
LibLuaTest >> testLuaSeti [

	| list random array |
	random := Random seed: 541.
	array := (1 to: 100) asArray shuffleBy: random.

	list := self liblua withOpenedLibsStateDo: [ :state | 
		        self liblua
			        push: array on: state;
			        lua: state setglobal: 'array';
			        luaL: state loadstring: 'return  table.concat(array, " ")';
			        lua: state pcallnargs: 0 nresults: 1;
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
			          luaL: state loadstring: 'return {1, 2, 3, 4, 5}';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result equals: #( 1 2 3 4 5 ).

		result := self liblua
			          luaL: state
			          loadstring: 'return {1, {1, 2, 3, 4, 5}, 3, 4, 5}';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result equals: #( 1 #( 1 2 3 4 5 ) 3 4 5 ).

		result := self liblua
			          luaL: state
			          loadstring: 'return {[-1]=1, 2, nil, [100]=4, 5}';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
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
			          luaL: state loadstring: 'return false';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self deny: result.

		result := self liblua
			          luaL: state loadstring: 'return true';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result ]
]

{ #category : #tests }
LibLuaTest >> testReadFromInteger [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL: state loadstring: 'return 12345';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result equals: 12345 ]
]

{ #category : #tests }
LibLuaTest >> testReadFromNil [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL: state loadstring: 'return nil';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result equals: nil ]
]

{ #category : #tests }
LibLuaTest >> testReadFromNumber [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL: state loadstring: 'return 12345.1';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result equals: 12345.1 ]
]

{ #category : #tests }
LibLuaTest >> testReadFromString [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL: state loadstring: 'return "nil"';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result equals: 'nil' ]
]

{ #category : #tests }
LibLuaTest >> testReadFromTable [

	self liblua withOpenedLibsStateDo: [ :state | 
		| result |
		result := self liblua
			          luaL: state dostring: 'tbl = {1, 4}';
			          luaL: state dostring: 'tbl[{}] = "hello"';
			          luaL: state dostring: 'tbl[true] = { 1 }';
			          luaL: state loadstring: 'return tbl';
			          lua: state pcallnargs: 0 nresults: 1;
			          read: -1 from: state.
		self assert: result equals: (Dictionary new
				 at: 1 put: 1;
				 at: 2 put: 4;
				 at: #(  ) put: 'hello';
				 at: true put: #( 1 );
				 yourself) ]
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
			            luaL: state
			            loadstring:
				            'return table.contains(package.loaded, "heapq")';
			            lua: state pcallnargs: 0 nresults: 1;
			            lua: state toboolean: -1.

		self liblua
			luaL: state
			dostring: 'for k, v in pairs(package.loaded) do print(k) end'.

		list := self liblua
			        luaL: state dostring: 'list = {5, 4, 3, 2, 1}';
			        luaL: state dostring: 'heapq.heapify(list)';
			        luaL: state loadstring: 'return table.concat(list, ", ")';
			        lua: state pcallnargs: 0 nresults: 1;
			        lua: state tostring: -1 ].

	self assert: longFlag equals: 1
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

{ #category : #tests }
LibLuaTest >> testTableMap [

	| list |
	self liblua withOpenedLibsStateDo: [ :state | 
		self liblua
			appendOnLuaRepositoryOnPackagePathOf: state;
			require: 'op' operator: state.

		list := self liblua
			        luaL: state dostring: 'list = {5, 4, 3, 2, 1}';
			        luaL: state dostring: 'print(table.contains)';
			        luaL: state dostring: 'print(op.increment)';
			        luaL: state dostring: 'print(coroutine.zip)';
			        luaL: state
			        dostring: 'list = table.map(list, op.increment)';
			        luaL: state loadstring: 'return table.concat(list, ", ")';
			        lua: state pcallnargs: 0 nresults: 1;
			        lua: state tostring: -1 ].

	self assert: list equals: '6, 5, 4, 3, 2'
]

{ #category : #tests }
LibLuaTest >> testTreeLayout [

	| table canvas |
	"2012-175 Aqua Zuro"
	self liblua withOpenedLibsStateDo: [ :state | 
		| c |
		self liblua luaL: state loadstring: '
		
		local tidy = require "non-layered-tidy-trees"
		
		local tree, itree = tidy.trees {
		
        addspacers = false,

        [1] = {w = 70, h = 30, c = {2, -3, 4, 8}},
        [2] = {w = 10, h = 50, c = {}},
        [-3] = {w = 10, h = 100, c = { 3 } },
        [3] = {w = 20, h = 30, c = {}},
        [4] = {w = 30, h = 30, c = {5, 7}},
        [5] = {w = 20, h = 50, c = {6}},
        [6] = {w = 40, h = 10, c = {}},
        [7] = {w = 20, h = 20, c = {}},
        [8] = {w = 30, h = 50, c = {9, 10}},
        [9] = {w = 30, h = 20, c = {}},
        [10] = {w = 10, h = 10, c = {}},

    }

    local root = tree[1]

    tidy.layout { 
		root = tree[1],
		vertically = true,
		centeredxy = true,
	 }

    local result = {}

    for k, t in pairs (tree) do

        local tbl = tidy.dbind (t)

		  local c = {  }
		  for i, ud in pairs (tbl.c) do
		     c[i] = itree[ud]
		  end
		  tbl.c = c

        result[k] = tbl
    end

	 return result, root
	'.

		c := self liblua lua: state pcallnargs: 0 nresults: 2.

		self assert: c equals: 0.

		table := self liblua read: -2 from: state.

		canvas := RSCanvas new
			          @ RSCanvasController;
			          yourself.

		table inspect.

		table keysAndValuesDo: [ :k :v | 
			| box label composite extent |
			extent := (v at: #w) @ (v at: #h).

			box := RSNote new
				       model: k;
				       withBorder;
				       cornerRadius: Float goldenRatio;
				       color: Color white;
				       extent: extent;
				       position: (v at: #x) @ (v at: #y);
				       yourself.

			k < 0 ifTrue: [ box border dashArray: { Float goldenRatio } ].

			label := RSLabel new
				         model: k;
				         useDefaultCodeFont;
				         fontSizeSilverRatio;
				         yourself.

			RSLocation new
				center;
				stick: label on: box.

			composite := RSComposite new
				             shapes: { 
						             box.
						             label };
				             yourself.

			canvas addShape: composite ].

		canvas open ]
]
