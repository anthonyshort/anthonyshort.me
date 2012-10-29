--- 
title: Using Bower with Sass and Compass
date: 2012/10/28
---

Client-side package management claimed a bit of attention over the past few months with the public release of Twitter's [Bower](http://twitter.github.com/bower/) and [Yeoman](http://yeomain.io). [Component](https://github.com/component/component) is also pushing for smaller front end packages and already has hundreds of organised, tiny modules. 

I decided to write this article so that it will hopefully spark some interest in creating small, reusable components for Sass which are distributed via Bower (or any other package manager). 

The idea of having small, reusable packages is something we need to bring to Sass. We have things like Compass, Bourbon and Stitch but these are all giant libraries that are **trying to do everything**.

[Necolas Gallagher](http://twitter.com/necolas) of Normalize fame has started putting together some tiny CSS packages on Bower, such as [suit-utils](https://github.com/necolas/suit-utils) and [suit-button](https://github.com/necolas/suit-button). If you look at the [button component](https://github.com/necolas/suit-button/blob/master/button.css) it's just a simple `.btn` class with some modifiers.

For the record, I think every front end developer should read Necolas' [article on front end architecture](http://nicolasgallagher.com/about-html-semantics-front-end-architecture/).

## Writing Packages

I'll start with a simple example. I might create a package that just includes the media block pattern:

<pre class="prettyprint lang-css">
.media-block {
  &:first-child {
    float: left;
    & + * {
      overflow: hidden
    }
  }
}
</pre>

I would simply add this as a project on Github, add a `component.json` file and publish to Bower. Now I can install and reuse this chunk of code whenever I want. Obviously this is extremely tiny and probably not worth the effort. You probably want to flesh out the code and make it a bit more flexible. 

A better example would probably be a grid framework written in Sass. They can be written in roughly 50 lines and can be extremely flexible. A perfect candidate. Rather than create a huge library with both of these components I could create individual components.

Some other ideas for Sass components:

* Form layout classes and mixins
* Panel/Box/Alert
* Basic list or navigation modules
* Mixins for adding style to a site, like embossing or patterns
* Dialog/Modals

## Installing Packages with Bower

Now we want a nice way to include these components. Something like this:

<pre class="prettyprint">
  @import 'normalize'
  @import 'stitch/clearfix'
  @import 'stitch/media-block'
  @import 'stitch/text'
  @import 'stitch/breakpoints'
  @import 'suit-utils/display'
  @import 'suit-utils/layout'
  @import 'suit-button/button'
</pre>

Traditionally it was easiest to create a Compass extension. Originally it made sense because Sass and Compass were installed as gems but this might not be the case forever. If you haven't used Bower I recommend going and having a play with it before you continue reading.

I've chosen to use Bower for my front end needs as it's extremely simple. Here's my `component.json`:

<pre class="prettyprint">
{
  "name": "My Sass Project",
  "version": "0.1.1",
  "main": "./styles.css",
  "dependencies": {
    "normalize": "2.0.1",
    "stitch-css": "0.2.0",
    "suit-utils": "0.1.0",
    "suit-button": "0.1.0"
  }
}
</pre>

I generally prefer having a separate `component.json` for my Sass and for my Javascript. 

## Using Packages with Sass

Install these packages with `bower install` and then include them:

<pre class="prettyprint">
  @import 'components/normalize/normalize'
  @import 'components/suit-utils/display'
  @import 'components/suit-utils/layout'
  @import 'components/suit-button/button'
</pre>

It doesn't really matter where you install your components but for the sake of this exercise, the components are being install directly into the Sass folder.

If you want to tidy this up a little bit you can add some extra load paths. In your Compass config you need to add a couple of load paths so that when we type `@import 'suit-button/button'` Sass knows where to to look.

<pre class="prettyprint">
  add_import_path "./components"
  add_import_path "./components/normalize"
  add_import_path "./components/stitch-css"
</pre>

Or if you're using plain ol' Sass you can add it as an option:

<pre class="prettyprint">
  sass --load-path ./components styles.sass:build/styles.css
</pre>

Now in our code we can write things a little bit cleaner:

<pre class="prettyprint">
  @import 'stitch'
  @import 'normalize'
  @import 'suit-utils/display'
  @import 'suit-utils/layout'
  @import 'suit-button/button'
</pre>

We can install our components anywhere and update the import path so we can always use this short, sexy syntax. We have some really nice components that are managed via Bower. They are version locked and they can be easily updated. We get the benefit of a Compass extension but without relying on Ruby. These packages can also work without Compass if you want to remove another dependency from your stack.

Unfortunately though, Sass will only import .scss or .sass files so the projects you add will need to have a Sass version which is slightly tedious. I've opened up [an issue on Github](https://github.com/nex3/sass/issues/556) so hopefully we can get Sass to just import CSS files as Sass files somehow.

Start thinking modular and small and stop creating huge libraries like Bourbon and Stitch. If you see patterns in your code emerging make them components and put them on Bower for everyone to use. Make them lean and make them light like Necolas' SUIT projects. They'll be easier to test and document.
