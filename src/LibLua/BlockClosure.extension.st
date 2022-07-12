Extension { #name : #BlockClosure }

{ #category : #'*LibLua' }
BlockClosure >> pushOnLua: state [

	| cb |
	cb := LibLua uniqueInstance ffiCallback: self.

	^ LibLua uniqueInstance lua: state pushcfunction: cb
]
