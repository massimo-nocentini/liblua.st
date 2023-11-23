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

	<primitive: 'primitive_luaL_checklstring' module: 'LuaPlugin'>
	self primitiveFail
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

	<primitive: 'primitive_lua_pcallk' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_pushlightuserdata: L externalAddress: p [

	<primitive: 'primitive_lua_pushlightuserdata' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_pushnil: L [

	<primitive: 'primitive_lua_pushnil' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_remove: L at: idx [

	<primitive: 'primitive_lua_remove' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_rotate: L at: idx positions: n [

	<primitive: 'primitive_lua_rotate' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_settop: L at: idx [

	<primitive: 'primitive_lua_settop' module: 'LuaPlugin'>
	self primitiveFail
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

	<primitive: 'primitive_lua_topointer' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_touserdata: L at: index [

	<primitive: 'primitive_lua_touserdata' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua_typename: L at: i [

	<primitive: 'primitive_luaL_typename' module: 'LuaPlugin'>
	self primitiveFail
]
