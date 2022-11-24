Extension { #name : #MessageSend }

{ #category : #'*LibLua' }
MessageSend >> pushOnLua: state liblua: liblua [

	self receiver pushOnLua: state liblua: liblua.
	liblua lua: state get: -1 field: self selector asString.
	liblua lua_remove: state index: -2.
	self arguments do: [ :arg | arg pushOnLua: state liblua: liblua ]
]
