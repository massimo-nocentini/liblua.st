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
