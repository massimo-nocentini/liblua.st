Extension { #name : 'AthensCairoCanvas' }

{ #category : '*LibLua' }
AthensCairoCanvas >> pushOnLua: state liblua: liblua [

	^ liblua on: state push: handle
]
