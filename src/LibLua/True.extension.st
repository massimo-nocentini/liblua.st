Extension { #name : #True }

{ #category : #'*LibLua' }
True >> pushOnLua: state [

	^ LibLua uniqueInstance lua: state pushboolean: 1
]
