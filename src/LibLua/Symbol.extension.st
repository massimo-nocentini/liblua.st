Extension { #name : 'Symbol' }

{ #category : '*LibLua' }
Symbol >> pushOnLua: state liblua: liblua [

	^ liblua lua_getglobal: state name: self asString
]
