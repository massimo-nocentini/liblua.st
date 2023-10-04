Extension { #name : 'BlockClosure' }

{ #category : '*LibLua' }
BlockClosure >> pushOnLua: state liblua: liblua [

	| cb |
	cb := liblua fficallbackOnBlock: self.

	^ liblua lua: state pushcfunction: cb
]
