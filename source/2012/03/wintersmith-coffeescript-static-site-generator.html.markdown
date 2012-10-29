--- 
title: Wintersmith - The Coffeescript Static Site Generator
date: 2012/03/27
---

Last week I discovered another static site generator, [Wintersmith](http://jnordberg.github.com/wintersmith/), that is built on top of node and Coffeescript. It looks extreming promising and I do love a good static site generator. My site is currently built on [Middleman](http://middlemanapp.com/) which is a ruby-based static site generator which is also fantastic. 

Here's what you get with Wintersmith:

* Articles/content written in markdown. Pretty standard.
* Templating using [Jade](https://github.com/visionmedia/jade)
* Built-in server

It's all fairly standard stuff but I'm considering switching to Wintersmith simply because I can extend it with Coffeescript. I know Coffeescript more than Ruby so hopefully I'll be able to do some cool things with it. It won't compile the Sass for me automatically but this is something I can live without.

You can get Wintersmith from NPM:

<pre class="prettyprint ()">
npm install wintersmith -g
</pre>

Then create a blog, run the server or build it.

<pre class="prettyprint () lang-bsh">
wintersmith new my-sweet-blog
cd my-sweet-blog
wintersmith preview
</pre>

If you haven't considered using a static site generator for your personal blog or small site then I highly recommend it. I'll never go back to a CMS for small sites. Ever.