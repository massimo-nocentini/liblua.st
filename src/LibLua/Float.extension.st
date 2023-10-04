Extension { #name : 'Float' }

{ #category : '*LibLua' }
Float >> pushOnLua: state liblua: liblua [

	^ liblua lua_pushnumber: state value: self
]
