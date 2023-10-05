Extension { #name : 'String' }

{ #category : '*LibLua' }
String >> formatDateAndTime: timer localeSpecifier: locale showLocalTime: local [

	| ll |
	ll := LibLua uniqueInstance.

	^ ll withOpenedLibsStateDo: [ :L |
		  ll luaL_requiref: L name: 'datetimeformatter'.

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
		        on: L push: #datetimeformatter;
		        lua_getfield: L at: -1 name: 'compile';
		        lua: L pushstring: self;
		        lua_pcall: L nargs: 1 nresults: 1.

	self assert: flag == ll LUA_OK.

	flag := ll
		        lua_getfield: L at: -2 name: 'format';
		        lua_pushvalue: L at: -2;
		        lua_pushinteger: L value: timer asUnixTime;
		        lua: L pushstring: locale;
		        lua_pushinteger: L value: timer offset asSeconds;
		        lua: L pushstring: timer timeZone abbreviation;
		        lua_pushboolean: L value: local;
		        lua_pcall: L nargs: 6 nresults: 1.

	self assert: flag == ll LUA_OK.

	formatted := ll lua: L tostring: -1.

	ll lua_pop: L nelements: 3.

	^ formatted
]

{ #category : '*LibLua' }
String >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushstring: self
]
