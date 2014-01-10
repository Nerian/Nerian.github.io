---
layout: post
title: Activating spell checking for markdown files on Sublime Text 2
cover_image:

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

excerpt: "Spell checking is annoying if you are writing code, but it takes importance when you are writing text like in a markdown file. Sublime text allows you set configuration per file type"
---

Open a Markdown file, go to _Sublime Text > Preferences > Settings More > Syntax Specific – User_

You will see a new file, copy this:

{% highlight javascript %}
{
  "spell-check": true
}
{% endhighlight %}

And that's it!