Class {
	#name : #LibLua,
	#superclass : #FFILibrary,
	#category : #LibLua
}

{ #category : #'instance creation' }
LibLua class >> on: aBlock [

	| lualib state |
	lualib := self uniqueInstance.

	state := LibLuaState new
		         liblua: lualib;
		         state: lualib luaL_newstate;
		         yourself.

	^ [ aBlock value: state ] ensure: [ state lua_close ]
]

{ #category : #'instance creation' }
LibLua class >> withOpenLibsOn: aBlock [

	^ self on: [ :state | 
		  state luaL_openlibs.
		  aBlock value: state ]
]

{ #category : #'as yet unclassified' }
LibLua >> ffiCallback: aBlock nresults: n [

	^ FFICallback
		  signature: #( int #( const void * a ) )
		  block: [ :aLuaState | 
			  aBlock value: aLuaState.

			  n "number of results" ]
]

{ #category : #'accessing - platform' }
LibLua >> lua: L push: fn cclosure: n [

	"void lua_pushcclosure (lua_State *L, lua_CFunction fn, int n)"

	^ self ffiCall:
		  #( void lua_pushcclosure #( void * L , void * fn , int n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushcfunction: fn [

	^ self lua: L push: fn cclosure: 0
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushinteger: n [

	"void lua_pushinteger (lua_State *L, lua_Integer n) "

	^ self ffiCall: #( void lua_pushinteger #( void * L , long n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushnumber: n [

	"void lua_pushnumber (lua_State *L, lua_Number n) "

	^ self ffiCall: #( void lua_pushnumber #( void * L , double n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L setglobal: name [

	"void lua_setglobal (lua_State *L, const char *name)"

	^ self ffiCall:
		  #( void lua_setglobal #( void * L , const char * name ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L to: idx integerx: isnum [

	"lua_Integer     (lua_tointegerx) (lua_State *L, int idx, int *isnum);"

	^ self ffiCall:
		  #( long lua_tointegerx #( void * L , int idx , void * isnum ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L to: idx lstring: len [

	"const char     *(lua_tolstring) (lua_State *L, int idx, size_t *len);"

	^ self ffiCall:
		  #( const char * lua_tolstring #( void * L , int idx , void * len ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L to: idx numberx: isnum [

	"lua_Number lua_tonumberx (lua_State *L, int idx, int *pisnum)"

	^ self ffiCall:
		  #( double lua_tonumberx #( void * L , int idx , void * isnum ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L tostring: idx [

	^ self lua: L to: idx lstring: ExternalAddress null
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L checknumber: arg [

	"lua_Number luaL_checknumber (lua_State *L, int arg)"

	^ self ffiCall: #( double luaL_checknumber #( void * L , int arg ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L loadstring: s [

	"int (luaL_loadstring) (lua_State *L, const char *s);"

	^ self ffiCall:
		  #( int luaL_loadstring #( void * L , const char * s ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL_newstate [

	^ self ffiCall: #( void * luaL_newstate #( void ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL_openlibs: L [

	"void (luaL_openlibs) (lua_State *L);"

	^ self ffiCall: #( void luaL_openlibs #( void * L ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_close: L [

	^ self ffiCall: #( void lua_close #( void * L ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_pcall: L [

	^ self
		  lua_pcall: L
		  nargs: 0
		  nresults: 0
		  errfunc: 0
]

{ #category : #'accessing - platform' }
LibLua >> lua_pcall: L nargs: nargs nresults: nresults errfunc: errfunc [

	^ self
		  lua_pcallk: L
		  nargs: nargs
		  nresults: nresults
		  errfunc: errfunc
		  lua_KContext: 0
		  lua_KFunction: ExternalAddress null
]

{ #category : #'accessing - platform' }
LibLua >> lua_pcallk: L nargs: nargs nresults: nresults errfunc: errfunc lua_KContext: ctx lua_KFunction: k [

	" int   (lua_pcallk) (lua_State *L, int nargs, int nresults, int errfunc,
                            intptr_t ctx, void * k);"

	^ self ffiCall:
		  #( int lua_pcallk #( void * L , int nargs , int nresults , int errfunc
		        , int ctx , void * k ) )
]

{ #category : #'accessing - platform' }
LibLua >> macLibraryName [

	"According to https://blog.spreendigital.de/2020/05/24/how-to-compile-lua-5-4-0-as-a-mac-os-x-dynamic-library/, 
	
	$ make macosx test MYCFLAGS=""-arch x86_64""
	$ echo 'liblua5.4.0.dylib: $(CORE_O) $(LIB_O)' >> src/makefile
	$ echo -e '\t$(CC) -dynamiclib -o $@ $^ $(LIBS) -arch x86_64 -compatibility_version 5.4.0 -current_version 5.4.0 -install_name @rpath/$@' >> src/makefile
	$ make -C src liblua5.4.0.dylib
	
	then adjust the install variable to also copy the dylib, then 
	
	$ sudo make install

	"

	^ 'liblua5.4.4.dylib'
]

{ #category : #'accessing - platform' }
LibLua >> unix64LibraryName [

	"According to https://blog.spreendigital.de/2020/05/24/how-to-compile-lua-5-4-0-for-linux-as-a-shared-library/
	 change the Makefile with
	
$(LUA_A): $(BASE_O)
	$(AR) $@ $(BASE_O)
	$(RANLIB) $@
	$(CC) -shared -ldl -Wl,-soname,liblua$R.so -o liblua$R.so $? -lm $(MYLDFLAGS)
	
	 and compile with:
	
	make ""MYCFLAGS=-fPIC"" ""R=5.4.0""
	
	"

	^ 'liblua5.4.4.so'
]
