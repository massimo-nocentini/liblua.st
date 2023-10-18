Extension { #name : 'Integer' }

{ #category : '*LibLua' }
Integer >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushinteger: self
]
