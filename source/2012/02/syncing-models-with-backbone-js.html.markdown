--- 
title: Syncing Models Across Views with Backbone.js
date: 2012/02/11
---

Over the past few months I've been working with Backbone.js a lot. I ran into a problem recently where I needed to sync models between multiple views and collections on the page. I wanted all the views and collections to instantly update as soon as a model changed in any of them.

I thought of a couple of ways to approach this problem:

* Use the same collection in multiple views
* Use the same model in all the views using a manager or factory
* Have the models listening for changes on other models directly

Passing the same collection through to the different views wasn't possible because the multiple views used different data. This led me to try and create a model manager/factory to handle the creation of the models so that there would only be one instance of each model. That would require a great deal of restructuring and might not even work in the long run.

Over-abstracting code too early is a trap that I've been caught in before so I went with the **simplest** solution to the problem.

**The models listen for a change event to update their attributes and broadcast an event with their own attributes when they change.** 

This would let me sync all the views instantly. Here's a dummy model that uses this idea. Let's assume that `Events` is whatever event emitter you're using across the app.

    Todo = Backbone.Model.extend({
        initialize: function(options){

            this.bind('change', function(){
                Events.publish('todo:change',this);
            }.bind(this), this);

            Events.subscribe('todo:change',function(model){
                if(model.id === this.id && model !== this){
                    this.set(model.attributes);
                }
            }.bind(this));
        }
    });

There is a *very* obvious problem with this though. If a model fired a change event it would update other models that would then fire off a change event causing the first model to update. The events aren't entirely recursive as they won't fire if the attributes don't change. However, when the models change they will cause change events on every other model which would trigger any number of callbacks listening for those events. 

This could be a real problem if further down the track there were lots of models with the same ID on the page. 

You might think I could use `silent:true` but then if the change events never fired the views wouldn't be updated. So I need a solution that would allow the change event to still fire but not trigger the global event on 'child' models.

So I opted to use a flag that would prevent events firing on the secondary models when they were synced.

    Todo = Backbone.Model.extend({
        initialize: function(options){
        
            // Flag to prevent recursion
            this._syncChanges = true;
 
            this.bind('change', function(){
                if(this._syncChanges){
                    Events.publish('todo:change',this);
                }
            }.bind(this), this);

            Events.subscribe('todo:change',function(model){
                if(model.id === this.id && model !== this){
                    this._syncChanges = false;
                    this.set(model.attributes);
                    this._syncChanges = true;
                }
            }.bind(this));
        }
    });

When the other models are synced with the changes they won't fire the global event. Simple. I debated with myself for a long time whether it was appropriate to have this sort of logic in the model. The simplicity was jut too tasty.

With this I am able to sync models with the same ID anywhere on the page without needing to relying on code in each view or collection to stick everything together. This approach might not work as the application becomes more complicated but it works as a simple solution to the problem that we can work with right now. 

Learning to avoid over-abstracting too early is something every developer needs to learn the hard way. Use the simplest solution first, make those tests pass, then refactor as needed.