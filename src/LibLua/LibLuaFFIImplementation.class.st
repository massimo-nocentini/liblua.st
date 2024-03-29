"
I am the implementation that uses FFI calls.
"
Class {
	#name : 'LibLuaFFIImplementation',
	#superclass : 'LibLuaAbstractImplementation',
	#category : 'LibLua',
	#package : 'LibLua'
}

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L compare: index1 another: index2 operator: op [

	^ self
		  ffiCall:
		  #( int lua_compare #( void #* L #, int index1 #, int index2 #, int
		        op ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L copy: fromidx to: toidx [

	^ self
		  ffiCall:
		  #( void lua_copy #( void #* L #, int fromidx #, int toidx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L get: index field: k [

	^ self
		  ffiCall:
		  #( int lua_getfield #( void #* L #, int index #, const char #* k ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L get: index i: i [

	^ self
		  ffiCall: #( int lua_geti #( void #* L #, int index #, long i ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L getglobal: name [

	^ self
		  ffiCall:
		  #( int lua_getglobal #( void #* L #, const char #* name ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L gettable: index [

	^ self
		  ffiCall: #( int lua_gettable #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L isinteger: index [

	^ self
		  ffiCall: #( int lua_isinteger #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L len: index [

	^ self
		  ffiCall: #( void lua_len #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L next: idx [

	^ self
		  ffiCall: #( int lua_next #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pcallArgumentsSize: nargs resultsSize: nresults msgh: errfunc [

	^ self
		  lua_pcallk: L
		  nargs: nargs
		  nresults: nresults
		  msgh: errfunc
		  ctx: 0
		  k: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pop: n [

	^ self lua_settop: L at: n negated - 1
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L push: fn cclosure: n [

	^ self
		  ffiCall:
		  #( void lua_pushcclosure #( void #* L #, void #* fn #, int n ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pushboolean: b [

	^ self
		  ffiCall: #( void lua_pushboolean #( void #* L #, int b ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pushcfunction: fn [

	^ self lua: L push: fn cclosure: 0
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pushinteger: n [

	^ self
		  ffiCall: #( void lua_pushinteger #( void #* L #, long n ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pushnumber: n [

	^ self
		  ffiCall: #( void lua_pushnumber #( void #* L #, double n ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pushstring: s [

	^ self
		  ffiCall:
		  #( const char #* lua_pushstring #( void #* L #, const char #* s ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L pushvalue: index [

	^ self
		  ffiCall: #( void lua_pushvalue #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: state register: name cfunction: f [

	^ self
		  lua: state pushcfunction: f;
		  lua: state setglobal: name
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L set: idx field: k [

	^ self
		  ffiCall:
		  #( void lua_setfield #( void #* L #, int idx #, const char #* k ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L set: index i: i [

	^ self
		  ffiCall: #( void lua_seti #( void #* L #, int index #, long i ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L setglobal: name [

	^ self
		  ffiCall:
		  #( void lua_setglobal #( void #* L #, const char #* name ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L to: idx integerx: isnum [

	^ self
		  ffiCall:
		  #( long lua_tointegerx #( void #* L #, int idx #, void #* isnum ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L to: idx lstring: len [

	^ self
		  ffiCall:
		  #( const char #* lua_tolstring #( void #* L #, int idx #, void
		        #* len ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L toboolean: idx [

	^ self
		  ffiCall: #( int lua_toboolean #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L tonumber: idx [

	^ self lua_tonumberx: L at: idx isnumpointer: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L tostring: idx [

	^ self lua: L to: idx lstring: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L type: index [

	^ self
		  ffiCall: #( int lua_type #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L typename: tp [

	^ self
		  ffiCall: #( const char #* lua_typename #( void #* L #, int tp ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L check: arg lstring: l [

	^ self
		  ffiCall:
			  #( const char #* luaL_checklstring #( void #* L #, int arg #, void
			        #* l ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L check: arg type: t [

	^ self
		  ffiCall:
		  #( void luaL_checktype #( void #* L #, int arg #, int t ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L checknumber: arg [

	^ self
		  ffiCall: #( double luaL_checknumber #( void #* L #, int arg ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L checkstring: arg [

	^ self luaL: L check: arg lstring: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L dostring: s [

	| status |
	status := self luaL: L loadstring: s.

	^ status = self LUA_OK
		  ifTrue: [
			  self
				  lua: L
				  pcallArgumentsSize: 0
				  resultsSize: self LUA_MULTRET
				  msgh: 0 ]
		  ifFalse: [ status ]
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L loadfile: filename [

	^ self luaL: L loadfile: filename x: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L loadfile: filename x: mode [

	^ self
		  ffiCall:
			  #( int luaL_loadfilex #( void #* L #, const char #* filename
			        #, const char #* mode ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL: L loadstring: s [

	^ self
		  ffiCall:
		  #( int luaL_loadstring #( void #* L #, const char #* s ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL_openlibs: L [

	^ self ffiCall: #( void luaL_openlibs #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaL_requiref: L name: modname function: openf global: glb [

	^ self
		  ffiCall:
			  #( void luaL_requiref #( void #* L #, const char #* modname
			        #, void #* openf #, int glb ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> luaLnewstate [

	^ self ffiCall: #( void #* #luaL_newstate #( void ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_absindex: L index: idx [

	^ self
		  ffiCall: #( int lua_absindex #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_close: L [

	^ self ffiCall: #( void lua_close #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_createtable: L narr: narr nrec: nrec [

	^ self
		  ffiCall:
		  #( void lua_createtable #( void #* L #, int narr #, int nrec ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_error: L [

	^ self ffiCall: #( int lua_error #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_gettop: L [

	^ self ffiCall: #( int lua_gettop #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_isnil: L at: index [

	^ self
		  ffiCall: #( int lua_isnil #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_newtable: L [

	^ self lua_createtable: L narr: 0 nrec: 0
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pcallk: L nargs: nargs nresults: nresults msgh: msgh ctx: ctx k: k [

	^ self
		  ffiCall:
			  #( int lua_pcallk #( void #* L #, int nargs #, int nresults
			        #, int msgh #, int ctx #, void #* k ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pushlightuserdata: L externalAddress: p [

	^ self
		  ffiCall:
		  #( void lua_pushlightuserdata #( void #* L #, void #* p ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pushnil: L [

	^ self ffiCall: #( void lua_pushnil #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_remove: L at: idx [

	^ self
		  lua_rotate: L at: idx positions: -1;
		  lua: L pop: 1
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_rotate: L at: idx positions: n [

	^ self
		  ffiCall: #( void lua_rotate #( void #* L #, int idx #, int n ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_settop: L at: idx [

	^ self
		  ffiCall: #( void lua_settop #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_tointeger: L at: index [

	^ self lua: L to: index integerx: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_tonumberx: L at: idx isnumpointer: isnum [

	^ self
		  ffiCall:
		  #( double lua_tonumberx #( void #* L #, int idx #, void #* isnum ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_topointer: L at: idx [

	^ self
		  ffiCall: #( void #* lua_topointer #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_touserdata: L at: index [

	^ self
		  ffiCall: #( void #* lua_touserdata #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_typename: L at: i [

	^ self lua: L typename: (self lua: L type: i)
]
