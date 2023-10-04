Extension { #name : 'AthensCairoSurface' }

{ #category : '*LibLua' }
AthensCairoSurface >> pushOnLua: state liblua: liblua [

	^ liblua on: state push: handle
]
