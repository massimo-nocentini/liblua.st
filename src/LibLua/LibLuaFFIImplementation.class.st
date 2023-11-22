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
	"const char     *(lua_tolstring) (lua_State *L, int idx, size_t *len);"

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
LibLuaFFIImplementation >> lua: state tonumberx: idx ifNotNumber: aBlock [

	| pointer value |
	pointer := ByteArray new: 4.

	value := self lua_tonumberx: state at: idx isnumpointer: pointer.

	^ (pointer int32AtOffset: 0) = 1
		  ifTrue: [ value ]
		  ifFalse: aBlock
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L tostring: idx [

	^ self lua: L to: idx lstring: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L type: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_type,
	
		int lua_type (lua_State *L, int index);
	
	Returns the type of the value in the given valid index, or LUA_TNONE 
	for a non-valid but acceptable index. The types returned by lua_type are coded 
	by the following constants defined in lua.h: LUA_TNIL, LUA_TNUMBER, LUA_TBOOLEAN, 
	LUA_TSTRING, LUA_TTABLE, LUA_TFUNCTION, LUA_TUSERDATA, LUA_TTHREAD, and LUA_TLIGHTUSERDATA."

	^ self
		  ffiCall: #( int lua_type #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua: L typename: tp [
	"From https://www.lua.org/manual/5.4/manual.html#lua_typename,
	
		const char *lua_typename (lua_State *L, int tp);
	
	Returns the name of the type encoded by the value tp, which must 
	be one the values returned by lua_type."

	^ self
		  ffiCall: #( const char #* lua_typename #( void #* L #, int tp ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL: L check: arg lstring: l [
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
LibLuaFFIImplementation >> luaL: L check: arg type: t [
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
LibLuaFFIImplementation >> luaL: L checknumber: arg [
	"lua_Number luaL_checknumber (lua_State *L, int arg)"

	^ self
		  ffiCall: #( double luaL_checknumber #( void #* L #, int arg ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL: L checkstring: arg [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_checkstring,
	
		const char *luaL_checkstring (lua_State *L, int arg);
	
	Checks whether the function argument arg is a string and returns this string.

	This function uses lua_tolstring to get its result, so all conversions and caveats of that function apply here."

	^ self luaL: L check: arg lstring: ExternalAddress null
]

{ #category : 'API - auxiliary' }
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

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL: L loadfile: filename [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadfile,
	
		int luaL_loadfile (lua_State *L, const char *filename);
	
	Equivalent to luaL_loadfilex with mode equal to NULL."

	^ self luaL: L loadfile: filename x: ExternalAddress null
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL: L loadfile: filename x: mode [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadfilex,
	
		int luaL_loadfilex (lua_State *L, const char *filename, const char *mode);
	
	Loads a file as a Lua chunk. This function uses lua_load to load the chunk in the 
	file named filename. If filename is NULL, then it loads from the standard input. 
	The first line in the file is ignored if it starts with a #.

	The string mode works as in the function lua_load.

	This function returns the same results as lua_load or LUA_ERRFILE for file-related errors.

	As lua_load, this function only loads the chunk; it does not run it."

	^ self
		  ffiCall:
			  #( int luaL_loadfilex #( void #* L #, const char #* filename
			        #, const char #* mode ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL: L loadstring: s [

	^ self
		  ffiCall:
		  #( int luaL_loadstring #( void #* L #, const char #* s ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL_openlibs: L [
	"void (luaL_openlibs) (lua_State *L);"

	^ self ffiCall: #( void luaL_openlibs #( void #* L ) ) module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL_requiref: L name: modname [

	^ self luaL_requiref: L name: modname let: modname
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL_requiref: L name: modname function: openf global: glb [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_requiref,
	
		void luaL_requiref (lua_State *L, const char *modname, lua_CFunction openf, int glb);
	
	If package.loaded[modname] is not true, calls the function openf with the 
	string modname as an argument and sets the call result to package.loaded[modname], 
	as if that function has been called through require.

	If glb is true, also stores the module into the global modname.

	Leaves a copy of the module on the stack."

	^ self
		  ffiCall:
			  #( void luaL_requiref #( void #* L #, const char #* modname
			        #, void #* openf #, int glb ) )
		  module: LibLua
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL_requiref: L name: modname let: varname [

	^ self
		  luaL_requiref: L
		  name: modname
		  let: varname
		  onErrorDo: [ :S | 
			  | errorMsg |
			  errorMsg := self on: S at: -1.
			  self error: errorMsg ]
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaL_requiref: L name: modname let: varname onErrorDo: aBlock [

	| luaCode |
	self
		luaL_requiref: L
		name: modname
		function: (self fficallbackOnBlock: [ :S | 
				 luaCode := self
					            on: S push: #require;
					            "get the module name"lua: S pushvalue: -2;
					            lua_pcall: S nargs: 1 nresults: 1.
				 1 ])
		global: false asBit.

	luaCode == self LUA_OK
		ifTrue: [ self lua: L setglobal: varname ]
		ifFalse: [ aBlock cull: L ].

	^ nil
]

{ #category : 'API - auxiliary' }
LibLuaFFIImplementation >> luaLnewstate [

	^ self ffiCall: #( void #* #luaL_newstate #( void ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_absindex: L index: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_absindex,
	
		int lua_absindex (lua_State *L, int idx);	[-0, +0, –]
	
	Converts the acceptable index idx into an equivalent absolute 
	index (that is, one that does not depend on the stack size)."

	^ self
		  ffiCall: #( int lua_absindex #( void #* L #, int idx ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_close: L [

	^ self ffiCall: #( void lua_close #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_compare_le: L index: index1 anotherIndex: index2 [

	^ self
		  lua: L
		  compare: index1
		  another: index2
		  operator: self LUA_OPLE
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_compare_lt: L index: index1 anotherIndex: index2 [

	^ self
		  lua: L
		  compare: index1
		  another: index2
		  operator: self LUA_OPLT
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_createtable: L narr: narr nrec: nrec [
	"From https://www.lua.org/manual/5.4/manual.html#lua_createtable,
	
		void lua_createtable (lua_State *L, int narr, int nrec);
	
	Creates a new empty table and pushes it onto the stack. Parameter narr is a hint 
	for how many elements the table will have as a sequence; parameter nrec is a hint 
	for how many other elements the table will have. Lua may use these hints to preallocate 
	memory for the new table. This preallocation may help performance when you know 
	in advance how many elements the table will have. Otherwise you can use the function `#lua_newtable:`."

	^ self
		  ffiCall:
		  #( void lua_createtable #( void #* L #, int narr #, int nrec ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_error: L [
	"From https://www.lua.org/manual/5.4/manual.html#lua_error,
	
		int lua_error (lua_State *L);

	Raises a Lua error, using the value on the top of the stack as 
	the error object. This function does a long jump, and therefore 
	never returns (see luaL_error)."

	^ self ffiCall: #( int lua_error #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_gettop: L [
	"From https://www.lua.org/manual/5.4/manual.html#lua_gettop,
	
		int lua_gettop (lua_State *L);
		
	Returns the index of the top element in the stack. Because indices start at 1, 
	this result is equal to the number of elements in the stack; 
	in particular, 0 means an empty stack."

	^ self ffiCall: #( int lua_gettop #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_isnil: L at: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_isnil,
	
		int lua_isnil (lua_State *L, int index);

	Returns 1 if the value at the given index is nil, and 0 otherwise."

	^ self
		  ffiCall: #( int lua_isnil #( void #* L #, int index ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_newtable: L [

	"From https://www.lua.org/manual/5.4/manual.html#lua_newtable,
	
		void lua_newtable (lua_State *L);
		
	Creates a new empty table and pushes it onto the stack. 
	It is equivalent to lua_createtable(L, 0, 0)."

	^ self lua_createtable: L narr: 0 nrec: 0
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pcall: L nargs: nargs lets: names [

	| flag |
	flag := self lua_pcall: L nargs: nargs nresults: names size.

	flag = self LUA_OK ifTrue: [ 
		names reverseDo: [ :var | self lua: L setglobal: var asString ] ].

	^ flag
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pcall: L nargs: nargs nresults: nresults [

	^ self
		  lua: L
		  pcallArgumentsSize: nargs
		  resultsSize: nresults
		  msgh: 0
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pcall: L valueWithArguments: args lets: names [

	args do: [ :arg | self on: L push: arg ].

	^ self lua_pcall: L nargs: args size lets: names
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pcallk: L nargs: nargs nresults: nresults msgh: msgh ctx: ctx k: k [
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
LibLuaFFIImplementation >> lua_pushlightuserdata: L externalAddress: p [
	"void lua_pushlightuserdata (lua_State *L, void *p)"

	^ self
		  ffiCall:
		  #( void lua_pushlightuserdata #( void #* L #, void #* p ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_pushnil: L [
	" void lua_pushnil (lua_State *L)"

	^ self ffiCall: #( void lua_pushnil #( void #* L ) ) module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_remove: L at: idx [

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
LibLuaFFIImplementation >> lua_rotate: L at: idx positions: n [
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
LibLuaFFIImplementation >> lua_settop: L at: idx [
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
LibLuaFFIImplementation >> lua_tointeger: L at: index [

	^ self lua: L to: index integerx: ExternalAddress null
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_tonumberx: L at: idx isnumpointer: isnum [
	"lua_Number lua_tonumberx (lua_State *L, int idx, int *pisnum)"

	^ self
		  ffiCall:
		  #( double lua_tonumberx #( void #* L #, int idx #, void #* isnum ) )
		  module: LibLua
]

{ #category : 'API - C' }
LibLuaFFIImplementation >> lua_topointer: L at: idx [
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
LibLuaFFIImplementation >> lua_touserdata: L at: index [
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
LibLuaFFIImplementation >> lua_typename: L at: i [

	^ self lua: L typename: (self lua: L type: i)
]
