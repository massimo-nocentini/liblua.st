"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLibLua,
	#superclass : #PackageManifest,
	#category : #'LibLua-Manifest'
}

{ #category : #'code-critics' }
ManifestLibLua class >> ruleUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#LibLua)) #'2022-11-24T15:40:54.349641+01:00') )
]
