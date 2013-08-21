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

So I packaged that project into a ruby gem, ready to use with Rails' assets pipeline. And this [bootstrap-datepicker-rails](https://github.com/Nerian/bootstrap-datepicker-rails) was born.

Using it is as simple as

~~~ ruby
gem 'bootstrap-datepicker-rails'
~~~

Add this line to app/assets/stylesheets/application.css

~~~ css
*= require bootstrap-datepicker
~~~

Add this line to app/assets/javascripts/application.js

~~~ javascript
//= require bootstrap-datepicker
~~~

And then

``` html
<input type="text" data-behaviour='datepicker' >

<script type="text/javascript">
  $(document).ready(function(){
    $('[data-behaviour~=datepicker]').datepicker();
  })
</script>
```