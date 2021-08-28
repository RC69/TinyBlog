"
configurer Seaside pour qu’il ouvre un debugger dans Pharo.

(WAAdmin defaultDispatcher handlerAt: 'TinyBlog')exceptionHandler: WADebugErrorHandler
"
Class {
	#name : #TBPostsListComponent,
	#superclass : #TBScreenComponent,
	#instVars : [
		'currentCategory',
		'showLoginError'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #rendering }
TBPostsListComponent >> basicRenderCategoriesOn: html [ html render: self categoriesComponent
]

{ #category : #rendering }
TBPostsListComponent >> basicRenderPostsOn: html [ self readSelectedPosts do: [ :p |html render: (self postComponentFor: p) ]
]

{ #category : #'components creation' }
TBPostsListComponent >> categoriesComponent [
^ TBCategoriesComponent categories: self blog allCategories postsList: self
]

{ #category : #accessing }
TBPostsListComponent >> currentCategory [
	^ currentCategory
]

{ #category : #accessing }
TBPostsListComponent >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #actions }
TBPostsListComponent >> goToAdministrationView [
self call: TBAdminComponent new
]

{ #category : #accessing }
TBPostsListComponent >> hasLoginError [
	^ showLoginError ifNil: [ false ]
]

{ #category : #accessing }
TBPostsListComponent >> loginErrorMessage [
^ 'Incorrect login and/or password'
]

{ #category : #actions }
TBPostsListComponent >> loginErrorOccurred [ showLoginError := true
]

{ #category : #'components creation' }
TBPostsListComponent >> postComponentFor: aPost^ [ TBPostComponent new post: aPost
]

{ #category : #accessing }
TBPostsListComponent >> readSelectedPosts [
	"^ self currentCategory
		ifNil: [ self blog allVisibleBlogPosts ]
		ifNotNil: [ self blog allVisibleBlogPostsFromCategory: self currentCategory ]"
		
		currentCategory
		ifNil: [ currentCategory := 'All' ].

	^ self currentCategory = 'All'
		ifTrue: [ self blog allVisibleBlogPosts ]
		ifFalse: [ self blog allVisibleBlogPostsFromCategory: self currentCategory ]
]

{ #category : #rendering }
TBPostsListComponent >> renderCategoryColumnOn: html [ html tbsColumn extraSmallSize: 12;smallSize: 2;mediumSize: 4;with: [ self basicRenderCategoriesOn: html ]
]

{ #category : #rendering }
TBPostsListComponent >> renderContentOn: html [
super renderContentOn: html.
	html tbsContainer: [
		html tbsRow
			showGrid;
			with: [ self renderCategoryColumnOn: html.
                  self renderPostColumnOn: html ] ]
]

{ #category : #rendering }
TBPostsListComponent >> renderContentOn: htmlsuper renderContentOn: html [
	html
		tbsContainer: [ html tbsRow
				showGrid;
				with: [ html tbsColumn
						extraSmallSize: 12;
						smallSize: 2; mediumSize: 4;
						with: [ html
								render:
									(TBCategoriesComponent
										categories: self blog allCategories
										postsList: self) ].
					html tbsColumn
						extraSmallSize: 12;
						smallSize: 10;
						mediumSize: 8;
						with: [ self readSelectedPosts
								do: [ :p | html render: (TBPostComponent new post: p) ] ] ] ]
]

{ #category : #rendering }
TBPostsListComponent >> renderLoginErrorMessageIfAnyOn: html [
	self hasLoginError
		ifFalse: [ ^ self ].
	showLoginError := false.
	html tbsAlert
		beDanger;
		with: self loginErrorMessage
]

{ #category : #rendering }
TBPostsListComponent >> renderPostColumnOn: html [
	html tbsColumn
		extraSmallSize: 12;
		smallSize: 10;
		mediumSize: 8;
		with: [ self renderLoginErrorMessageIfAnyOn: html.
			self basicRenderPostsOn: html ] 
]

{ #category : #callbacks }
TBPostsListComponent >> tryConnectionWithLogin: login andPassword: password [
	"| l1 p1 p3 p4 |
	l1 := self blog administrator login.
	p1 := self blog administrator password.
	p3 := password.
	p4 := (MD5 hashMessage: p3) asOrderedCollection.
	Transcript
		show: 'l1=' , l1;
		cr.
	Transcript
		show: 'p1=' , p1 asString;
		cr.
	Transcript
		show: 'p3=' , p3;
		cr.
	Transcript
		show: 'p4=' , p4 asString;
		cr."
	(login = self blog administrator login
		and: [ (MD5 hashMessage: password) asOrderedCollection
				= self blog administrator password ])
		ifTrue: [ self session currentAdmin: self blog administrator.
			self goToAdministrationView ]
		ifFalse: [ self loginErrorOccurred ]
]
