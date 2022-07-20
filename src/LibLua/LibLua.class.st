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
LibLua >> lua: L create: narr table: nrec [

	"From https://www.lua.org/manual/5.4/manual.html#lua_createtable,
	
		void lua_createtable (lua_State *L, int narr, int nrec);
	
	Creates a new empty table and pushes it onto the stack. Parameter narr is a hint 
	for how many elements the table will have as a sequence; parameter nrec is a hint 
	for how many other elements the table will have. Lua may use these hints to preallocate 
	memory for the new table. This preallocation may help performance when you know 
	in advance how many elements the table will have. Otherwise you can use the function `#lua_newtable:`."

	^ self ffiCall:
		  #( void lua_createtable #( void * L , int narr , int nrec ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L get: index field: k [

	"From https://www.lua.org/manual/5.4/manual.html#lua_getfield,
	
		int lua_getfield (lua_State *L, int index, const char *k);
	
	Pushes onto the stack the value t[k], where t is the value at the given index. 
	As in Lua, this function may trigger a metamethod for the ""index"" event 
	(see https://www.lua.org/manual/5.4/manual.html#2.4).

Returns the type of the pushed value.
"

	^ self ffiCall:
		  #( int lua_getfield #( void * L , int index , const char * k ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L get: index i: i [

	"From https://www.lua.org/manual/5.4/manual.html#lua_geti,
	
		int lua_geti (lua_State *L, int index, lua_Integer i);
	
	Pushes onto the stack the value t[i], where t is the value at the given index. 
	As in Lua, this function may trigger a metamethod for the ""index"" event 
	(see https://www.lua.org/manual/5.4/manual.html#2.4).

	Returns the type of the pushed value."

	^ self ffiCall: #( int lua_geti #( void * L , int index , long i ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L getglobal: name [

	"From https://www.lua.org/manual/5.4/manual.html#lua_getglobal,
	
		int lua_getglobal (lua_State *L, const char *name);
	
	Pushes onto the stack the value of the global name. 

	Returns the type of that value."

	^ self ffiCall:
		  #( void lua_getglobal #( void * L , const char * name ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pcallknargs: nargs nresults: nresults errfunc: errfunc lua_KContext: ctx lua_KFunction: k [

	"From https://www.lua.org/manual/5.4/manual.html#lua_pcallk,
	
		int lua_pcallk (lua_State *L,
  		                int nargs,
      			          int nresults,
         			       int msgh,
            			    lua_KContext ctx,
               			 lua_KFunction k);
			
	This function behaves exactly like #lua_pcall:, except that it allows the called function to yield 
	(see https://www.lua.org/manual/5.4/manual.html#4.5)."

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

	"From https://www.lua.org/manual/5.4/manual.html#lua_pushcclosure,
	
		void lua_pushcclosure (lua_State *L, lua_CFunction fn, int n);
	
	Pushes a new C closure onto the stack. 
	
	This function receives a pointer to a C function and pushes onto the 
	stack a Lua value of type function that, when called, invokes the corresponding 
	C function. The parameter n tells how many upvalues this function will have 
	(see https://www.lua.org/manual/5.4/manual.html#4.2).

	Any function to be callable by Lua must follow the correct protocol to receive 
	its parameters and return its results (see 
	https://www.lua.org/manual/5.4/manual.html#lua_CFunction).

	When a C function is created, it is possible to associate some values with it, 
	the so called upvalues; these upvalues are then accessible to the function whenever 
	it is called. This association is called a C closure (see §4.2). To create a C 
	closure, first the initial values for its upvalues must be pushed onto the stack. 
	(When there are multiple upvalues, the first value is pushed first.) 
	
	Then lua_pushcclosure is called to create and push the C function onto the stack, 
	with the argument n telling how many values will be associated with the function. 
	lua_pushcclosure also pops these values from the stack.
	
	The maximum value for n is 255.

	When n is zero, this function creates a light C function, which is just a pointer 
	to the C function. In that case, it never raises a memory error."

	^ self ffiCall:
		  #( void lua_pushcclosure #( void * L , void * fn , int n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushboolean: b [

	"From https://www.lua.org/manual/5.4/manual.html#lua_pushboolean,
	
		void lua_pushboolean (lua_State *L, int b);
	
	Pushes a boolean value with value b onto the stack."

	^ self ffiCall: #( void lua_pushboolean #( void * L , int b ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushcfunction: fn [

	"From https://www.lua.org/manual/5.4/manual.html#lua_pushcfunction,
	
		void lua_pushcfunction (lua_State *L, lua_CFunction f);
	
	Pushes a C function onto the stack. 
	
	This function is equivalent to lua_pushcclosure with no upvalues."

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
LibLua >> lua_newtable: L [

	"void lua_newtable (lua_State *L);
	
Creates a new empty table and pushes it onto the stack. 
It is equivalent to lua_createtable(L, 0, 0)."

	^ self lua: L create: 0 table: 0
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
