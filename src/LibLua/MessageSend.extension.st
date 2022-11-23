Extension { #name : #MessageSend }

{ #category : #'*LibLua' }
MessageSend >> pushOnLua: state [

	| lib idx |
	lib := LibLua uniqueInstance.

	self receiver pushOnLua: state.
"	lib lua: state getglobal: self receiver asString."
	idx := lib lua_absindex: state idx: -1.
	lib lua: state get: -1 field: self selector asString.
	"lib lua: state remove: idx."
	self arguments do: [ :arg | arg pushOnLua: state ]
]
