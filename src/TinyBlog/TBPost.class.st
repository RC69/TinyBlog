"
2.5 Création de posts
TBPost 
	title: 'Welcome in TinyBlog'
	text: 'TinyBlog is a small blog engine made with Pharo.'
	category: 'TinyBlog'
	
TBBlog reset.
TBBlog createDemoPosts.


"
Class {
	#name : #TBPost,
	#superclass : #Object,
	#instVars : [
		'category',
		'date',
		'text',
		'title',
		'visible'
	],
	#category : #'TinyBlog-Model'
}

{ #category : #'instance creation' }
TBPost class >> title: aTitle text: aText [
	^ self new
		title: aTitle;
		text: aText;
		yourself
]

{ #category : #'instance creation' }
TBPost class >> title: aTitle text: aText category: aCategory^ [ (self title: aTitle text: aText)category: aCategory;yourself
]

{ #category : #constants }
TBPost class >> unclassifiedTag [
	^ 'Unclassified'
]

{ #category : #accessing }
TBPost >> beVisible [
self visible: true
]

{ #category : #accessing }
TBPost >> category [
	^ category
]

{ #category : #accessing }
TBPost >> category: aString [
	category := aString
]

{ #category : #accessing }
TBPost >> date [
	^ date

	"| stream |
	stream := date greaseString readStream.
	^ Date
		readFrom: (stream upTo: $T) readStream
		pattern: 'yyyy-mm-dd'."
	
]

{ #category : #accessing }
TBPost >> date: aDate [
	date := aDate
]

{ #category : #'magritte descriptions' }
TBPost >> descriptionCategory [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Category';
		priority: 300;
		accessor: #category;
		comment: 'Unclassified if empty';componentClass: TBSMagritteTextInputComponent;
		yourself
]

{ #category : #'magritte descriptions' }
TBPost >> descriptionContainer [
	<magritteContainer>
	^ super
		descriptionContainer
		componentRenderer: TBSMagritteFormRenderer;
		yourself
]

{ #category : #'magritte descriptions' }
TBPost >> descriptionDate [
	<magritteDescription>
	^ MADateDescription new
		label: 'Date';
		priority: 400;
		accessor: #date;
		beRequired;
		yourself
]

{ #category : #'magritte descriptions' }
TBPost >> descriptionText [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #text;
		label: 'Text';
		priority: 200;
		beRequired;
		requiredErrorMessage: 'A blog post must contain a text.';comment: 'Please enter a text';componentClass: TBSMagritteTextAreaComponent;
		yourself
]

{ #category : #'magritte descriptions' }
TBPost >> descriptionTitle [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Title';
		priority: 100;
		accessor: #title;
		requiredErrorMessage: 'A blog post must have a title.';comment: 'Please enter a title';componentClass: TBSMagritteTextInputComponent;
		beRequired;
		yourself
]

{ #category : #'magritte descriptions' }
TBPost >> descriptionVisible [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Visible';
		priority: 500;
		accessor: #visible;
		componentClass: TBSMagritteCheckboxComponent;
		beRequired;
		yourself
]

{ #category : #initialization }
TBPost >> initialize [
	super initialize.
	self category: self class unclassifiedTag.
	self date: Date today.
	self notVisible
]

{ #category : #testing }
TBPost >> isUnclassified [
	^ self category = self class unclassifiedTag
]

{ #category : #testing }
TBPost >> isVisible [
	^ self visible
]

{ #category : #accessing }
TBPost >> notVisible [
	self visible: false
]

{ #category : #accessing }
TBPost >> text [
	^ text
]

{ #category : #accessing }
TBPost >> text: aString [
	text := aString
]

{ #category : #accessing }
TBPost >> title [
	^ title
]

{ #category : #accessing }
TBPost >> title: aString [
	title := aString
]

{ #category : #accessing }
TBPost >> visible [
	^ visible
]

{ #category : #accessing }
TBPost >> visible: aBoolean [
	visible := aBoolean
]
