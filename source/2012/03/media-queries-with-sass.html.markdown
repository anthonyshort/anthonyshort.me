--- 
title: Media Queries with Sass 3.2
date: 2012/03/13
---

<div class="notice">
	<p>I've created <a href="https://gist.github.com/2028061">a gist over on Github</a> that implements lots of media queries using Sass 3.2 <code>@content</code> blocks.</p>
</div>

A little known feature of the upcoming Sass 3.2 release is the <code>@content</code> rule. What this does is allow you to add blocks to your <code>@include</code> statements. Here's an example:

<pre class="prettyprint ()">
@mixin awesome {
	.sauce {
		@content;
	}
}
.bottle {
	@include awesome {
		color:red;
	}
}
</pre>

See how I've added a property block after the <code>@include</code>? This rather pointless example will generate something like this:

<pre class="prettyprint ()">
.bottle {
	.sauce {
		color:red;
	}
}
</pre>

It's placed the block I added after the include where the <code>@content</code> rule was used in the mixin. The real benefit of this inception-style inclusion is that it allows us to do one, very, very, cool thing - **inline media queries**.

I'd previously added a bunch of Sass media queries to my Compass extension, [Stitch](http://stitchcss.com), but I'm looking to expand on what I already have. This is one of the features I want to get into Compass 0.13. It changes the way we use media queries completely. 

I've created [a gist over on Github](https://gist.github.com/2028061) that covers a lot of the basic media queries that we have to deal with every day. Here's a really simple example of what it can do:

<pre class="prettyprint ()">
.module {
	@include mobile-only {
		width:auto;
		font-size:12px;
	}
	@include tablet-landscape-and-below {
		width:600px;
		font-size:14px;
		.sidebar {
			display:none;
		}
	}
	@include desktop-only {
		width:400px;
		.sidebar {
			width:200px;
		}
	}
}
</pre>

**Huzzah!** Forget remembering media queries forever!

I'm trying to develop some really extensive media queries using Sass. But I need some feedback. Only after some solid, real-world testing will they be ready for the prime-time. 

So if you get a chance, have a look at [the gist](https://gist.github.com/2028061) and critique it. Media queries can be tricky and they can be used in lots of different ways.