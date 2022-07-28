Extension { #name : #SequenceableCollection }

{ #category : #'*LibLua' }
SequenceableCollection >> pushOnLua: state [

	LibLua uniqueInstance lua_newtable: state.

	self withIndexDo: [ :each :index | 
		each pushOnLua: state.
		LibLua uniqueInstance lua: state set: -2 i: index ].

	^ 1 "number of results"
]
