Class {
	#name : #LibLua,
	#superclass : #FFILibrary,
	#classVars : [
		'LUA_MULTRET',
		'ThreadStatuses',
		'Types'
	],
	#category : #LibLua
}

{ #category : #initialization }
LibLua class >> initialize [

	"
#define LUA_TNONE		(-1)

#define LUA_TNIL		0
#define LUA_TBOOLEAN		1
#define LUA_TLIGHTUSERDATA	2
#define LUA_TNUMBER		3
#define LUA_TSTRING		4
#define LUA_TTABLE		5
#define LUA_TFUNCTION		6
#define LUA_TUSERDATA		7
#define LUA_TTHREAD		8
"

	Types := Dictionary new
		         at: #LUA_TNIL put: 0;
		         at: #LUA_TBOOLEAN put: 1;
		         at: #LUA_TLIGHTUSERDATA put: 2;
		         at: #LUA_TNUMBER put: 3;
		         at: #LUA_TSTRING put: 4;
		         at: #LUA_TTABLE put: 5;
		         at: #LUA_TFUNCTION put: 6;
		         at: #LUA_TUSERDATA put: 7;
		         at: #LUA_TTHREAD put: 8;
		         yourself.


	"/* thread status */
#define LUA_OK		0
#define LUA_YIELD	1
#define LUA_ERRRUN	2
#define LUA_ERRSYNTAX	3
#define LUA_ERRMEM	4
#define LUA_ERRERR	5"

	ThreadStatuses := Dictionary new
		                  at: #LUA_OK put: 0;
		                  at: #LUA_YIELD put: 1;
		                  at: #LUA_ERRRUN put: 2;
		                  at: #LUA_ERRSYNTAX put: 3;
		                  at: #LUA_ERRMEM put: 4;
		                  at: #LUA_ERRERR put: 5;
		                  yourself.

	"#define LUA_MULTRET	(-1)"
	LUA_MULTRET := -1
]

{ #category : #API }
LibLua >> ffiCallback: aBlock [

	^ FFICallback signature: #( int #( const void * a ) ) block: aBlock
]

{ #category : #'accessing - platform' }
LibLua >> lua: L create: narray table: nrec [

	"void lua_createtable (lua_State *L, int narray, int nrec)"

	^ self ffiCall:
		  #( void lua_createtable #( void * L , int narray , int nrec ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L get: idx i: n [

	"int lua_geti (lua_State *L, int idx, lua_Integer n)"

	^ self ffiCall: #( int lua_geti #( void * L , int idx , long n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pcallknargs: nargs nresults: nresults errfunc: errfunc lua_KContext: ctx lua_KFunction: k [

	" int   (lua_pcallk) (lua_State *L, int nargs, int nresults, int errfunc,
                            intptr_t ctx, void * k);"

	^ self ffiCall:
		  #( int lua_pcallk #( void * L , int nargs , int nresults , int errfunc
		        , int ctx , void * k ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pcallnargs: nargs nresults: nresults [

	^ self
		  lua: L
		  pcallnargs: nargs
		  nresults: nresults
		  errfunc: 0
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pcallnargs: nargs nresults: nresults errfunc: errfunc [

	^ self
		  lua: L
		  pcallknargs: nargs
		  nresults: nresults
		  errfunc: errfunc
		  lua_KContext: 0
		  lua_KFunction: ExternalAddress null
]

{ #category : #'accessing - platform' }
LibLua >> lua: L push: fn cclosure: n [

	"void lua_pushcclosure (lua_State *L, lua_CFunction fn, int n)"

	^ self ffiCall:
		  #( void lua_pushcclosure #( void * L , void * fn , int n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushboolean: b [

	" void lua_pushboolean (lua_State *L, int b)"

	^ self ffiCall: #( void lua_pushboolean #( void * L , int b ) )
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
LibLua >> lua: L pushstring: s [

	"const char *lua_pushstring (lua_State *L, const char *s)"

	^ self ffiCall:
		  #( const char * lua_pushstring #( void * L , const char * s ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L set: idx field: k [

	"void lua_setfield (lua_State *L, int idx, const char *k)"

	^ self ffiCall:
		  #( void lua_setfield #( void * L , int idx , const char * k ) )
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

{ #category : #API }
LibLua >> lua: state tointegerx: idx ifNotInteger: aBlock [

	| pointer value |
	pointer := ExternalAddress newPointer.

	^ [ 
	  value := self lua: state to: idx integerx: pointer.

	  (pointer boolean8AtOffset: 0)
		  ifTrue: [ value ]
		  ifFalse: aBlock ] ensure: [ pointer free ]
]

{ #category : #API }
LibLua >> lua: state tonumberx: idx ifNotNumber: aBlock [

	| pointer value |
	pointer := ExternalAddress newPointer.

	^ [ 
	  value := self lua: state to: idx numberx: pointer.

	  (pointer boolean8AtOffset: 0)
		  ifTrue: [ value ]
		  ifFalse: aBlock ] ensure: [ pointer free ]
]

{ #category : #'accessing - platform' }
LibLua >> lua: L tostring: idx [

	^ self lua: L to: idx lstring: ExternalAddress null
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L check: arg type: t [

	"void luaL_checktype (lua_State *L, int arg, int t)"

	^ self ffiCall:
		  #( void luaL_checktype #( void * L , int arg , int t ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L checknumber: arg [

	"lua_Number luaL_checknumber (lua_State *L, int arg)"

	^ self ffiCall: #( double luaL_checknumber #( void * L , int arg ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L dostring: s [

	"#define luaL_dostring(L, s) \
	(luaL_loadstring(L, s) || lua_pcall(L, 0, LUA_MULTRET, 0))"

	| status |
	status := self luaL: L loadstring: s.

	^ status = (self threadStatusAt: #LUA_OK)
		  ifTrue: [ 
			  self
				  lua: L
				  pcallnargs: 0
				  nresults: LUA_MULTRET
				  errfunc: 0 ]
		  ifFalse: [ status ]
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
		  lua: L
		  pcallnargs: 0
		  nresults: 0
		  errfunc: 0
]

{ #category : #'accessing - platform' }
LibLua >> lua_pushnil: L [

	" void lua_pushnil (lua_State *L)"

	^ self ffiCall: #( void lua_pushnil #( void * L ) )
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

{ #category : #API }
LibLua >> push: anObject on: state [

	^ anObject pushOnLua: state
]

{ #category : #API }
LibLua >> threadStatusAt: aTypeKey [

	^ ThreadStatuses at: aTypeKey
]

{ #category : #API }
LibLua >> typeAt: aTypeKey [

	^ Types at: aTypeKey
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

{ #category : #API }
LibLua >> withOpenedLibsStateDo: aBlock [

	^ self withStateDo: [ :state | 
		  self luaL_openlibs: state.
		  aBlock value: state ]
]

{ #category : #API }
LibLua >> withStateDo: aBlock [

	| state |
	state := self luaL_newstate.

	^ [ aBlock value: state ] ensure: [ self lua_close: state ]
]
