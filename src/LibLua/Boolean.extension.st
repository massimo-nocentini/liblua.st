Extension { #name : 'Boolean' }

{ #category : '*LibLua' }
Boolean >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushboolean: self asBit
]
