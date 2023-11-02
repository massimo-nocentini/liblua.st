"
I am the implementation via a VM plugin.
"
Class {
	#name : 'LibLuaPrimitiveImplementation',
	#superclass : 'LibLuaFFIImplementation',
	#category : 'LibLua',
	#package : 'LibLua'
}

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
LibLuaPrimitiveImplementation >> lua: L pushboolean: b [

	<primitive: 'primitive_lua_pushboolean' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushbooleanAsInteger: b [

	^ self lua: L pushboolean: true asBit == b
]

{ #category : 'API - C' }
LibLuaPrimitiveImplementation >> lua: L pushinteger: n [

	<primitive: 'primitive_lua_pushinteger' module: 'LuaPlugin'>
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
LibLuaPrimitiveImplementation >> lua: L tostring: idx [

	<primitive: 'primitive_lua_tostring' module: 'LuaPlugin'>
	self primitiveFail
]

{ #category : 'API - auxiliary' }
LibLuaPrimitiveImplementation >> luaLnewstate [

	<primitive: 'primitive_luaL_newstate' module: 'LuaPlugin'>
	self primitiveFail
]
