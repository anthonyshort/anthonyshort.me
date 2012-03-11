--- 
title: Setting up Sublime Text 2 for Front-End Development
date: 2012/03/11
---

A few weeks ago I decided to give [Sublime Text 2](http://www.sublimetext.com/2) a try. I have a habit of switching text editors fairly frequently. Seeing as we sit staring at our text editors for the majority of the day I find it refreshing to switch editors every couple of months. I've heard good things about [Sublime Text 2](http://www.sublimetext.com/2). I spent some time setting it up this week just the way I like it. It has a lot of settings and options that can be a bit overwhelming.

Most of my days are filled with front-end development - SCSS and Javascript - so I've tried to find addons for Sublime that would make my job easier.

## Soda Theme

If you're a designer like me, the horrid UI will set you off Sublime instantly. There is a solution though. The first add-on you'll want to get is [Soda theme](https://github.com/buymeasoda/soda-theme) by [Ian Hill](https://github.com/buymeasoda). This improves the UI and makes it much more Apple-like. As a bonus there are a couple of [nice syntax themes](https://github.com/buymeasoda) that Ian has included with the project.

<figure>
<img src="/images/2012/03/sublime-text-2/1.png"/>
</figure>

## Package Manager

If you've used Textmate or Espresso you'll know about bundles (or 'sugars' for Espresso). There was never an easy way to install bundles from the app itself or a central repository for to find the bundles. Sublime has a brilliant [package manager](http://wbond.net/sublime_packages/package_control) that you can install that makes finding and installing bundles a breeze.

Just open up the console in Sublime by press control + ` and paste this in:

<pre style="padding:20px">
import urllib2,os; pf='Package Control.sublime-package'; ipp=sublime.installed_packages_path(); os.makedirs(ipp) if not os.path.exists(ipp) else None; urllib2.install_opener(urllib2.build_opener(urllib2.ProxyHandler())); open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read()); print 'Please restart Sublime Text to finish installation'
</pre>

Now you can install packages by pressing command + shift + p to bring up the command palette. Type 'install' and choose 'Package Control: Install Package'. It will bring up list a available packages you can install. Alternatively, if you don't know what you want you can [browse the packages online](http://wbond.net/sublime_packages/community).

I found a few packages that are definitely worth looking at for front-end development. Remember you can install all of these directly from the package manager inside of Sublime:

* [Sidebar Enhancements](http://www.sublimetext.com/forum/viewtopic.php?f=5&t=3331) - Adds much needed menu options to the sidebar.
* [Alignment](http://wbond.net/sublime_packages/alignment) - For aligning variables. Very useful for anyone anal about their code.
* [Backbone.js Bundle](https://github.com/tomasztunik/Sublime-Text-2-Backbone.js-package) - A few simple snippets for models, view and collections. It could definitely do with a few more snippets though.
* [Can I Use](https://github.com/Azd325/sublime-text-caniuse) - Lets you check support for a browser features using [caniuse.com](http://caniuse.com). Just select a work and press control + alt + f to search for it. Super handy.
* [Colour Picker](https://github.com/weslly/ColorPicker) - Extremely useful for CSS development. Just press command + shift + c to open the colour picker.
* [DocBlockr](https://github.com/spadgos/sublime-jsdocs) - Adds docblock support for many languages. Type <code>/**</code> above a function and press tab. Brilliant.
* [Gist](https://github.com/condemil/Gist) - Create, edit and use gists from your Github account right within Sublime. I've started using for all my snippets. I originally discovered this workflow in [this article from Nettuts](http://net.tutsplus.com/tutorials/tools-and-tips/sexy-code-snippet-management-with-gists/).
* [JSFormat](https://github.com/jdc0589/JsFormat) - Easily format a javascript file using completely customizable settings. Just press control + alt + f.
* [JSLint](https://github.com/uipoet/sublime-jshint) - Inline JSLinting. It highlights potential errors in a file. I honestly don't lint my JS that much nowadays. I've used it so much in th e past that I don't really need it anymore.

There are a few others that add language-specific support, but I'm sure you'll be able to find them. There are a many, many more packages but these are the ones I've found most useful.

## Taking it further

These are just some of the addons I've found to make Sublime more awesome. I'm still learning all of the shortcut keys but I'm really impressed with the application overall. It's the little things that are making it a joy to use. It takes a bit of getting used to and it's definitely not as pretty as Espresso but the language support is much better. Hopefully Espresso gets more language support and I can switch back. Unfortunately what makes a text editor popular are the bundles available for it and bundles can really only become abundant when an application is popular.

It's been nice switching to a new editor. Maybe something new will come around in the next few months (like Chocolat) that can make work just a little bit more interesting again.