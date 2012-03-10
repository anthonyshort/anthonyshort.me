--- 
title: SCSS Coding Style
date: 2012/03/10
---

I've been using Sass now for the past few years and, dare I say it, before it was cool. I've used it on nearly every site I've built since then so I've had a fair bit of time to develop some habits. I thought I'd share some of my personal coding style conventions. We've been using this with the team at Newism for a while now and it works fairly well.

So here's a block of SCSS using the formatting guidelines I've developed:

<pre class="prettyprint linenums">
.class {
	@extend .other-class;
	@extend .another-class;

	@include border-radius;
	@include box-sizing;
	@include standard-block;

	color:black;
	background:red;
	padding:10px;
	margin:0;
	border:0;

	&:hover {
		text-decoration:underline;
	}

	& > li {
		margin:10px;
	}

	& + ul {
		margin-left:10px;
	}

	a {
		font-weight:bold;
	}

	a:hover {
		text-decoration:underline;
	}

	a span {
		display:block;
		time {
			font-style:italic;
		}
	}
}
</pre>

Within a selector block I first define the @extends. It's almost like when defining and extending a class in PHP or Ruby. Having these at the top lets know immediately know what type of object you're dealing with and how it related to the rest of the objects in the stylesheet.

<pre class="prettyprint linenums">
.class {
	@extend .other-class;
	@extend .another-class;

	@include border-radius;
	@include box-sizing;
	@include standard-block;
</pre>

Second are the mixins. The general rule of thumb is to place all @-rules at the top of the block. This is an extremely strict rule. Try moving the @-rules around a block and you'll see that you'll constantly be wondering where styles are coming from. It's very important to get your whole team on board with this.

<pre class="prettyprint linenums">
.class {
	...

	color:black;
	background:red;
	padding:10px;
	margin:0;
	border:0;
</pre>

Third are the properties of the selector. I don't have any particular way of organising these. Some people alphabetize them and others group them. I feel these take too much time to maintain when weighed against the benefits. I should also mention that I generally stick to the spacing used in the example. Everything from the new lines after a section in the block to the spacing between property names and values.

<pre class="prettyprint linenums">
.class {
	...

	&:hover {
		text-decoration:underline;
	}
</pre>

Next I use the pseudo-selectors for the element. In this section I'm placing the styles related to the current, top-level element at the top of the block. As you go further down the block you are going to styles more loosely related to the parent. After this are combinator selectors using the parent selector (the ampersand). Again, following the rule of moving further away from the parent on the way down the block.

<pre class="prettyprint linenums">
.class {
	...

	& > li {
		margin:10px;
	}

	& + ul {
		margin-left:10px;
	}
</pre>

Next are the child element selectors. These are targeting specific elements within the parent selector. Things like anchors and other inline-elements. Then following the same pattern I'll use the pseudo selectors.

<pre class="prettyprint linenums">
.class {
	...

	a {
		font-weight:bold;
	}

	a:hover {
		text-decoration:underline;
	}

	a span {
		display:block;
		time {
			font-style:italic;
		}
	}
</pre>

Last are the complex child selectors.

Within each child selector I follow the same rules. This way everything is consistent throughout the entire stylesheet. Simple conventions like these enable you to scan the file and know where to look. Most importantly it makes working in a team much easier. It's tough getting people on board with a single style, especially with CSS, but if you get everyone involved in the creation of your guidelines you'll find everyone will stick to them.

Hopefully this is a tip some people out there just getting into SCSS will find useful. I have plenty of other conventions like this that I use, including file structure, selector naming, comments, granularity of selectors and more. But I'll save these for some other time. Feel free to hit me up on twitter at [@anthonyshort](http://twitter.com/anthonyshort) if you have any questions or suggestions. I'd love to hear about the conventions other people are using.