"
Metacello new
repository: 'github://RC69/TinyBlog/src';
baseline:'TinyBlog';
onConflict: [ :ex | ex useLoaded ];
load.
"
Class {
	#name : #ManifestBaselineOfTinyBlog,
	#superclass : #PackageManifest,
	#category : #'BaselineOfTinyBlog-Manifest'
}
