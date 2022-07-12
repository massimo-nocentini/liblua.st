Extension { #name : #String }

{ #category : #'*LibLua' }
String >> pushOnLua: state [

	^ LibLua uniqueInstance lua: state pushstring: self
]
