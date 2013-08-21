---
layout: post
title: bootstrap-datepicker-rails
description: An introduction on the usage of bootstrap-datepicker-rails
modified: 2013-08-21
category: articles
tags: []
image:
  credit: Gonzalo Rodríguez-Baltanás Díaz
  creditlink: http://nerian.es
comments: true
---

While creating [eucalipto.eu](http://eucalipto.eu) I needed to use a Datepicker. I was using the fantastic Twitter Bootstrap framework so I looked for a datepicker that would look as good.

Andrew Rowling's [bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker) was the perfect choice.

So I packaged that project into a ruby gem, ready to use with Rails' assets pipeline. And thus [bootstrap-datepicker-rails](https://github.com/Nerian/bootstrap-datepicker-rails) was born.

Using it, is as simple as

{% highlight ruby %}
gem 'bootstrap-datepicker-rails'
{% endhighlight %}

Add this line to app/assets/stylesheets/application.css

{% highlight scss %}
*= require bootstrap-datepicker
{% endhighlight %}

Add this line to app/assets/javascripts/application.js

{% highlight javascript %}
//= require bootstrap-datepicker
{% endhighlight %}

And then

{% highlight html %}
<input type="text" data-behaviour='datepicker' >

<script type="text/javascript">
  $(document).ready(function(){
    $('[data-behaviour~=datepicker]').datepicker();
  })
</script>
{% endhighlight %}

And this is how it looks:

<figure>
  <img src="https://dl.dropboxusercontent.com/u/834494/blog/eucalipto-datepicker.png" alt="">
</figure>