Extension { #name : #String }

{ #category : #'*LibLua' }
String >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushstring: self
]
