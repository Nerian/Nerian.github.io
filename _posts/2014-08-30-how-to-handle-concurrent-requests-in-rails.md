---
layout: post
title: "How to handle concurrent requests in rails"
cover_image:

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

tags: []
category: articles

redirect_from:
  - /articles/2014/07/28/how-to-handle-concurrent-requests-in-rails/

excerpt: "A single server can handle multiple requests at the same time. In this article you will learn how to leverage Rails concurrent mode with Thin asyncronous requests. "
---

Let's say we have this action:


{% highlight ruby %}
class ApplicationController < ActionController::Base

  def normal
    sleep 5 # Some code that takes a long time. For example: a web request.
    render plain: 'Hello'
  end

end
{% endhighlight %}

This code is a scalability problem, because each request efectively block other requests from being handled. If your service receives more than one request per 5 seconds, your service will start failing to respond. But it doesn't need to be like that. There is a way to tell Rails that it is okay to handle some other request while some other work is being done and then go back to that original request when all it's ready.

It's called concurrent mode.

In this example we will use Thin plus rails's concurrent mode to handle request concurrently.

The first step is to add the Thin server to the Gemfile. A simple `gem 'thin'` in the Gemfile will do.

The second step is to activate the concurrent mode in the rails environment. For example, in development:

{% highlight ruby %}
# config/environments/development.rb
Rails.application.configure do

  ...some other settings

  config.allow_concurrency = true
end

{% endhighlight %}

Then set up the action that you want to handle asyncronously in this way:

{% highlight ruby %}
class ApplicationController < ActionController::Base
  def async
    EM.defer do
      sleep 5 # Some work that take a long time.
      request.env['async.callback'].call response
    end

    throw :async
  end
end
{% endhighlight %}

Start the server like this: `bundle exec thin --threaded -p 5500 --threadpool-size 50 start`

That means that Thin will be started in threaded mode, and it will use up to 50 threads. The `threaded` option is important as Thin defaults to non threaded mode.

When the request is being handled, the `EM.defer` block will be executed in a separate thread. At the same time the `throw :async` will be executed, which basically tells the Thin server that this request will be handled asyncronously and that it should inmediately start working on a different request. `request.env['async.callback'].call response` will communicate the response to the Thin server and send it back to the client.

Let me remark that, until `request.env['async.callback'].call response` is executed, no response is sent back to the client.

There is one important gotcha with `throw :async`: No rack middleware will be executed for the response. Thereby if you try to set up a cookie it will fail. But here is a way to fix that:

{% highlight ruby %}
class ApplicationController < ActionController::Base
  def async_with_cookies
    EM.defer do
      sleep 5
      cookies[:message] = 'hello'
      cookies.write(headers)
      request.env['async.callback'].call response
    end

    throw :async
  end
end
{% endhighlight %}

`cookies.write(headers)` will take care of setting the headers that needs to be set in order to make the changes in the cookies. It's basically the code that gets executed when the Cookie middleware is executed.

And that's it, so simple.

One way to test that you action can really handle concurrent requests to to query the url with multiple requests at the same time. You can do it with Apache HTTP server benchmarking tool, packaged with Mac OS.

{% highlight bash %}
➜  time ab -c10 -n10 http://127.0.0.1:5500/async_with_cookies
# That will send 10 requests, 10 request at a time (so all go in at the same)

➜  Concurrent  time ab -c10 -n10 http://127.0.0.1:5500/async_with_cookies
This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient).....done


Server Software:        thin
Server Hostname:        127.0.0.1
Server Port:            5500

Document Path:          /async_with_cookies
Document Length:        2844 bytes

Concurrency Level:      10
Time taken for tests:   5.178 seconds
Complete requests:      10
Failed requests:        7
   (Connect: 0, Receive: 0, Length: 7, Exceptions: 0)
Write errors:           0
Non-2xx responses:      5
Total transferred:      34886 bytes
HTML transferred:       32330 bytes
Requests per second:    1.93 [#/sec] (mean)
Time per request:       5178.076 [ms] (mean)
Time per request:       517.808 [ms] (mean, across all concurrent requests)
Transfer rate:          6.58 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   196 2687 2614.2   5158    5178
Waiting:      196 2687 2614.2   5158    5177
Total:        196 2687 2614.2   5159    5178

Percentage of the requests served within a certain time (ms)
  50%   5159
  66%   5159
  75%   5164
  80%   5176
  90%   5178
  95%   5178
  98%   5178
  99%   5178
 100%   5178 (longest request)
ab -c10 -n10 http://127.0.0.1:5500/async_with_cookies  0,01s user 0,02s system 0% cpu 5,207 total
{% endhighlight %}

So you can see that it took 5 seconds total to handle the 10 requests (each one taking 5 seconds) thereby proving that we can handle concurrents requests. This is a very useful model for handling web requests where one portion of the request may take a few seconds. For example at Haiku we use this technique when handling concerning Google signin. The portion of code where we need to wait we simply executed them in a Event Machine defered block.

Note:
If you use Pow for your app, use the ip address as in the example, because Pow will only handle one request at a time.

You can see a full example here: [https://github.com/Nerian/concurrency](https://github.com/Nerian/concurrency)