--- 
title: Exploring Javascript Module Loaders
date: 2012/09/06
---

At the start of the year I began working on a large, javascript-heavy web application which eventually led me to the world of javascript module loading. The first attempt I made was using Require.js. It's a great module loader and did everything I needed to do. The AMD format for modules was tedious but I hadn't explored it enough to fully grasp it's advantages and disadvantages. 

So far it's working great. In development I leave Require.js to do it's thing and load everything in. The setup for Require.js caused a bit of friction but once I had my head around the concepts it was easy.

Over the last couple of months I've started thinking that it's not the right way to go. At least not for what I'm working on. So I thought I'd share some experiences.

## Why not just build?

The dependency resolution and module loading are the greatest parts of AMD. In production you combine all your files together. So why do you need to rely on something like Require.js? You could easily just grab all the files from directories, join them and throw them on the page and use a system that understands the AMD format.

Here's a module with the full AMD jazz (sorry about the Coffeescript, if that's not your thing):

```coffee
define [
  "utils",
  "session",
  "app/views/form", 
  "app/views/ui/calendar",
  "app/models/project"
], (utils, session, Form, Calendar, Project) ->
  
  class TaskForm extends Form
    template: "task/form"
```

It's not too bad. It's a little verbose but Coffeescript makes light work of it, however, we can just ditch the define wrapper all together and rely on the require and exports objects that are passed in. This way we get really simple CommonJS modules:

```coffee
utils = require "utils"
session = require "session"
Form = require "app/views/form"
Calendar = "app/views/ui/calendar"
Project = "app/models/project"
  
class TaskForm extends Form
  template: "task/form"
```

In the build process we will just wrap the file in a define function:

```coffee
define(function(module, exports, require){
  var utils = require "utils";
  var session = require "session";
  var Form = require "app/views/form";
  var Calendar = "app/views/ui/calendar";
  var Project = "app/models/project";
  ...
});
```

None of this is new. I'm currently looking at using Brunch to handle this for me. It compiles the Coffeescript and wrap the file in the define function. A simple define method is prepended to the script automatically so you don't need Require.js or any other AMD library. You get the benefit of using modules and dependency resolution but without the overhead of something as complex as Require.js.

I'm trying to find downsides to this approach for application development. I don't think I would develop a library this way. There are two downside I see to this approach:

* Require.js allows you to dynamically load modules on the fly. Which is something you can't really get with this approach. I would love to be proved wrong though.
* You can't load in packages
* You can't configure paths or set custom names
* You don't get the shim functionality from Require.js that allows you to load non-AMD modules.

## Configuration

Require.js is extremely flexible. I can't help but think it's too flexible for most cases. I've worked with tools that require a lot configuration and it's painful and fragile. Trying to generalise a code-base for any situation can lead to bloat. I want the simplest approach for the problem. 

Ideally I'd like to be able to have a lot of this figured out for me. I don't want to reinvent the wheel every time for every project. If I know I put my files in a certain place then it will work, great, no I can get coding instead of trying to configure my code structure. Brunch was the first framework that I found that did this.

## Circular Dependencies

AMD has issues with circular dependencies that means you need to resort to an alternative syntax to resolve. Circular dependencies aren't so bad. It means two or more modules are coupled but if they are modules with your own application I see no issue with this. I shouldn't have to treat all parts of an application as completely independent. 

I ran into this issue when I began trying to have related models in Backbone. Two models required each other. One had the 'has many' and the other had a 'belongs to' relationship. Arguably this isn't the best approach for a number of reasons and model relationships are something I try to avoid if possible but in this case they allowed me to create an optimistic UI that didn't rely on the response from the server to know details about the new sub-models.

But that's a whole other can of worms.

The simplest way to resolve cicular dependencies is to actually fallback to the commonjs or 'sugar' syntax for cicular dependencies. Consider a simple todo application:

```
define (module, exports, require) ->
  Task = require 'task'

  class Project extends Backbone.Model
    @hasMany Task
```

```
define (module, exports, require) ->
  Project = require 'project'

  class Task extends Backbone.Model
    @belongsTo Project
```

To me this seems perfectly reasonable in terms of design. The syntax, however, was inconsistent with the rest of the application.

## Third-party scripts

The first trap I fell into with Require.js was trying to load *everything* with it. Keeping globals out of the way is nice in theory. I've since learnt to be more pragmatic about the whole thing. Globals provided via third-party scripts aren't terrible. At least not in this size of an application. Hell, in any application size I don't think a couple of globals like `$` or `Backbone` are going to kill anyone.

Trying to load all dependencies in via Require.js was a giant rabbit hole of dispair. It was over-optimizing which can be a bad trap to fall into. One thing I've discovered that is that when you're learning something new you might have to over-optimized to gain a grasp of when *not* to optimize.

With the release of Require.js 2.0 I was able to load in non-AMD files and effectively have only the globals that Require.js adds on the page. "Victory!", I thought. But for an application of this size is that really a goal worth reaching for? Over the past few months I've developed an attitude of developer happiness and pragmatism over idealism. Before you can real this stage I think you need to have fallen into the pitfalls of idealism.

Anyway, my point is, global objects provided by third-party scripts aren't all that bad. At least not at the start. Maybe not ever. If you don't think global naming conflicts will ever be an issue then stop thinking about it!

## Options



