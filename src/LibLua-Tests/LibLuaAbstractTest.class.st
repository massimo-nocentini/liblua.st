"
I am the abstract superclass of the tests of `LibLua`. My subclasses send `liblua` to get the implementation they test, the one via the VM plugin (`LibLuaPrimitiveImplementation`).
"
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
