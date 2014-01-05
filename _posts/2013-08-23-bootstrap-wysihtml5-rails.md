---
layout: post
title: bootstrap-wysihtml5-rails
subtitle: "Bootstrap Wysihtml5 Rails is the easiest way to add a beautiful rich text editor to your rails application"
cover_image:

modified: 2013-08-23
category: articles
tags: [bootstrap, rails, wysihtml5]

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

comments: true
excerpt: "bootstrap-wysihtml5-rails is the easiest way to add a beautiful rich text editor to your rails application."
---

[Bootstrap Wysihtml5 Rails](https://github.com/Nerian/bootstrap-wysihtml5-rails) is the easiest way to add a beautiful rich text editor to your rails application.

This is how it looks like:

<img src="https://dl.dropboxusercontent.com/u/834494/blog/wysist.png" alt="bootstrap-wysihtml5">

Using it is very easy. Just put this in your Gemfile and bundle install.

{% highlight ruby %}
gem 'jquery-rails'
gem 'bootstrap-sass'

gem 'bootstrap-wysihtml5-rails'
{% endhighlight %}

app/assets/stylesheets/application.css
{% highlight css %}
*= require bootstrap-wysihtml5
{% endhighlight %}

app/assets/javascripts/application.js

{% highlight javascript %}
//= require bootstrap-wysihtml5

Optionally, you may include all locales like this.

//= require bootstrap-wysihtml5/locales

Or just add the ones that you want

//= require bootstrap-wysihtml5/locales/de-DE
//= require bootstrap-wysihtml5/locales/es-ES

{% endhighlight %}

Finally, let's use it:

{% highlight html %}
<textarea id="some-textarea" class='wysihtml5' placeholder="Enter text ..."></textarea>

// You want to put this initialization code in a file
// in you app/assets/javascripts folder.
<script type="text/javascript">
  $(document).ready(function(){

    $('.wysihtml5').each(function(i, elem) {
      $(elem).wysihtml5();
    });

  })
</script>
{% endhighlight %}

[bootstrap-wysihtml5](https://github.com/jhollingworth/bootstrap-wysihtml5#advanced) has a lot of options you can make use of. Check their readme.

[https://github.com/Nerian/bootstrap-wysihtml5-rails](https://github.com/Nerian/bootstrap-wysihtml5-rails)
