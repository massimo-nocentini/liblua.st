Class {
	#name : #BaselineOfLibLuast,
	#superclass : #BaselineOf,
	#category : #BaselineOfLibLuast
}

{ #category : #baselines }
BaselineOfLibLuast >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Externals."
		spec
			baseline: 'onlua'
			with: [ spec repository: 'github://massimo-nocentini/on-lua' ].

		"Packages"
		spec
			package: 'LibLua';
			package: 'LibLua-Tests' ]
]
