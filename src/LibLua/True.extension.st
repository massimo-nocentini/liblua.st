Extension { #name : 'True' }

{ #category : '*LibLua' }
True >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushbooleanAsInteger: 1
]
