Extension { #name : 'False' }

{ #category : '*LibLua' }
False >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushbooleanAsInteger: 0
]
