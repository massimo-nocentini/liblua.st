Extension { #name : #MessageSend }

{ #category : #'*LibLua' }
MessageSend >> pushOnLua: state [

	| lib |
	lib := LibLua uniqueInstance.

	self receiver pushOnLua: state.
	lib lua: state get: -1 field: self selector asString.
	lib lua_remove: state index: -2.
	self arguments do: [ :arg | arg pushOnLua: state ]
]
