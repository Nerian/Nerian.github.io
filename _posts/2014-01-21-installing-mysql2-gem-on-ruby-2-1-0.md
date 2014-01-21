---
layout: post
title: "installing mysql2 gem on ruby 2.1.0 "
cover_image:

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

excerpt: "Installing the mysql2 gem may give you this error: Library not loaded: libmysqlclient.18.dylib (LoadError). This is how you can solve it."
---

Installing the mysql2 gem may give you

{% highlight bash %}
Library not loaded: libmysqlclient.18.dylib (LoadError)

Referenced from: /Users/Nerian/.rvm/gems/ruby-2.1.0@haiku-core/extensions/x86_64-darwin-12/2.1.0-static/mysql2-0.3.14/mysql2/mysql2.bundle

Reason: image not found - /Users/Nerian/.rvm/gems/ruby-2.1.0@haiku-core/extensions/x86_64-darwin-12/2.1.0-static/mysql2-0.3.14/mysql2/mysql2.bundle
{% endhighlight %}

This issue can be solved using `install_name_tool`.

{% highlight bash %}
$ install_name_tool -change wherever/you/installed/mysql/libmysqlclient.18.dylib  wherever/you/have/the/mysql/gem/mysql2.bundle
{% endhighlight %}

From now on I am assuming you are using RVM, mysql2-0.3.14 and that mysql is installed in ~/.mysql_sb_bin/5.5.16. If you are using a different configuration then you will need to adjust the path appropriately.

In ruby 2.0.0 and before you could solve this issue by:

{% highlight bash %}
$ install_name_tool -change libmysqlclient.18.dylib ~/.mysql_sb_bin/5.5.16/lib/libmysqlclient.18.dylib $GEM_HOME/gems/mysql2-0.3.14/lib/mysql2/mysql2.bundle
{% endhighlight %}

Now, on ruby 2.1.0 you need to do:

{% highlight bash %}
$ install_name_tool -change libmysqlclient.18.dylib ~/.mysql_sb_bin/5.5.16/lib/libmysqlclient.18.dylib $GEM_HOME/extensions/x86_64-darwin-12/2.1.0-static/mysql2-0.3.14/mysql2/mysql2.bundle
{% endhighlight %}

That's it.


