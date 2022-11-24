Class {
	#name : #LibLua,
	#superclass : #FFILibrary,
	#classVars : [
		'LUA_ERRERR',
		'LUA_ERRMEM',
		'LUA_ERRRUN',
		'LUA_ERRSYNTAX',
		'LUA_MULTRET',
		'LUA_NUMTYPES',
		'LUA_OK',
		'LUA_TBOOLEAN',
		'LUA_TFUNCTION',
		'LUA_TLIGHTUSERDATA',
		'LUA_TNIL',
		'LUA_TNONE',
		'LUA_TNUMBER',
		'LUA_TSTRING',
		'LUA_TTABLE',
		'LUA_TTHREAD',
		'LUA_TUSERDATA',
		'LUA_YIELD',
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
	LUA_MULTRET := -1.

	"thread status"
	LUA_OK := 0.
	LUA_YIELD := 1.
	LUA_ERRRUN := 2.
	LUA_ERRSYNTAX := 3.
	LUA_ERRMEM := 4.
	LUA_ERRERR := 5.

	"basic types"
	LUA_TNONE := -1.

	LUA_TNIL := 0.
	LUA_TBOOLEAN := 1.
	LUA_TLIGHTUSERDATA := 2.
	LUA_TNUMBER := 3.
	LUA_TSTRING := 4.
	LUA_TTABLE := 5.
	LUA_TFUNCTION := 6.
	LUA_TUSERDATA := 7.
	LUA_TTHREAD := 8.

	LUA_NUMTYPES := 9
]

