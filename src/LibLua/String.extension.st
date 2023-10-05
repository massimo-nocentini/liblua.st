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

	| flag |
	flag := ll
		        on: L push: #datetimeformatter;
		        lua_getfield: L at: -1 name: 'compile';
		        on: L push: self;
		        lua_pcall: L nargs: 1 nresults: 1.

	self assert: flag == ll LUA_OK.

	flag := ll
		        lua_getfield: L at: -2 name: 'format';
		        lua_pushvalue: L at: -2;
		        on: L push: timer asUnixTime;
		        on: L push: locale , '.utf8';
		        on: L push: timer offset asSeconds;
		        on: L push: timer timeZone abbreviation;
		        on: L push: local;
		        lua_pcall: L nargs: 6 nresults: 1.

	self assert: flag == ll LUA_OK.

	^ ll lua: L tostring: -1
]

{ #category : '*LibLua' }
String >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushstring: self
]
