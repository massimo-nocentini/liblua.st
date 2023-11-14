Extension { #name : 'Float' }

{ #category : '*LibLua' }
Float >> pushOnLua: state liblua: liblua [

	^ liblua lua: state pushnumber: self
]
