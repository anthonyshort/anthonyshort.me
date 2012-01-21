--- 
title: Syncing Models Across Views with Backbone.js
date: 2012/01/22
---

Over the past few months I've been working with Backbone.js a lot. I've really started enjoying writing Javascript over the past year, so I thought I'd share a neat little pattern I ended up using to synchronise models across multiple views and collections on the page without needing to write code to glue everything together every time you add a new component. 

There are dozens of ways to write something like this, but for what I was trying to achieve, this had the perfect balance between modularity and abstraction.

Consider this: You have multiple views on a page that share common models. A todo application might have different modules on the page that all show the current todo items in different formats. 

I liked the idea of just using events. I love their simplicity and elegance. Having both local and global events firing off everywhere can quickly get confusing to debug though so I try to minimise this as much as possible. Communicating between models that would be otherwise unrelated is much easier using events compared to using some sort of manager to control the models.


	Todo = Backbone.Model.extend({
		initialize: function(options){
		
		// Our application event emitter
		this.mediator = options.mediator
	    
		// Flag to prevent recursion
		this._syncChanges = true
 
		// Whenever this model changes, let every other model
		this.bind('change', function(){
			// Use the flag to prevent recursion
			if(this._syncChanges){
				this.mediator.publish('todo:change',this)
			}
		}, this)
 
		this.mediator.subscribe('todo:change',function(model){
			// Check to see if the model should update itself
			// but don't allow this models change event to trigger the sync
			if(model.id === this.id && model !== this){
				this._syncChanges = false
				this.set(model.attributes)
				this._syncChanges = true
			}
		})
	  }
	})
