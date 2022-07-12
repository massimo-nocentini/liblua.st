Extension { #name : #UndefinedObject }

{ #category : #'*LibLua' }
UndefinedObject >> pushOnLua: state [

	^ LibLua uniqueInstance lua_pushnil: state
]
