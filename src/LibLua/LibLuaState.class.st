Class {
	#name : #LibLuaState,
	#superclass : #Object,
	#instVars : [
		'liblua',
		'state'
	],
	#category : #LibLua
}

{ #category : #accessing }
LibLuaState >> liblua [

	^ liblua
]

{ #category : #accessing }
LibLuaState >> liblua: anObject [

	liblua := anObject
]

{ #category : #'as yet unclassified' }
LibLuaState >> luaL_loadstring: s [

	^ liblua luaL: state loadstring: s
]

{ #category : #'as yet unclassified' }
LibLuaState >> luaL_openlibs [

	^ liblua luaL_openlibs: state
]

{ #category : #'as yet unclassified' }
LibLuaState >> lua_close [

	^ liblua lua_close: state
]

{ #category : #'as yet unclassified' }
LibLuaState >> lua_pcall [

	^ liblua lua_pcall: state
]

{ #category : #'as yet unclassified' }
LibLuaState >> lua_pcallNargs: nargs nresults: nresults [

	^ liblua
		  lua_pcall: state
		  nargs: nargs
		  nresults: nresults
		  errfunc: 0
]

{ #category : #'as yet unclassified' }
LibLuaState >> lua_tointegerx: idx ifNotInteger: aBlock [

	| pointer value |
	pointer := ExternalAddress newPointer.

	^ [ 
	  value := liblua lua: state to: idx integerx: pointer.

	  (pointer boolean8AtOffset: 0)
		  ifTrue: [ value ]
		  ifFalse: aBlock ] ensure: [ pointer free ]
]

{ #category : #'as yet unclassified' }
LibLuaState >> lua_tonumberx: idx ifNotNumber: aBlock [

	| pointer value |
	pointer := ExternalAddress newPointer.

	^ [ 
	  value := liblua lua: state to: idx numberx: pointer.

	  (pointer boolean8AtOffset: 0)
		  ifTrue: [ value ]
		  ifFalse: aBlock ] ensure: [ pointer free ]
]

{ #category : #'as yet unclassified' }
LibLuaState >> lua_tostring: s [

	^ liblua lua: state tostring: s
]

{ #category : #accessing }
LibLuaState >> state [

	^ state
]

{ #category : #accessing }
LibLuaState >> state: anObject [

	state := anObject
]
