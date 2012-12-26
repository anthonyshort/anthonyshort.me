--- 
title: Building projects with Component(1)
date: 2012/12/26
---

[Component(1)](http://github.com/component/component), if you haven't seen it, is a little package manager for the web. It's similar to Bower but it is a little more opinionated. All components are written using CommonJS-style code and they can include templates and CSS. It also comes with a build tool for compiling all of these components together.

One thing that confuses people is how they can implement Component into their project. I've toyed around with a couple of approaches. You can either use Component(1) as a standalone library, you can build your entire project with Component or you can roll your own builder implemetation like I did.

It's on the right track but there are a couple of things that have been annoying me about Component. 

* No coffeescript support
* You need to list out all scripts/files in a component manually
* Templates need to be manually compiled

I've solved all of these by making a grunt plugin - [grunt-component-build](http://github.com/anthonyshort/grunt-component-build). This is a custom implemetation of the Component(1) builder that allows me to use grunt to build components as well as add a couple of extra features.

## Building Components with Grunt

Currently I use Browserify for building out projects. It allows me to use CommonJS style code, I don't need to mess around with AMD modules or Require.js. It's pragmatic, it's easy, it's awesome. Browserify lets you use node modules in your code. This is great but npm wasn't really made for browsers. We have different problems to solve.

If you use Browserify you can use Component as a standalone library. But I'd rather use one tool that does everything for me and since I use grunt to build out all of my Javascript projects, it made sense to make a grunt plugin that would allow me to build components.

So I made [grunt-component-build](http://github.com/anthonyshort/grunt-component-build). This uses the same builder that Component uses when you run `component build` but it allows you to configure it within your grunt file. Additionally, it allows you to easily add plugins to extend the functionality of Component. Here's what a grunt task might look like:

<pre class="prettyprint lang-js">
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
</pre>

And here's the `component.json` file:

<pre class="prettyprint lang-js">
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
</pre>

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