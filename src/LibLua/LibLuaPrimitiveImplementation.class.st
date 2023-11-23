"
I am the implementation via a VM plugin.
"
Class {
	#name : 'LibLuaPrimitiveImplementation',
	#superclass : 'LibLuaAbstractImplementation',
	#category : 'LibLua',
	#package : 'LibLua'
}

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L compare: index1 another: index2 operator: op [

	<primitive: 'primitive_lua_compare' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L copy: fromidx to: toidx [

	<primitive: 'primitive_lua_copy' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L get: index field: k [

	<primitive: 'primitive_lua_getfield' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L get: index i: i [

	<primitive: 'primitive_lua_geti' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L getglobal: name [

	<primitive: 'primitive_lua_getglobal' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L gettable: index [

	<primitive: 'primitive_lua_gettable' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L isinteger: index [

	<primitive: 'primitive_lua_isinteger' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L len: index [

	<primitive: 'primitive_lua_len' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L next: idx [

	<primitive: 'primitive_lua_next' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pcallArgumentsSize: nargs resultsSize: nresults msgh: errfunc [

	<primitive: 'primitive_lua_pcall' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pop: n [

	<primitive: 'primitive_lua_pop' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L push: fn cclosure: n [

	<primitive: 'primitive_lua_pushcclosure' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushboolean: b [

	<primitive: 'primitive_lua_pushboolean' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushcfunction: fn [

	<primitive: 'primitive_lua_pushcfunction' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushinteger: n [

	<primitive: 'primitive_lua_pushinteger' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushnumber: n [

	<primitive: 'primitive_lua_pushnumber' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushstring: s [

	<primitive: 'primitive_lua_pushstring' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushvalue: index [

	<primitive: 'primitive_lua_pushvalue' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: state register: name cfunction: f [

	<primitive: 'primitive_lua_register' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L set: idx field: k [

	<primitive: 'primitive_lua_setfield' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L set: index i: i [

	<primitive: 'primitive_lua_seti' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L setglobal: name [

	<primitive: 'primitive_lua_setglobal' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L to: idx integerx: isnum [

	<primitive: 'primitive_lua_tointegerx' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L to: idx lstring: len [

	<primitive: 'primitive_lua_tolstring' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L toboolean: idx [

	<primitive: 'primitive_lua_toboolean' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L tonumber: idx [

	<primitive: 'primitive_lua_tonumber' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L tostring: idx [

	<primitive: 'primitive_lua_tostring' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L type: index [

	<primitive: 'primitive_lua_type' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L typename: tp [

	<primitive: 'primitive_lua_typename' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L check: arg lstring: l [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_checklstring,
	
		const char *luaL_checklstring (lua_State *L, int arg, size_t *l);
	
	Checks whether the function argument arg is a string and returns this string; 
	if l is not NULL fills its referent with the string's length.

	This function uses lua_tolstring to get its result, so all conversions and 
	caveats of that function apply here."

	^ self
		  ffiCall:
			  #( const char #* luaL_checklstring #( void #* L #, int arg #, void
			        #* l ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L check: arg type: t [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_checktype,
	
		void luaL_checktype (lua_State *L, int arg, int t)
		
	Checks whether the function argument arg has type t. 
	See lua_type for the encoding of types for t."

	^ self
		  ffiCall:
		  #( void luaL_checktype #( void #* L #, int arg #, int t ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L checknumber: arg [
	"lua_Number luaL_checknumber (lua_State *L, int arg)"

	^ self
		  ffiCall: #( double luaL_checknumber #( void #* L #, int arg ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L checkstring: arg [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_checkstring,
	
		const char *luaL_checkstring (lua_State *L, int arg);
	
	Checks whether the function argument arg is a string and returns this string.

	This function uses lua_tolstring to get its result, so all conversions and caveats of that function apply here."

	^ self luaL: L check: arg lstring: ExternalAddress null
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L dostring: s [

	<primitive: 'primitive_luaL_dostring' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L loadfile: filename [

	<primitive: 'primitive_luaL_loadfile' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L loadfile: filename x: mode [

	<primitive: 'primitive_luaL_loadfilex' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL: L loadstring: s [

	<primitive: 'primitive_luaL_loadstring' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL_openlibs: L [

	<primitive: 'primitive_luaL_openlibs' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaL_requiref: L name: modname function: openf global: glb [

	<primitive: 'primitive_luaL_requiref' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaLnewstate [

	<primitive: 'primitive_luaL_newstate' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_absindex: L index: idx [

	<primitive: 'primitive_lua_absindex' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_close: L [

	<primitive: 'primitive_lua_close' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_createtable: L narr: narr nrec: nrec [

	<primitive: 'primitive_lua_createtable' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_error: L [

	<primitive: 'primitive_lua_error' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_gettop: L [

	<primitive: 'primitive_lua_gettop' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_isnil: L at: index [

	<primitive: 'primitive_lua_isnil' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_newtable: L [

	<primitive: 'primitive_lua_newtable' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_pcallk: L nargs: nargs nresults: nresults msgh: msgh ctx: ctx k: k [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pcallk,
	
		int lua_pcallk (lua_State *L,
  		                int nargs,
      			          int nresults,
         			       int msgh,
            			    lua_KContext ctx,
               			 lua_KFunction k);
			
	This function behaves exactly like #lua_pcall:, except that it allows the called function to yield 
	(see https://www.lua.org/manual/5.4/manual.html#4.5)."

	^ self
		  ffiCall:
			  #( int lua_pcallk #( void #* L #, int nargs #, int nresults
			        #, int msgh #, int ctx #, void #* k ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_pushlightuserdata: L externalAddress: p [
	"void lua_pushlightuserdata (lua_State *L, void *p)"

	^ self
		  ffiCall:
		  #( void lua_pushlightuserdata #( void #* L #, void #* p ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_pushnil: L [
	" void lua_pushnil (lua_State *L)"

	^ self ffiCall: #( void lua_pushnil #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_remove: L at: idx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_remove,
	
		void lua_remove (lua_State *L, int index);
	
	Removes the element at the given valid index, shifting down the 
	elements above this index to fill the gap. This function cannot be 
	called with a pseudo-index, because a pseudo-index is not an actual 
	stack position."

	^ self
		  lua_rotate: L at: idx positions: -1;
		  lua: L pop: 1
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_rotate: L at: idx positions: n [
	"From https://www.lua.org/manual/5.4/manual.html#lua_rotate,
	
		void lua_rotate (lua_State *L, int idx, int n);
	
	Rotates the stack elements between the valid index idx and the top of the stack. 
	The elements are rotated n positions in the direction of the top, for a positive n, 
	or -n positions in the direction of the bottom, for a negative n. The absolute value 
	of n must not be greater than the size of the slice being rotated. This function 
	cannot be called with a pseudo-index, because a pseudo-index is not an actual stack position."

	^ self
		  ffiCall: #( void lua_rotate #( void #* L #, int idx #, int n ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_settop: L at: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_settop,
	
		void lua_settop (lua_State *L, int idx);
		
	Accepts any index, or 0, and sets the stack top to this index. If the new top is 
	greater than the old one, then the new elements are filled with nil. If index is 0, 
	then all stack elements are removed.

	This function can run arbitrary code when removing an index marked as to-be-closed from the stack."

	^ self
		  ffiCall: #( void lua_settop #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_tointeger: L at: index [

	<primitive: 'primitive_lua_tointeger' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_tonumberx: L at: idx isnumpointer: isnum [

	<primitive: 'primitive_lua_tonumberx' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_topointer: L at: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_topointer,

		const void *lua_topointer (lua_State *L, int index);
		
	Converts the value at the given index to a generic C pointer (void*). 
	The value can be a userdata, a table, a thread, a string, or a function; 
	otherwise, lua_topointer returns NULL. Different objects will give different 
	pointers. There is no way to convert the pointer back to its original value.

	Typically this function is used only for hashing and debug information."

	^ self
		  ffiCall: #( void #* lua_topointer #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_touserdata: L at: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_touserdata,
	
		void *lua_touserdata (lua_State *L, int index);
	
	If the value at the given index is a full userdata, returns its 
	memory-block address. If the value is a light userdata, returns 
	its value (a pointer). Otherwise, returns NULL."

	^ self
		  ffiCall: #( void #* lua_touserdata #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_typename: L at: i [

	<primitive: 'primitive_luaL_typename' module: 'LuaPlugin'>
	self primitiveFail
]
