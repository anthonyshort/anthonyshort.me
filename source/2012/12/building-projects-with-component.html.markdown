--- 
title: Building projects with Component(1)
date: 2012/10/26
---

[Component(1)](http://github.com/component/component), if you haven't seen it, is a little package manager for the web. It's similar to Bower but it is a little more opinionated. All components are written using CommonJS-style code and they can include templates and CSS. It also comes with a build tool for compiling all of these components together.

One thing that confuses people is how they can implement Component into their project. I've toyed around with a couple of approaches. You can either use Component(1) as a standalone library, you can build your entire project with Component or you can roll your own builder implemetation like I did.

It's on the right track but there are a couple of things that have been annoying me about Component. 

* No coffeescript support
* You need to list out all scripts/files in a component manually
* Templates need to be manually compiled

I've solved all of these by making a grunt plugin - [grunt-component-build](http://github.com/anthonyshort/grunt-component-build). This is a custom implemetation of the Component(1) builder that allows me to use grunt to build components as well as add a couple of extra features.

## Standalone Library

The easiest way to get Component into your project is to use it the way you would use any other library. Basically, we'll be making a component to export the Component require. It seems crazy, but it allows us to encapsulate the Component functionality and use it like a library. Here's how we want to use it:

```js
var tip = component('tip');
var dialog = component('dialog');
```

Create a folder for your components, put the `component.json` file in there. Add an `index.js` file in there as well with code:

```js
module.exports = require;
```

Seems strange. But what this will do is export the Component require function. When we build the components as a standalone library we'll have access to it. Now build with this command:

```
component build --standalone component
```

This will compile all of the installed components together and export it as `window.component`. We created the `index.js` file as that is what is exposed to `window.component`. 

If this is all a bit confusing, remember that the require function created by Component (the one that lets you import components) is wrapped in an immediate function and isn't accessible globally when built with `---standalone`. We're basically just exporting that require function again but under a different name to prevent collisions with other libraries that might use a require function.

## One Big Component

The original idea behind component was that you would build your entire project with components. Every part of the application would be a component. If you need a list of tasks you would make it a component that would include the template for the list, the list item, the class for the model, the view etc. It is how you would normally encapsulate things but you make it a component instead, meaning there were some rules and limitations. 

I'm still not sold on this idea just yet. If I could see an example of a large project built this way it might change my mind.

## Custom Builder Using Grunt

Currently I use Browserify for building out projects. It allows me to use CommonJS style code, I don't need to mess around with AMD modules or Require.js. It's pragmatic, it's easy, it's awesome. Browserify lets you use node modules in your code. This is great but npm wasn't really made for browsers. We have different problems to solve.

If you use Browserify you can use Component as a standalone library. But I'd rather use one tool that does everything for me and since I use grunt to build out all of my Javascript projects, it made sense to make a grunt plugin that would allow me to build components.

So I made [grunt-component-build](http://github.com/anthonyshort/grunt-component-build). This uses the same builder that Component uses when you run `component build` but it allows you to configure it within your grunt file. Additionally, it allows you to easily add plugins to extend the functionality of Component. Here's what a grunt task might look like:

```
component: {
  app: {
    standalone: 'app',
    output: './dist/',
    config: './component.json',
    styles: false,
    plugins: ['templates', 'coffee'], // built-in plugins
    configure: function(builder) {
      // Do things with the builder. Add more plugins etc.
    }
  }
}
```

And here's the `component.json` file:

```
{
  "name": "app",
  "private": true,
  "paths": [ "lib" ],
  "scripts": [
    "index.js",
    "src/**/*.coffee"
  ],
  "templates": [
    "templates/**/*.html",
  ]
}
```

Here are some things you can do with grunt-component-build;

* Use Coffeescript. Write your components in Coffeescript and it will be compiled when you build automatically.
* Use template libraries like Handlebars, Dust, Jade etc.
* Use globs in your `component.json` file.
* Sass support (coming soon!)

Basically, it allows Component to build a project the same way Browserify builds a project except that you have direct access to Components with the `require` method, you only need the one tool, and you don't get access to node modules. 

I want to point out that this should only be used for building out projects. It shouldn't be used for making public components. Unless the `component build` command supports these features then we shouldn't use them for public components. 

## The Long Road Ahead

I think Component(1) still has a long way to go. I find using templates annoying and I never use the built in styles. I have a very well-structure Sass architecture and I want to find a better way to use the styles from Component.

### Templates

Templates in component are annoying. I love that they're simple html. That's all most templates need to be. But larger projects will want to use tools like Handlebars. There is also no way for me to override the templates of an installed component so that I can make use of my own existing styles and markup patterns.

Ideally, if I create a local component called `component-tip` file inside of it should override anything in `components/component-tip` so I can write my own templates. 

It's a tricky situation. We're limited by what we can do with HTML at the moment and it also comes down to the author to create components that are written in such a way that overriding a template or changing a class should be easy. A lot of them aren't written this way.

### Styles

I'm all for components having their own styles. Styles, like templates, need to be raw for public components. This means no Sass. But on a large project I'll definitely be using Sass and I'll also want to leverage classes I already use which means editing templates.

Styles in components are encouraged to only remain structural, meaning that they don't really include colours and backgrounds, but just positioning and layout. This is a good start but there is so much more to it. I want to leverage my own styles so I'll need to be able to use custom templates. I also might want to change class names but this would break Javascript hooks in the component. 

So for me the styles and templates in third-party components are almost never used. This makes a lot of components useless unless they give me an easy way to override the templates and CSS classes used.

I'm also still waiting on an easy way to manage Sass packages/components/mixins/whatever. Bower is working for me at the moment but it's not ideal.

## Summary

Component(1) is still the best package manager we have at the moment for front-end web components. The only way these tools will get better is if we use them. So if you're using grunt and Browserify (or any CommonJS builder), consider using Component(1) now as it will do the same thing and give you access to components.