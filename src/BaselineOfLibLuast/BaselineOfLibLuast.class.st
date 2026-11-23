"
I am the baseline of liblua.st, the bindings to Lua for Pharo: I load the packages `LibLua` and `LibLua-Tests`, which depend on no other project.

```smalltalk
Metacello new
	baseline: 'LibLuast';
	repository: 'github://massimo-nocentini/liblua.st:master/src';
	load
```
"
Class {
	#name : #BaselineOfLibLuast,
	#superclass : #BaselineOf,
	#category : #BaselineOfLibLuast
}

{ #category : #baselines }
BaselineOfLibLuast >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Externals.""Packages"
		spec
			package: 'LibLua';
			package: 'LibLua-Tests' ]
]
