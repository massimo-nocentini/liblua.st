Extension { #name : 'Boolean' }

{ #category : '*LibLua' }
Boolean >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushbooleanAsBit: self asBit
]
