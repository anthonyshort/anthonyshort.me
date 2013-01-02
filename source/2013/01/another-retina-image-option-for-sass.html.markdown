--- 
title: Another Retina Image Option for Sass
date: 2013/01/02
---

Yeah I know. There are already a few solutions out there for using retina images using sass, like [this](http://37signals.com/svn/posts/3271-easy-retina-ready-images-using-scss), and [this](https://github.com/joelambert/Retina-Compass-Helpers). This way does bloat your file a fair bit so here's how I'm doing it at the moment.

The main problem with a lot of techniques is that both images are downloaded. We can do better than that.

## With Javascript

This mixin doesn't rely on Compass so you can use it with plain Sass. It could be a little more flexible with Compass but I'm keeping it simple. It will also be easier when we get [more string functions](https://github.com/nex3/sass/pull/401) in Sass.

<pre class="prettyprint lang-scss">
@mixin retina-background-image($image, $width: 50%, $height: auto, $type: 'png') {
  .no-retina & {
    background-image: url("#{$image}.#{$type}");
  }
  .retina & {
    background-image: url("#{$image}@2x.#{$type}");
    background-size: $width $height;
  }
}
</pre>

And then do something similar to this:

<pre class="prettyprint lang-js">
var el = document.getElementsByTagName('html')[0]; 
if( window.matchMedia and window.matchMedia('(min--moz-device-pixel-ratio: 1.3),(-o-min-device-pixel-ratio: 2.6/2),(-webkit-min-device-pixel-ratio: 1.3),(min-device-pixel-ratio: 1.3), (min-resolution: 1.3dppx)').matches ) {
  el.classList.add('retina')
  el.classList.remove('no-retina')
}
</pre>

And add a class of `.no-retina` to the html element on your page so that it works without JS.

Because the retina screens won't have CSS selectors that match it, they won't download the image, ever. We also don't get media query bloat everywhere. If someone happens to have JS turned off, they don't get retina images. I prefer this method, it's simple.

## Without Javascript

If you don't really care about filesize because all of those media queries will be compressed to nothing anyway you could do something similar with a couple of other mixins and no need for JS.

We create a mixin for non-retina displays (and devices with no media queries) and give those the standard image. This will stop the retina devices from downloading them.

Here's what it might look like:

<pre class="prettyprint lang-scss">
@mixin non-retina {
  @media (min--moz-device-pixel-ratio: 1),
  (-o-min-device-pixel-ratio: 1),
  (-webkit-min-device-pixel-ratio: 1),
  (min-device-pixel-ratio: 1),
  (min-resolution: 1dppx) {
    @content;
  }
  .no-mediaqueries & {
    @content;
  }
}

@mixin retina {
  @media (min--moz-device-pixel-ratio: 1.3),
  (-o-min-device-pixel-ratio: 2.6/2),
  (-webkit-min-device-pixel-ratio: 1.3),
  (min-device-pixel-ratio: 1.3),
  (min-resolution: 1.3dppx) {
    @content;
  }
}

@mixin retina-background-image($image, $width: 50%, $height: auto, $type: 'png') {
  @include non-retina {
    background-image: url("#{$image}.#{$type}");
  }
  @include retina {
    background-image: url("#{$image}@2x.#{$type}");
    background-size: $width $height;
  }
}
</pre>

This relies on you being able to target IE8 or below which don't have support for media queries. I generally use Modernizr so this isn't a problem. 

You'll end up with something like this:

<pre class="prettyprint lang-css">
@media (min--moz-device-pixel-ratio: 1), (-o-min-device-pixel-ratio: 1), (-webkit-min-device-pixel-ratio: 1), (min-device-pixel-ratio: 1), (min-resolution: 1dppx) {
  .foo {
    background-image: url("foo.png");
  }
}
.no-mediaqueries .foo {
  background-image: url("foo.png");
}
@media (min--moz-device-pixel-ratio: 1.3), (-o-min-device-pixel-ratio: 2.6 / 2), (-webkit-min-device-pixel-ratio: 1.3), (min-device-pixel-ratio: 1.3), (min-resolution: 1.3dppx) {
  .foo {
    background-image: url("foo@2x.png");
    background-size: 50% auto;
  }
}
</pre>

Whether you can stand having that for every single use of the mixin is up to you. Gzipping will kill most of it but just keep that in mind.