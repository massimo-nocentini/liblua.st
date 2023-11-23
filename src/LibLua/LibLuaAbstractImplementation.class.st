"
I am an abstract class for the ways we interact with Lua.
"
Class {
	#name : 'LibLuaAbstractImplementation',
	#superclass : 'Object',
	#category : 'LibLua',
	#package : 'LibLua'
}

{ #category : 'constants - thread status' }
LibLuaAbstractImplementation >> LUA_ERRERR [

	^ 5
]

{ #category : 'constants - thread status' }
LibLuaAbstractImplementation >> LUA_ERRMEM [

	^ 4
]

{ #category : 'constants - thread status' }
LibLuaAbstractImplementation >> LUA_ERRRUN [

	^ 2
]

{ #category : 'constants - thread status' }
LibLuaAbstractImplementation >> LUA_ERRSYNTAX [

	^ 3
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCCOLLECT [

	^ 2
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCCOUNT [

	^ 3
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCCOUNTB [

	^ 4
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCGEN [

	^ 10
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCINC [

	^ 11
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCISRUNNING [

	^ 9
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCRESTART [

	^ 1
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCSETPAUSE [

	^ 6
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCSETSTEPMUL [

	^ 7
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCSTEP [

	^ 5
]

{ #category : 'constants - gc' }
LibLuaAbstractImplementation >> LUA_GCSTOP [

	^ 0
]

{ #category : 'constants - event codes' }
LibLuaAbstractImplementation >> LUA_HOOKCALL [

	^ 0
]

{ #category : 'constants - event codes' }
LibLuaAbstractImplementation >> LUA_HOOKCOUNT [

	^ 3
]

{ #category : 'constants - event codes' }
LibLuaAbstractImplementation >> LUA_HOOKLINE [

	^ 2
]

{ #category : 'constants - event codes' }
LibLuaAbstractImplementation >> LUA_HOOKRET [

	^ 1
]

{ #category : 'constants - event codes' }
LibLuaAbstractImplementation >> LUA_HOOKTAILCALL [

	^ 4
]

{ #category : 'constants - event masks' }
LibLuaAbstractImplementation >> LUA_MASKCALL [

	^ 1 << self LUA_HOOKCALL
]

{ #category : 'constants - event masks' }
LibLuaAbstractImplementation >> LUA_MASKCOUNT [

	^ 1 << self LUA_HOOKCOUNT
]

{ #category : 'constants - event masks' }
LibLuaAbstractImplementation >> LUA_MASKLINE [

	^ 1 << self LUA_HOOKLINE
]

{ #category : 'constants - event masks' }
LibLuaAbstractImplementation >> LUA_MASKRET [

	^ 1 << self LUA_HOOKRET
]

{ #category : 'constants - generic' }
LibLuaAbstractImplementation >> LUA_MINSTACK [

	^ 20
]

{ #category : 'constants - generic' }
LibLuaAbstractImplementation >> LUA_MULTRET [

	"option for multiple returns in 'lua_pcall' and 'lua_call'"

	^ -1
]

{ #category : 'constants - generic' }
LibLuaAbstractImplementation >> LUA_NUMTYPES [

	^ 9
]

{ #category : 'constants - thread status' }
LibLuaAbstractImplementation >> LUA_OK [

	^ 0
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPADD [

	^ 0
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPBAND [

	^ 7
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPBNOT [

	^ 13
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPBOR [

	^ 8
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPBXOR [

	^ 9
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPDIV [

	^ 5
]

{ #category : 'constants - comparison' }
LibLuaAbstractImplementation >> LUA_OPEQ [

	^ 0
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPIDIV [

	^ 6
]

{ #category : 'constants - comparison' }
LibLuaAbstractImplementation >> LUA_OPLE [

	^ 2
]

{ #category : 'constants - comparison' }
LibLuaAbstractImplementation >> LUA_OPLT [

	^ 1
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPMOD [

	^ 3
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPMUL [

	^ 2
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPPOW [

	^ 4
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPSHL [

	^ 10
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPSHR [

	^ 11
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPSUB [

	^ 1
]

{ #category : 'constants - arith functions' }
LibLuaAbstractImplementation >> LUA_OPUNM [

	^ 12
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TBOOLEAN [

	^ 1
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TFUNCTION [

	^ 6
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TLIGHTUSERDATA [

	^ 2
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TNIL [

	^ 0
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TNONE [

	^ -1
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TNUMBER [

	^ 3
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TSTRING [

	^ 4
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TTABLE [

	^ 5
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TTHREAD [

	^ 8
]

{ #category : 'constants - types' }
LibLuaAbstractImplementation >> LUA_TUSERDATA [

	^ 7
]

{ #category : 'constants - thread status' }
LibLuaAbstractImplementation >> LUA_YIELD [

	^ 1
]

{ #category : 'API' }
LibLuaAbstractImplementation >> _on: state at: i cache: cache [

	| typeid |
	typeid := self lua: state type: i.

	typeid = self LUA_TNIL ifTrue: [ ^ nil ].

	typeid = self LUA_TBOOLEAN ifTrue: [ 
		^ (self lua: state toboolean: i) = 1 ].

	(typeid = self LUA_TLIGHTUSERDATA or: [ typeid = self LUA_TUSERDATA ]) 
		ifTrue: [ ^ self lua_touserdata: state at: i ].

	typeid = self LUA_TNUMBER ifTrue: [ 
		^ (self lua: state isinteger: i) = 1
			  ifTrue: [ self lua_tointeger: state at: i ]
			  ifFalse: [ self lua: state tonumber: i ] ].

	typeid = self LUA_TSTRING ifTrue: [ ^ self lua: state tostring: i ].

	typeid = self LUA_TTABLE ifTrue: [ 
		| dict keysAreIntegers length |
		self lua: state len: i.
		length := self lua_tointeger: state at: -1.
		self lua: state pop: 1.
		keysAreIntegers := true.
		dict := Dictionary new.
		self table: state at: i do: [ :k :v | 
			| key value |
			key := self on: state at: k cache: cache.
			value := self on: state at: v cache: cache.

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

	^ self lua_typename: state at: i
]

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

{ #category : 'asserting' }
LibLuaAbstractImplementation >> assert: aBlock [

	^ super assert: (aBlock cull: self) = self LUA_OK
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

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L copy: fromidx to: toidx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_copy,
	
		void lua_copy (lua_State *L, int fromidx, int toidx);
	
	Copies the element at index fromidx into the valid index toidx, replacing the 
	value at that position. Values at other positions are not affected."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L get: index field: k [
	"From https://www.lua.org/manual/5.4/manual.html#lua_getfield,
	
		int lua_getfield (lua_State *L, int index, const char *k);
	
	Pushes onto the stack the value t[k], where t is the value at the given index. 
	As in Lua, this function may trigger a metamethod for the ""index"" event 
	(see https://www.lua.org/manual/5.4/manual.html#2.4).

	Returns the type of the pushed value."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L get: index field: k remove: shouldRemove [

	| type tblindex |
	tblindex := self lua_absindex: L index: index.
	type := self lua: L get: index field: k.

	shouldRemove ifTrue: [ self lua_remove: L at: tblindex ].

	^ type
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L get: index i: i [
	"From https://www.lua.org/manual/5.4/manual.html#lua_geti,
	
		int lua_geti (lua_State *L, int index, lua_Integer i);
	
	Pushes onto the stack the value t[i], where t is the value at the given index. 
	As in Lua, this function may trigger a metamethod for the ""index"" event 
	(see https://www.lua.org/manual/5.4/manual.html#2.4).

	Returns the type of the pushed value."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L getglobal: name [
	"From https://www.lua.org/manual/5.4/manual.html#lua_getglobal,
	
		int lua_getglobal (lua_State *L, const char *name);
	
	Pushes onto the stack the value of the global name. 

	Returns the type of that value."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L gettable: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_gettable,
	
		int lua_gettable (lua_State *L, int index);
	
	Pushes onto the stack the value t[k], where t is the value at 
	the given index and k is the value on the top of the stack.

	This function pops the key from the stack, pushing the resulting value 
	in its place. As in Lua, this function may trigger a metamethod for the 'index' event (see §2.4).

	Returns the type of the pushed value."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L isinteger: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_isinteger,
	
		int lua_isinteger (lua_State *L, int index);
		
	Returns 1 if the value at the given index is an integer 
	(that is, the value is a number and is represented as an integer), and 0 otherwise."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L len: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_len,
	
		void lua_len (lua_State *L, int index);
		
	Returns the length of the value at the given index. It is equivalent to 
	the '#' operator in Lua (see §3.4.7) and may trigger a metamethod for 
	the ""length"" event (see §2.4). The result is pushed on the stack."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L next: idx [
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

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pcallArgumentsSize: nargs resultsSize: nresults msgh: errfunc [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pcall,

		int lua_pcall (lua_State *L, int nargs, int nresults, int msgh);

	Calls a function (or a callable object) in protected mode.

	Both nargs and nresults have the same meaning as in lua_call. 
	If there are no errors during the call, lua_pcall behaves exactly 
	like lua_call. However, if there is any error, lua_pcall catches 
	it, pushes a single value on the stack (the error object), and returns 
	an error code. Like lua_call, lua_pcall always removes the function and 
	its arguments from the stack.

	If msgh is 0, then the error object returned on the stack is exactly the 
	original error object. Otherwise, msgh is the stack index of a message handler. 
	(This index cannot be a pseudo-index.) In case of runtime errors, this handler 
	will be called with the error object and its return value will be the object 
	returned on the stack by lua_pcall.

	Typically, the message handler is used to add more debug information to the error 
	object, such as a stack traceback. Such information cannot be gathered after the 
	return of lua_pcall, since by then the stack has unwound.

	The lua_pcall function returns one of the following status codes: 
	LUA_OK, LUA_ERRRUN, LUA_ERRMEM, or LUA_ERRERR."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pop: n [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pop,
	
		void lua_pop (lua_State *L, int n);
		
	Pops n elements from the stack. It is implemented as a macro over lua_settop."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L push: fn cclosure: n [
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

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pushboolean: b [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushboolean,
	
		void lua_pushboolean (lua_State *L, int b);
	
	Pushes a boolean value with value b onto the stack."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pushcfunction: fn [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushcfunction,
	
		void lua_pushcfunction (lua_State *L, lua_CFunction f);
	
	Pushes a C function onto the stack. 
	
	This function is equivalent to lua_pushcclosure with no upvalues."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pushinteger: n [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushinteger,
	
		void lua_pushinteger (lua_State *L, lua_Integer n);

	Pushes an integer with value n onto the stack."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pushnumber: n [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushnumber,
	
		void lua_pushnumber (lua_State *L, lua_Number n);
		
	Pushes a float with value n onto the stack.	"

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pushstring: s [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushstring
		
		const char *lua_pushstring (lua_State *L, const char *s);
		
	Pushes the zero-terminated string pointed to by s onto the stack. 
	Lua will make or reuse an internal copy of the given string, 
	so the memory at s can be freed or reused immediately after the function returns.

	Returns a pointer to the internal copy of the string (see §4.1.3).

	If s is NULL, pushes nil and returns NULL."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L pushvalue: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushvalue,
	
		void lua_pushvalue (lua_State *L, int index);
	
	Pushes a copy of the element at the given index onto the stack."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: state register: name cfunction: f [
	"From https://www.lua.org/manual/5.4/manual.html#lua_register,
	
		void lua_register (lua_State *L, const char *name, lua_CFunction f);

	Sets the C function f as the new value of global name. It is defined as a macro:

  		#define lua_register(L,n,f) (lua_pushcfunction(L, f), lua_setglobal(L, n))"

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L set: idx field: k [
	"From https://www.lua.org/manual/5.4/manual.html#lua_setfield,
		
		void lua_setfield (lua_State *L, int index, const char *k);
		
	Does the equivalent to t[k] = v, where t is the value at the given 
	index and v is the value on the top of the stack.

	This function pops the value from the stack. As in Lua, this function 
	may trigger a metamethod for the ""newindex"" event (see §2.4, 	https://www.lua.org/manual/5.4/manual.html#2.4)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L set: index i: i [
	"From https://www.lua.org/manual/5.4/manual.html#lua_seti,
	
		void lua_seti (lua_State *L, int index, lua_Integer i);
	
	Does the equivalent to t[n] = v, where t is the value at the given 
	index and v is the value on the top of the stack.

	This function pops the value from the stack. As in Lua, this function may 
	trigger a metamethod for the 'newindex' event (see §2.4)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L setglobal: name [
	"From https://www.lua.org/manual/5.4/manual.html#lua_setglobal,
	
		void lua_setglobal (lua_State *L, const char *name);

	Pops a value from the stack and sets it as the new value of global name."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L to: idx integerx: isnum [
	"From https://www.lua.org/manual/5.4/manual.html#lua_tointegerx,
	
		lua_Integer lua_tointegerx (lua_State *L, int index, int *isnum);

	Converts the Lua value at the given index to the signed integral type lua_Integer. 
	The Lua value must be an integer, or a number or string convertible to an integer 
	(see §3.4.3); otherwise, lua_tointegerx returns 0.

	If isnum is not NULL, its referent is assigned a boolean value that indicates whether the operation succeeded."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L to: idx lstring: len [
	"From https://www.lua.org/manual/5.4/manual.html#lua_tolstring,
	
		const char *lua_tolstring (lua_State *L, int index, size_t *len);

	Converts the Lua value at the given index to a C string. If len is not NULL, 
	it sets *len with the string length. The Lua value must be a string or a number; 
	otherwise, the function returns NULL. If the value is a number, then lua_tolstring 
	also changes the actual value in the stack to a string. (This change confuses 
	lua_next when lua_tolstring is applied to keys during a table traversal.)

	lua_tolstring returns a pointer to a string inside the Lua state (see §4.1.3). 
	This string always has a zero ('\0') after its last character (as in C), 
	but can contain other zeros in its body."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L toboolean: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_toboolean,
	
		int lua_toboolean (lua_State *L, int idx);
		
	Converts the Lua value at the given index to a C boolean value (0 or 1). 
	Like all tests in Lua, lua_toboolean returns true for any Lua value different 
	from false and nil; otherwise it returns false. (If you want to accept only 
	actual boolean values, use lua_isboolean to test the value's type.)"

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: state tointegerx: idx ifNotInteger: aBlock [

	| pointer value |
	pointer := ByteArray new: 4.

	value := self lua: state to: idx integerx: pointer.

	^ (pointer booleanAt: 1)
		  ifTrue: [ value ]
		  ifFalse: [ aBlock value ]
]

{ #category : 'API' }
LibLuaAbstractImplementation >> lua: L tolstring: idx do: block [

	| pointer string |
	pointer := ByteArray new: 8.

	string := self lua: L to: idx lstring: pointer.

	^ block value: string value: (pointer unsignedLongLongAt: 1)
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L tonumber: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_tonumber,
	
		lua_Number lua_tonumber (lua_State *L, int index);
	
	Equivalent to lua_tonumberx with isnum equal to NULL."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: state tonumberx: idx ifNotNumber: aBlock [

	| pointer value |
	pointer := ByteArray new: 4.

	value := self lua_tonumberx: state at: idx isnumpointer: pointer.

	^ (pointer booleanAt: 1)
		  ifTrue: [ value ]
		  ifFalse: [ aBlock value ]
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L tostring: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_tostring,
	
		const char *lua_tostring (lua_State *L, int index);
		
	Equivalent to lua_tolstring with len equal to NULL.	"

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L type: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_type,
	
		int lua_type (lua_State *L, int index);
	
	Returns the type of the value in the given valid index, or LUA_TNONE 
	for a non-valid but acceptable index. The types returned by lua_type are coded 
	by the following constants defined in lua.h: LUA_TNIL, LUA_TNUMBER, LUA_TBOOLEAN, 
	LUA_TSTRING, LUA_TTABLE, LUA_TFUNCTION, LUA_TUSERDATA, LUA_TTHREAD, and LUA_TLIGHTUSERDATA."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua: L typename: tp [
	"From https://www.lua.org/manual/5.4/manual.html#lua_typename,
	
		const char *lua_typename (lua_State *L, int tp);
	
	Returns the name of the type encoded by the value tp, which must 
	be one the values returned by lua_type."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL: L check: arg lstring: l [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_checklstring,
	
		const char *luaL_checklstring (lua_State *L, int arg, size_t *l);
	
	Checks whether the function argument arg is a string and returns this string; 
	if l is not NULL fills its referent with the string's length.

	This function uses lua_tolstring to get its result, so all conversions and 
	caveats of that function apply here."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL: L dostring: s [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_dostring,
	
		int luaL_dostring (lua_State *L, const char *str);
	
	Loads and runs the given string. It is defined as the following macro:

     (luaL_loadstring(L, str) || lua_pcall(L, 0, LUA_MULTRET, 0))

	It returns LUA_OK if there are no errors, or an error code in case of errors (see §4.4.1)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL: L loadfile: filename [

	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadfile,
	
		int luaL_loadfile (lua_State *L, const char *filename);
	
	Equivalent to luaL_loadfilex with mode equal to NULL."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL: L loadfile: filename x: mode [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadfilex,
	
		int luaL_loadfilex (lua_State *L, const char *filename, const char *mode);
	
	Loads a file as a Lua chunk. This function uses lua_load to load the chunk in the 
	file named filename. If filename is NULL, then it loads from the standard input. 
	The first line in the file is ignored if it starts with a #.

	The string mode works as in the function lua_load.

	This function returns the same results as lua_load or LUA_ERRFILE for file-related errors.

	As lua_load, this function only loads the chunk; it does not run it."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL: L loadstring: s [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_loadstring,
	
		int luaL_loadstring (lua_State *L, const char *s);
		
	Loads a string as a Lua chunk. This function uses lua_load to load the 
	chunk in the zero-terminated string s.

	This function returns the same results as lua_load.

	Also as lua_load, this function only loads the chunk; it does not run it."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL_openlibs: L [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_openlibs,
	
		void luaL_openlibs (lua_State *L);

	Opens all standard Lua libraries into the given state."

	self subclassResponsibility
]

{ #category : 'API - auxiliary' }
LibLuaAbstractImplementation >> luaL_requiref: L name: modname [

	^ self luaL_requiref: L name: modname let: modname
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaL_requiref: L name: modname function: openf global: glb [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_requiref,
	
		void luaL_requiref (lua_State *L, const char *modname, lua_CFunction openf, int glb);
	
	If package.loaded[modname] is not true, calls the function openf with the 
	string modname as an argument and sets the call result to package.loaded[modname], 
	as if that function has been called through require.

	If glb is true, also stores the module into the global modname.

	Leaves a copy of the module on the stack."

	self subclassResponsibility
]

{ #category : 'API - auxiliary' }
LibLuaAbstractImplementation >> luaL_requiref: L name: modname let: varname [

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
LibLuaAbstractImplementation >> luaL_requiref: L name: modname let: varname onErrorDo: aBlock [

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

{ #category : 'API - C' }
LibLuaAbstractImplementation >> luaLnewstate [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_newstate,
	
		lua_State *luaL_newstate (void);
		
	Creates a new Lua state. It calls lua_newstate with an allocator based on the 
	ISO C allocation functions and then sets a warning function and a panic function 
	(see §4.4) that print messages to the standard error output.

	Returns the new state, or NULL if there is a memory allocation error."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_absindex: L index: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_absindex,
	
		int lua_absindex (lua_State *L, int idx);	[-0, +0, –]
	
	Converts the acceptable index idx into an equivalent absolute 
	index (that is, one that does not depend on the stack size)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_close: L [
	"From https://www.lua.org/manual/5.4/manual.html#lua_close,
	
		void lua_close (lua_State *L);
		
	Close all active to-be-closed variables in the main thread, release all objects in 
	the given Lua state (calling the corresponding garbage-collection metamethods, if any), 
	and frees all dynamic memory used by this state.

	On several platforms, you may not need to call this function, because all resources are
	naturally released when the host program ends. On the other hand, long-running programs 
	that create multiple states, such as daemons or web servers, will probably need to close 
	states as soon as they are not needed."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_compare_le: L index: index1 anotherIndex: index2 [

	^ self
		  lua: L
		  compare: index1
		  another: index2
		  operator: self LUA_OPLE
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_compare_lt: L index: index1 anotherIndex: index2 [

	^ self
		  lua: L
		  compare: index1
		  another: index2
		  operator: self LUA_OPLT
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_createtable: L narr: narr nrec: nrec [
	"From https://www.lua.org/manual/5.4/manual.html#lua_createtable,
	
		void lua_createtable (lua_State *L, int narr, int nrec);
	
	Creates a new empty table and pushes it onto the stack. Parameter narr is a hint 
	for how many elements the table will have as a sequence; parameter nrec is a hint 
	for how many other elements the table will have. Lua may use these hints to preallocate 
	memory for the new table. This preallocation may help performance when you know 
	in advance how many elements the table will have. Otherwise you can use the function `#lua_newtable:`."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_error: L [
	"From https://www.lua.org/manual/5.4/manual.html#lua_error,
	
		int lua_error (lua_State *L);

	Raises a Lua error, using the value on the top of the stack as 
	the error object. This function does a long jump, and therefore 
	never returns (see luaL_error)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_gettop: L [
	"From https://www.lua.org/manual/5.4/manual.html#lua_gettop,
	
		int lua_gettop (lua_State *L);
		
	Returns the index of the top element in the stack. Because indices start at 1, 
	this result is equal to the number of elements in the stack; 
	in particular, 0 means an empty stack."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_isnil: L at: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_isnil,
	
		int lua_isnil (lua_State *L, int index);

	Returns 1 if the value at the given index is nil, and 0 otherwise."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_newtable: L [

	"From https://www.lua.org/manual/5.4/manual.html#lua_newtable,
	
		void lua_newtable (lua_State *L);
		
	Creates a new empty table and pushes it onto the stack. 
	It is equivalent to lua_createtable(L, 0, 0)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_pcall: L nargs: nargs lets: names [

	| flag |
	flag := self lua_pcall: L nargs: nargs nresults: names size.

	flag = self LUA_OK ifTrue: [ 
		names reverseDo: [ :var | self lua: L setglobal: var asString ] ].

	^ flag
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_pcall: L nargs: nargs nresults: nresults [

	^ self
		  lua: L
		  pcallArgumentsSize: nargs
		  resultsSize: nresults
		  msgh: 0
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_pcall: L valueWithArguments: args lets: names [

	args do: [ :arg | self on: L push: arg ].

	^ self lua_pcall: L nargs: args size lets: names
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_pcallk: L nargs: nargs nresults: nresults msgh: msgh ctx: ctx k: k [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pcallk,
	
		int lua_pcallk (lua_State *L,
  		                int nargs,
      			          int nresults,
         			       int msgh,
            			    lua_KContext ctx,
               			 lua_KFunction k);
			
	This function behaves exactly like #lua_pcall:, except that it allows the called function to yield 
	(see https://www.lua.org/manual/5.4/manual.html#4.5)."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_pushlightuserdata: L externalAddress: p [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushlightuserdata,
	
		void lua_pushlightuserdata (lua_State *L, void *p);

	Pushes a light userdata onto the stack.

	Userdata represent C values in Lua. A light userdata represents a pointer, a void*. 
	It is a value (like a number): you do not create it, it has no individual metatable, 
	and it is not collected (as it was never created). A light userdata is equal to ""any"" 
	light userdata with the same C address."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_pushnil: L [
	"From https://www.lua.org/manual/5.4/manual.html#lua_pushnil,
	
		void lua_pushnil (lua_State *L);

	Pushes a nil value onto the stack. "

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_remove: L at: idx [

	"From https://www.lua.org/manual/5.4/manual.html#lua_remove,
	
		void lua_remove (lua_State *L, int index);
	
	Removes the element at the given valid index, shifting down the 
	elements above this index to fill the gap. This function cannot be 
	called with a pseudo-index, because a pseudo-index is not an actual 
	stack position."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_rotate: L at: idx positions: n [
	"From https://www.lua.org/manual/5.4/manual.html#lua_rotate,
	
		void lua_rotate (lua_State *L, int idx, int n);
	
	Rotates the stack elements between the valid index idx and the top of the stack. 
	The elements are rotated n positions in the direction of the top, for a positive n, 
	or -n positions in the direction of the bottom, for a negative n. The absolute value 
	of n must not be greater than the size of the slice being rotated. This function 
	cannot be called with a pseudo-index, because a pseudo-index is not an actual stack position."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_settop: L at: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_settop,
	
		void lua_settop (lua_State *L, int idx);
		
	Accepts any index, or 0, and sets the stack top to this index. If the new top is 
	greater than the old one, then the new elements are filled with nil. If index is 0, 
	then all stack elements are removed.

	This function can run arbitrary code when removing an index marked as to-be-closed from the stack."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_tointeger: L at: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_tointeger,
	
		lua_Integer lua_tointeger (lua_State *L, int index);
		
	Equivalent to lua_tointegerx with isnum equal to NULL."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_tonumberx: L at: idx isnumpointer: isnum [
	"From https://www.lua.org/manual/5.4/manual.html#lua_tonumberx,
	
		lua_Number lua_tonumberx (lua_State *L, int index, int *isnum);

	Converts the Lua value at the given index to the C type lua_Number (see lua_Number). 
	The Lua value must be a number or a string convertible to a number (see §3.4.3); 
	otherwise, lua_tonumberx returns 0.

	If isnum is not NULL, its referent is assigned a boolean value that indicates whether 
	the operation succeeded."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_topointer: L at: idx [
	"From https://www.lua.org/manual/5.4/manual.html#lua_topointer,

		const void *lua_topointer (lua_State *L, int index);
		
	Converts the value at the given index to a generic C pointer (void*). 
	The value can be a userdata, a table, a thread, a string, or a function; 
	otherwise, lua_topointer returns NULL. Different objects will give different 
	pointers. There is no way to convert the pointer back to its original value.

	Typically this function is used only for hashing and debug information."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_touserdata: L at: index [
	"From https://www.lua.org/manual/5.4/manual.html#lua_touserdata,
	
		void *lua_touserdata (lua_State *L, int index);
	
	If the value at the given index is a full userdata, returns its 
	memory-block address. If the value is a light userdata, returns 
	its value (a pointer). Otherwise, returns NULL."

	self subclassResponsibility
]

{ #category : 'API - C' }
LibLuaAbstractImplementation >> lua_typename: L at: i [
	"From https://www.lua.org/manual/5.4/manual.html#luaL_typename,
	
		int luaL_typeerror (lua_State *L, int arg, const char *tname);
		
	Raises a type error for the argument arg of the C function that called it, 
	using a standard message; tname is a ""name"" for the expected type. This 
	function never returns."

	self subclassResponsibility
]

{ #category : 'API' }
LibLuaAbstractImplementation >> on: state assertLUAOK: aBlock [

	(aBlock cull: self) = self LUA_OK ifFalse: [
		self assert: false description: (self on: state at: -1) ]
]

{ #category : 'API' }
LibLuaAbstractImplementation >> on: state at: i [

	^ self on: state at: i cache: IdentityDictionary new
]

{ #category : 'API' }
LibLuaAbstractImplementation >> on: state at: i cache: cache [

	| pointerAsInteger |
	pointerAsInteger := (self lua_topointer: state at: i) asInteger.

	^ pointerAsInteger = 0
		  ifTrue: [ self _on: state at: i cache: cache ]
		  ifFalse: [ 
			  | witness obj |
			  witness := Object new.
			  obj := cache at: pointerAsInteger ifAbsentPut: [ witness ].

			  obj == witness
				  ifTrue: [ 
					  | reified |
					  reified := self _on: state at: i cache: cache.
					  witness become: reified.
					  witness ]
				  ifFalse: [ obj "easy case: already seen so return it." ] ]
]

{ #category : 'API' }
LibLuaAbstractImplementation >> on: state push: anObject [

	^ anObject pushOnLua: state liblua: self
]

{ #category : 'API' }
LibLuaAbstractImplementation >> table: L at: idx do: aBlock [

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

		self lua: L pop: 1 ]
]

{ #category : 'API' }
LibLuaAbstractImplementation >> withOpenedLibsStateDo: aBlock [

	^ self withStateDo: [ :state | 
		  self luaL_openlibs: state.
		  aBlock value: state ]
]

{ #category : 'API' }
LibLuaAbstractImplementation >> withStateDo: aBlock [

	| state |
	state := self luaLnewstate.

	^ [ aBlock value: state ] ensure: [ self lua_close: state ]
]
