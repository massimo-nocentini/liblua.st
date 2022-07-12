Extension { #name : #Float }

{ #category : #'*LibLua' }
Float >> pushOnLua: state [

	^ LibLua uniqueInstance lua: state pushnumber: self
]
