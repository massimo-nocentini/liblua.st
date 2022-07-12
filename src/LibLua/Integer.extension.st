Extension { #name : #Integer }

{ #category : #'*LibLua' }
Integer >> pushOnLua: state [

	^ LibLua uniqueInstance lua: state pushinteger: self
]
