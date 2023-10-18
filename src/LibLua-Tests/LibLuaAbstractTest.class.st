Class {
	#name : 'LibLuaAbstractTest',
	#superclass : 'TestCase',
	#category : 'LibLua-Tests',
	#package : 'LibLua-Tests'
}

{ #category : 'testing' }
LibLuaAbstractTest class >> isAbstract [

	^ true
]

{ #category : 'ffi lib' }
LibLuaAbstractTest >> liblua [

	^ LibLua uniqueInstance implementationPrimitive
]
