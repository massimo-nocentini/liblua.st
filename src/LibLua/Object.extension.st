Extension { #name : 'Object' }

{ #category : '*LibLua' }
Object >> pushOnLua: state liblua: liblua [

	liblua
		on: state push: self className
			,
				' has not implemented `#pushOnLua:liblua:` so I cannot push anything on the given Lua stack.';
		lua_error: state
]
