Extension { #name : #False }

{ #category : #'*LibLua' }
False >> pushOnLua: state [

	^ LibLua uniqueInstance lua: state pushboolean: 0
]
