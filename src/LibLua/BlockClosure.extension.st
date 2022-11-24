Extension { #name : #BlockClosure }

{ #category : #'*LibLua' }
BlockClosure >> pushOnLua: state liblua: liblua [

	| cb |
	cb := liblua ffiCallback: self.

	^ liblua lua: state pushcfunction: cb
]
