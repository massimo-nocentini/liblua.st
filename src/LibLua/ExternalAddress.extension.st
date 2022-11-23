Extension { #name : #ExternalAddress }

{ #category : #'*LibLua' }
ExternalAddress >> pushOnLua: state [

	^ LibLua uniqueInstance lua_pushlightuserdata: state pointer: self
]