{ #category : #'constants - thread status' }
LibLua >> LUA_ERRERR [

	^ 5
]

{ #category : #'constants - thread status' }
LibLua >> LUA_ERRMEM [

	^ 4
]

{ #category : #'constants - thread status' }
LibLua >> LUA_ERRRUN [

	^ 2
]

{ #category : #'constants - thread status' }
LibLua >> LUA_ERRSYNTAX [

	^ 3
]

{ #category : #'constants - generic' }
LibLua >> LUA_MINSTACK [

	^ 20
]

{ #category : #'constants - generic' }
LibLua >> LUA_MULTRET [

	"option for multiple returns in 'lua_pcall' and 'lua_call'"

	^ -1
]

{ #category : #'constants - generic' }
LibLua >> LUA_NUMTYPES [

	^ 9
]

{ #category : #'constants - thread status' }
LibLua >> LUA_OK [

	^ 0
]

{ #category : #'constants - comparison' }
LibLua >> LUA_OPEQ [

	^ 0
]

{ #category : #'constants - comparison' }
LibLua >> LUA_OPLE [

	^ 2
]

{ #category : #'constants - comparison' }
LibLua >> LUA_OPLT [

	^ 1
]

{ #category : #'constants - types' }
LibLua >> LUA_TBOOLEAN [

	^ 1
]

{ #category : #'constants - types' }
LibLua >> LUA_TFUNCTION [

	^ 6
]

{ #category : #'constants - types' }
LibLua >> LUA_TLIGHTUSERDATA [

	^ 2
]

{ #category : #'constants - types' }
LibLua >> LUA_TNIL [

	^ 0
]

{ #category : #'constants - types' }
LibLua >> LUA_TNONE [

	^ -1
]

{ #category : #'constants - types' }
LibLua >> LUA_TNUMBER [

	^ 3
]

{ #category : #'constants - types' }
LibLua >> LUA_TSTRING [

	^ 4
]

{ #category : #'constants - types' }
LibLua >> LUA_TTABLE [

	^ 5
]

{ #category : #'constants - types' }
LibLua >> LUA_TTHREAD [

	^ 8
]

{ #category : #'constants - types' }
LibLua >> LUA_TUSERDATA [

	^ 7
]

{ #category : #'constants - thread status' }
LibLua >> LUA_YIELD [

	^ 1
]

{ #category : #API }
LibLua >> appendOnLuaRepositoryOnPackagePathOf: state [

	^ self
		  luaL: state
		  dostring:
		  'package.path = package.path .. ";/usr/local/share/lua/5.4/?.lua"'
]

{ #category : #API }
LibLua >> ffiCallback: aBlock [

	^ FFICallback signature: #( int #( const void * a ) ) block: aBlock
]

{ #category : #'accessing - platform' }
LibLua >> lua: L copy: fromidx to: toidx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_copy,
	
		void lua_copy (lua_State *L, int fromidx, int toidx);
	
	Copies the element at index fromidx into the valid index toidx, replacing the 
	value at that position. Values at other positions are not affected."

	^ self ffiCall:
		  #( void lua_copy #( void * L , int fromidx , int toidx ) )
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
		  #( int lua_getglobal #( void * L , const char * name ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L gettable: index [

	"From https://www.lua.org/manual/5.4/manual.html#lua_gettable,
	
		int lua_gettable (lua_State *L, int index);
	
	Pushes onto the stack the value t[k], where t is the value at 
	the given index and k is the value on the top of the stack.

	This function pops the key from the stack, pushing the resulting value 
	in its place. As in Lua, this function may trigger a metamethod for the 'index' event (see §2.4).

	Returns the type of the pushed value."

	^ self ffiCall: #( int lua_gettable #( void * L , int index ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L isinteger: index [

	"From https://www.lua.org/manual/5.4/manual.html#lua_isinteger,
	
		int lua_isinteger (lua_State *L, int index);
		
	Returns 1 if the value at the given index is an integer 
	(that is, the value is a number and is represented as an integer), and 0 otherwise."

	^ self ffiCall: #( int lua_isinteger #( void * L , int index ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L len: index [

	"From https://www.lua.org/manual/5.4/manual.html#lua_len,
	
		void lua_len (lua_State *L, int index);
		
	Returns the length of the value at the given index. It is equivalent to 
	the '#' operator in Lua (see §3.4.7) and may trigger a metamethod for 
	the ""length"" event (see §2.4). The result is pushed on the stack."

	^ self ffiCall: #( void lua_len #( void * L , int index ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L next: idx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_next,
	
		int lua_next (lua_State *L, int idx);
	
	Pops a key from the stack, and pushes a key–value pair from the table at the given index, 
	the ""next"" pair after the given key. If there are no more elements in the table, 
	then lua_next returns 0 and pushes nothing.

	A typical table traversal looks like this:

     /* table is in the stack at index 't' */
     lua_pushnil(L);  /* first key */
     while (lua_next(L, t) != 0) {
       /* uses 'key' (at index -2) and 'value' (at index -1) */
       printf(""%s - %s\n"",
              lua_typename(L, lua_type(L, -2)),
              lua_typename(L, lua_type(L, -1)));
       /* removes 'value'; keeps 'key' for next iteration */
       lua_pop(L, 1);
     }

	While traversing a table, avoid calling lua_tolstring directly on a key, 
	unless you know that the key is actually a string. Recall that lua_tolstring may change 
	the value at the given index; this confuses the next call to lua_next.

	This function may raise an error if the given key is neither nil nor present in the table. 
	See function next for the caveats of modifying the table during its traversal."

	^ self ffiCall: #( int lua_next #( void * L , int idx ) )
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

	"From https://www.lua.org/manual/5.4/manual.html#lua_pushinteger,
	
		void lua_pushinteger (lua_State *L, lua_Integer n);

	Pushes an integer with value n onto the stack."

	^ self ffiCall: #( void lua_pushinteger #( void * L , long n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushnumber: n [

	"From https://www.lua.org/manual/5.4/manual.html#lua_pushnumber,
	
		void lua_pushnumber (lua_State *L, lua_Number n);
		
	Pushes a float with value n onto the stack.	"

	^ self ffiCall: #( void lua_pushnumber #( void * L , double n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L pushstring: s [

	"const char *lua_pushstring (lua_State *L, const char *s)"

	^ self ffiCall:
		  #( const char * lua_pushstring #( void * L , const char * s ) )
]

{ #category : #API }
LibLua >> lua: state register: name cfunction: f [

	"From https://www.lua.org/manual/5.4/manual.html#lua_register,
	
		void lua_register (lua_State *L, const char *name, lua_CFunction f);

	Sets the C function f as the new value of global name. It is defined as a macro:

  		#define lua_register(L,n,f) (lua_pushcfunction(L, f), lua_setglobal(L, n))"

	^ self
		  lua: state pushcfunction: f;
		  lua: state setglobal: name
]

{ #category : #'accessing - platform' }
LibLua >> lua: L require: modname f: openf [

	^ self
		  lua: L
		  require: modname
		  f: openf
		  global: 0
]

{ #category : #'accessing - platform' }
LibLua >> lua: L require: modname f: openf global: glb [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_requiref,
	
		void luaL_requiref (lua_State *L, const char *modname, lua_CFunction openf, int glb);
	
	If package.loaded[modname] is not true, calls the function openf with the 
	string modname as an argument and sets the call result to package.loaded[modname], 
	as if that function has been called through require.

	If glb is true, also stores the module into the global modname.

	Leaves a copy of the module on the stack."

	^ self ffiCall:
		  #( void luaL_requiref #( void * L , const char * modname , void
		        * openf , int glb ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L requireGlobal: modname f: openf [

	^ self
		  lua: L
		  require: modname
		  f: openf
		  global: 1
]

{ #category : #'accessing - platform' }
LibLua >> lua: L set: idx field: k [

	"void lua_setfield (lua_State *L, int idx, const char *k)"

	^ self ffiCall:
		  #( void lua_setfield #( void * L , int idx , const char * k ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L set: index i: i [

	"From https://www.lua.org/manual/5.4/manual.html#lua_seti,
	
		void lua_seti (lua_State *L, int index, lua_Integer i);
	
	Does the equivalent to t[n] = v, where t is the value at the given 
	index and v is the value on the top of the stack.

	This function pops the value from the stack. As in Lua, this function may 
	trigger a metamethod for the 'newindex' event (see §2.4)."

	^ self ffiCall: #( void lua_seti #( void * L , int index , long i ) )
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
LibLua >> lua: L toboolean: idx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_toboolean,
	
		int lua_toboolean (lua_State *L, int idx);
		
	Converts the Lua value at the given index to a C boolean value (0 or 1). 
	Like all tests in Lua, lua_toboolean returns true for any Lua value different 
	from false and nil; otherwise it returns false. (If you want to accept only 
	actual boolean values, use lua_isboolean to test the value's type.)"

	^ self ffiCall: #( int lua_toboolean #( void * L , int idx ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L tointeger: index [

	"From https://www.lua.org/manual/5.4/manual.html#lua_tointeger,
	
		lua_Integer lua_tointeger (lua_State *L, int index);
		
	Equivalent to lua_tointegerx with isnum equal to NULL."

	^ self lua: L to: index integerx: ExternalAddress null
]

{ #category : #API }
LibLua >> lua: state tointegerx: idx ifNotInteger: aBlock [

	| pointer value |
	pointer := 0 pointer.

	value := self lua: state to: idx integerx: pointer.

	^ (pointer boolean8AtOffset: 0)
		  ifTrue: [ value ]
		  ifFalse: aBlock
]

{ #category : #'accessing - platform' }
LibLua >> lua: L tonumber: idx [

	^ self lua: L to: idx numberx: ExternalAddress null
]

{ #category : #API }
LibLua >> lua: state tonumberx: idx ifNotNumber: aBlock [

	| pointer value |
	pointer := 0.0 pointer.

	value := self lua: state to: idx numberx: pointer.

	^ (pointer boolean8AtOffset: 0)
		  ifTrue: [ value ]
		  ifFalse: aBlock
]

{ #category : #'accessing - platform' }
LibLua >> lua: L tostring: idx [

	^ self lua: L to: idx lstring: ExternalAddress null
]

{ #category : #'accessing - platform' }
LibLua >> lua: L touserdata: index [

	"From https://www.lua.org/manual/5.4/manual.html#lua_touserdata,
	
		void *lua_touserdata (lua_State *L, int index);
	
	If the value at the given index is a full userdata, returns its 
	memory-block address. If the value is a light userdata, returns 
	its value (a pointer). Otherwise, returns NULL."

	^ self ffiCall: #( void * lua_touserdata #( void * L , int index ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L type: index [

	"From https://www.lua.org/manual/5.4/manual.html#lua_type,
	
		int lua_type (lua_State *L, int index);
	
	Returns the type of the value in the given valid index, or LUA_TNONE 
	for a non-valid but acceptable index. The types returned by lua_type are coded 
	by the following constants defined in lua.h: LUA_TNIL, LUA_TNUMBER, LUA_TBOOLEAN, 
	LUA_TSTRING, LUA_TTABLE, LUA_TFUNCTION, LUA_TUSERDATA, LUA_TTHREAD, and LUA_TLIGHTUSERDATA."

	^ self ffiCall: #( int lua_type #( void * L , int index ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua: L typename: tp [

	"From https://www.lua.org/manual/5.4/manual.html#lua_typename,
	
		const char *lua_typename (lua_State *L, int tp);
	
	Returns the name of the type encoded by the value tp, which must 
	be one the values returned by lua_type."

	^ self ffiCall: #( const char * lua_typename #( void * L , int tp ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L check: arg lstring: l [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_checklstring,
	
		const char *luaL_checklstring (lua_State *L, int arg, size_t *l);
	
	Checks whether the function argument arg is a string and returns this string; 
	if l is not NULL fills its referent with the string's length.

	This function uses lua_tolstring to get its result, so all conversions and 
	caveats of that function apply here."

	^ self ffiCall:
		  #( const char * luaL_checklstring #( void * L , int arg , void
		        * l ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L check: arg type: t [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_checktype,
	
		void luaL_checktype (lua_State *L, int arg, int t)
		
	Checks whether the function argument arg has type t. 
	See lua_type for the encoding of types for t."

	^ self ffiCall:
		  #( void luaL_checktype #( void * L , int arg , int t ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L checknumber: arg [

	"lua_Number luaL_checknumber (lua_State *L, int arg)"

	^ self ffiCall: #( double luaL_checknumber #( void * L , int arg ) )
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L checkstring: arg [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_checkstring,
	
		const char *luaL_checkstring (lua_State *L, int arg);
	
	Checks whether the function argument arg is a string and returns this string.

	This function uses lua_tolstring to get its result, so all conversions and caveats of that function apply here."

	^ self luaL: L check: arg lstring: ExternalAddress null
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
LibLua >> luaL: L loadfile: filename [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadfile,
	
		int luaL_loadfile (lua_State *L, const char *filename);
	
	Equivalent to luaL_loadfilex with mode equal to NULL."

	^ self luaL: L loadfile: filename x: ExternalAddress null
]

{ #category : #'accessing - platform' }
LibLua >> luaL: L loadfile: filename x: mode [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadfilex,
	
		int luaL_loadfilex (lua_State *L, const char *filename, const char *mode);
	
	Loads a file as a Lua chunk. This function uses lua_load to load the chunk in the 
	file named filename. If filename is NULL, then it loads from the standard input. 
	The first line in the file is ignored if it starts with a #.

	The string mode works as in the function lua_load.

	This function returns the same results as lua_load or LUA_ERRFILE for file-related errors.

	As lua_load, this function only loads the chunk; it does not run it."

	^ self ffiCall:
		  #( int luaL_loadfilex #( void * L , const char * filename , const
		        char * mode ) )
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
LibLua >> lua_absindex: L index: idx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_absindex,
	
		int lua_absindex (lua_State *L, int idx);	[-0, +0, –]
	
	Converts the acceptable index idx into an equivalent absolute 
	index (that is, one that does not depend on the stack size)."

	^ self ffiCall: #( int lua_absindex #( void * L , int idx ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_close: L [

	^ self ffiCall: #( void lua_close #( void * L ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_compare: L index: index1 anotherIndex: index2 operator: op [

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

	^ self ffiCall:
		  #( int lua_compare #( void * L , int index1 , int index2 , int op ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_compare_eq: L index: index1 anotherIndex: index2 [

	"#define LUA_OPEQ	0"

	^ self
		  lua_compare: L
		  index: index1
		  anotherIndex: index2
		  operator: 0
]

{ #category : #'accessing - platform' }
LibLua >> lua_compare_le: L index: index1 anotherIndex: index2 [

	"#define LUA_OPLE	2"

	^ self
		  lua_compare: L
		  index: index1
		  anotherIndex: index2
		  operator: 2
]

{ #category : #'accessing - platform' }
LibLua >> lua_compare_lt: L index: index1 anotherIndex: index2 [

	"#define LUA_OPLT	1"

	^ self
		  lua_compare: L
		  index: index1
		  anotherIndex: index2
		  operator: 1
]

{ #category : #'accessing - platform' }
LibLua >> lua_gettop: L [

	"From https://www.lua.org/manual/5.4/manual.html#lua_gettop,
	
		int lua_gettop (lua_State *L);
		
	Returns the index of the top element in the stack. Because indices start at 1, 
	this result is equal to the number of elements in the stack; 
	in particular, 0 means an empty stack."

	^ self ffiCall: #( int lua_gettop #( void * L ) )
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
LibLua >> lua_pop: L elements: n [

	"From https://www.lua.org/manual/5.4/manual.html#lua_pop,
	
		void lua_pop (lua_State *L, int n);
		
	Pops n elements from the stack. It is implemented as a macro over lua_settop."

	^ self lua_settop: L index: n negated - 1
]

{ #category : #'accessing - platform' }
LibLua >> lua_pushlightuserdata: L pointer: p [

	"void lua_pushlightuserdata (lua_State *L, void *p)"

	^ self ffiCall:
		  #( void lua_pushlightuserdata #( void * L , void * p ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_pushnil: L [

	" void lua_pushnil (lua_State *L)"

	^ self ffiCall: #( void lua_pushnil #( void * L ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_remove: L index: idx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_remove,
	
		void lua_remove (lua_State *L, int index);
	
	Removes the element at the given valid index, shifting down the 
	elements above this index to fill the gap. This function cannot be 
	called with a pseudo-index, because a pseudo-index is not an actual 
	stack position."

	^ self
		  lua_rotate: L index: idx positions: -1;
		  lua_pop: L elements: 1
]

{ #category : #'accessing - platform' }
LibLua >> lua_rotate: L index: idx positions: n [

	"From https://www.lua.org/manual/5.4/manual.html#lua_rotate,
	
		void lua_rotate (lua_State *L, int idx, int n);
	
	Rotates the stack elements between the valid index idx and the top of the stack. 
	The elements are rotated n positions in the direction of the top, for a positive n, 
	or -n positions in the direction of the bottom, for a negative n. The absolute value 
	of n must not be greater than the size of the slice being rotated. This function 
	cannot be called with a pseudo-index, because a pseudo-index is not an actual stack position."

	^ self ffiCall: #( void lua_rotate #( void * L , int idx , int n ) )
]

{ #category : #'accessing - platform' }
LibLua >> lua_settop: L index: idx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_settop,
	
		void lua_settop (lua_State *L, int idx);
		
	Accepts any index, or 0, and sets the stack top to this index. If the new top is 
	greater than the old one, then the new elements are filled with nil. If index is 0, 
	then all stack elements are removed.

	This function can run arbitrary code when removing an index marked as to-be-closed from the stack."

	^ self ffiCall: #( void lua_settop #( void * L , int idx ) )
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

	^ anObject pushOnLua: state liblua: self
]

{ #category : #affecting }
LibLua >> read: i from: state [

	| typeid |
	typeid := self lua: state type: i.

	typeid = (self typeAt: #LUA_TNIL) ifTrue: [ ^ nil ].

	typeid = (self typeAt: #LUA_TBOOLEAN) ifTrue: [ 
		^ (self lua: state toboolean: i) = 1 ].

	(typeid = (self typeAt: #LUA_TLIGHTUSERDATA) or: [ 
		 typeid = (self typeAt: #LUA_TUSERDATA) ]) ifTrue: [ 
		^ self lua: state touserdata: i ].

	typeid = (self typeAt: #LUA_TNUMBER) ifTrue: [ 
		^ (self lua: state isinteger: i) = 1
			  ifTrue: [ self lua: state tointeger: i ]
			  ifFalse: [ self lua: state tonumber: i ] ].

	typeid = (self typeAt: #LUA_TSTRING) ifTrue: [ 
		^ self lua: state tostring: i ].

	typeid = (self typeAt: #LUA_TTABLE) ifTrue: [ 
		| dict keysAreIntegers length |
		self lua: state len: i.
		length := self lua: state tointeger: -1.
		self lua_pop: state elements: 1.
		keysAreIntegers := true.
		dict := Dictionary new.
		self table: state at: i do: [ :k :v | 
			| key value |
			key := self read: k from: state.
			value := self read: v from: state.
			dict at: key put: value.
			keysAreIntegers := keysAreIntegers and: [ 
				                   key isInteger and: [ 
					                   key between: 1 and: length ] ] ].

		^ keysAreIntegers
			  ifTrue: [ 
				  | array |
				  array := Array new: dict size.
				  dict keysAndValuesDo: [ :k :v | array at: k put: v ].
				  array ]
			  ifFalse: [ dict ] ].

	self shouldBeImplemented
]

{ #category : #API }
LibLua >> require: name heapkt: state [

	^ self luaL: state dostring: name , ' = require "heapkt"'
]

{ #category : #API }
LibLua >> require: name heapq: state [

	^ self luaL: state dostring: name , ' = require "heapq"'
]

{ #category : #API }
LibLua >> require: name operator: state [

	^ self luaL: state dostring: name , ' = require "operator"'
]

{ #category : #'accessing - platform' }
LibLua >> table: L at: idx do: aBlock [

	"A typical table traversal looks like this:

     /* table is in the stack at index 't' */
     lua_pushnil(L);  /* first key */
     while (lua_next(L, t) != 0) {
       /* uses 'key' (at index -2) and 'value' (at index -1) */
       printf(""%s - %s\n"",
              lua_typename(L, lua_type(L, -2)),
              lua_typename(L, lua_type(L, -1)));
       /* removes 'value'; keeps 'key' for next iteration */
       lua_pop(L, 1);
     }
	"

	| index |
	self lua_pushnil: L.

	index := idx negative
		         ifTrue: [ idx - 1 ]
		         ifFalse: [ idx ].

	[ (self lua: L next: index) = 0 ] whileFalse: [ 
		aBlock value: -2 value: -1.

		self lua_pop: L elements: 1 ]
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

{ #category : #'accessing platform' }
LibLua >> win32LibraryName [

	^ FFIWindowsLibraryFinder findAnyLibrary: #( 'liblua54.dll' )
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
