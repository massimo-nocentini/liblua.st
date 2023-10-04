Extension { #name : 'FFIExternalReference' }

{ #category : '*LibLua' }
FFIExternalReference >> pushOnLua: state liblua: liblua [

	^ liblua on: state push: handle
]
