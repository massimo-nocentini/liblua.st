"
I am an abstract class for the ways we interact with Lua.
"
Class {
	#name : 'LibLuaAbstractImplementation',
	#superclass : 'Object',
	#category : 'LibLua',
	#package : 'LibLua'
}

{ #category : 'API' }
LibLuaAbstractImplementation >> append: dir onPackageCPathOfLua: state [

	^ self
		  luaL: state
		  dostring: 'package.cpath = package.cpath .. ";' , dir , '"'
]

{ #category : 'API' }
LibLuaAbstractImplementation >> append: dir onPackagePathOfLua: state [

	^ self
		  luaL: state
		  dostring: 'package.path = package.path .. ";' , dir , '"'
]

{ #category : 'asserting' }
LibLuaAbstractImplementation >> assert: aBlock [

	^ super assert: (aBlock cull: self) = self LUA_OK
]

{ #category : 'API' }
LibLuaAbstractImplementation >> fficallbackOnBlock: aBlock [

	^ (FFICallback signature: #( int #( const void * a ) ) block: aBlock)
		  getHandle
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L compare: index1 another: index2 operator: op [
	"From https://www.lua.org/manual/5.4/manual.html#lua_compare,
	
		int lua_compare (lua_State *L, int index1, int index2, int op);
	
	Compares two Lua values. Returns 1 if the value at index index1 satisfies 
	op when compared with the value at index index2, following the semantics of 
	the corresponding Lua operator (that is, it may call metamethods). 
	Otherwise returns 0. Also returns 0 if any of the indices is not valid.

	The value of op must be one of the following constants:

		• LUA_OPEQ: compares for equality (==)
		• LUA_OPLT: compares for less than (<)
		• LUA_OPLE: compares for less or equal (<=)"

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L compare: index1 eq: index2 [

	^ self
		  lua: L
		  compare: index1
		  another: index2
		  operator: self LUA_OPEQ
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L copy: fromidx to: toidx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_copy,
	
		void lua_copy (lua_State *L, int fromidx, int toidx);
	
	Copies the element at index fromidx into the valid index toidx, replacing the 
	value at that position. Values at other positions are not affected."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L get: index field: k [
	"From https://www.lua.org/manual/5.4/manual.html#lua_getfield,
	
		int lua_getfield (lua_State *L, int index, const char *k);
	
	Pushes onto the stack the value t[k], where t is the value at the given index. 
	As in Lua, this function may trigger a metamethod for the ""index"" event 
	(see https://www.lua.org/manual/5.4/manual.html#2.4).

	Returns the type of the pushed value."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L get: index field: k remove: shouldRemove [

	| type tblindex |
	tblindex := self lua_absindex: L index: index.
	type := self lua: L get: index field: k.

	shouldRemove ifTrue: [ self lua_remove: L at: tblindex ].

	^ type
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pcallArgumentsSize: nargs resultsSize: nresults msgh: errfunc [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pcall,

		int lua_pcall (lua_State *L, int nargs, int nresults, int msgh);

	Calls a function (or a callable object) in protected mode.

	Both nargs and nresults have the same meaning as in lua_call. 
	If there are no errors during the call, lua_pcall behaves exactly 
	like lua_call. However, if there is any error, lua_pcall catches 
	it, pushes a single value on the stack (the error object), and returns 
	an error code. Like lua_call, lua_pcall always removes the function and 
	its arguments from the stack.

	If msgh is 0, then the error object returned on the stack is exactly the 
	original error object. Otherwise, msgh is the stack index of a message handler. 
	(This index cannot be a pseudo-index.) In case of runtime errors, this handler 
	will be called with the error object and its return value will be the object 
	returned on the stack by lua_pcall.

	Typically, the message handler is used to add more debug information to the error 
	object, such as a stack traceback. Such information cannot be gathered after the 
	return of lua_pcall, since by then the stack has unwound.

	The lua_pcall function returns one of the following status codes: 
	LUA_OK, LUA_ERRRUN, LUA_ERRMEM, or LUA_ERRERR."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pushcfunction: fn [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushcfunction,
	
		void lua_pushcfunction (lua_State *L, lua_CFunction f);
	
	Pushes a C function onto the stack. 
	
	This function is equivalent to lua_pushcclosure with no upvalues."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL: L dostring: s [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_dostring,
	
		int luaL_dostring (lua_State *L, const char *str);
	
	Loads and runs the given string. It is defined as the following macro:

     (luaL_loadstring(L, str) || lua_pcall(L, 0, LUA_MULTRET, 0))

	It returns LUA_OK if there are no errors, or an error code in case of errors (see §4.4.1)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL: L loadstring: s [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadstring,
	
		int luaL_loadstring (lua_State *L, const char *s);
		
	Loads a string as a Lua chunk. This function uses lua_load to load the 
	chunk in the zero-terminated string s.

	This function returns the same results as lua_load.

	Also as lua_load, this function only loads the chunk; it does not run it."

	self subclassResponsibility
]
