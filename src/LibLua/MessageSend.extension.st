Extension { #name : #MessageSend }

{ #category : #'*LibLua' }
MessageSend >> pushOnLua: state liblua: liblua [

	self receiver pushOnLua: state liblua: liblua.
	liblua lua_getfield: state at: -1 name: self selector asString.
	liblua lua_remove: state at: -2.
	self arguments do: [ :arg | arg pushOnLua: state liblua: liblua ]
]
