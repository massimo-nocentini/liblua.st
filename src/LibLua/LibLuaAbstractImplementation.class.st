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
