"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLibLuaTests,
	#superclass : #PackageManifest,
	#category : #'LibLua-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestLibLuaTests class >> ruleUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'LibLua-Tests')) #'2022-11-25T11:56:39.597668+01:00') )
]
