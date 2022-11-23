Extension { #name : #Symbol }

{ #category : #'*LibLua' }
Symbol >> pushOnLua: state [

	^ LibLua uniqueInstance lua: state getglobal: self asString
]
