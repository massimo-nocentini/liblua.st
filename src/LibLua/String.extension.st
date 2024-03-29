Extension { #name : 'String' }

{ #category : '*LibLua' }
String >> formatDateAndTime: timer localeSpecifier: locale showLocalTime: local [

	| ll |
	ll := LibLua uniqueInstance implementationPrimitive.

	^ ll withOpenedLibsStateDo: [ :L |
		  ll
			  luaL_requiref: L name: 'datetimeformatter';
			  on: L push: #datetimeformatter;
			  lua: L get: -1 field: 'compile_then_format';
			  lua_remove: L at: 1. "remove the table for the module, leaving on the stack just the function."

		  self
			  formatDateAndTime: timer
			  localeSpecifier: locale
			  showLocalTime: local
			  luaState: L
			  liblua: ll ]
]

{ #category : '*LibLua' }
String >> formatDateAndTime: timer localeSpecifier: locale showLocalTime: local luaState: L liblua: ll [

	| flag formatted |
	flag := ll
		        lua: L pushvalue: 1;
		        lua: L pushstring: self;
		        lua: L pushinteger: timer asUnixTime;
		        lua: L pushstring: locale;
		        lua: L pushinteger: timer offset asSeconds;
		        lua: L pushstring: timer timeZone abbreviation;
		        on: L push: local;
		        lua_pcall: L nargs: 6 nresults: 1.

	self assert: flag == ll LUA_OK.

	formatted := ll lua: L tostring: -1.

	ll lua: L pop: 1.

	^ formatted
]

{ #category : '*LibLua' }
String >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushstring: self
]
