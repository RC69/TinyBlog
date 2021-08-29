Class {
	#name : #BaselineOfTinyBlog,
	#superclass : #BaselineOf,
	#category : #BaselineOfTinyBlog
}

{ #category : #baselines }
BaselineOfTinyBlog >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec package: 'TinyBlog' with: [ spec requires: #('TinyBlog') ].
			spec
				package: 'TinyBlog-Tests'
				with: [ spec requires: #('TinyBlog') ].
			spec group: 'default' with: #('TinyBlog' 'TinyBlog-Tests') ]
]
