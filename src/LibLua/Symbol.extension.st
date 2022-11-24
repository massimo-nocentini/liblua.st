Extension { #name : #Symbol }

{ #category : #'*LibLua' }
Symbol >> pushOnLua: state liblua: liblua [

	^ liblua lua: state getglobal: self asString
]
