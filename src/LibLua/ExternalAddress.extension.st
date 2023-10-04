Extension { #name : 'ExternalAddress' }

{ #category : '*LibLua' }
ExternalAddress >> pushOnLua: state liblua: liblua [

	^ liblua lua_pushlightuserdata: state externalAddress: self
]
