---
layout: post
title: "Writting an RSpec test for an asynchronous action"
cover_image:

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

tags: []
category: articles

excerpt: ""
---

In the <a href="{% post_url 2014-08-30-how-to-handle-concurrent-requests-in-rails %}">previous article</a> you learnt how to write a Rails action that can handle concurrent users, an asynchronous action. Today you are going to learn how to write an RSpec test for it.

This is the controller we want to write a test for:

{% highlight ruby %}
class ApplicationController < ActionController::Base

  def sample
    EM.defer do
      render json: { response: 'Hello World' }

      request.env['async.callback'].call response
    end

    throw :async
  end

end
{% endhighlight %}

If this were not an asynchronous action, we would simply write a test like this:

{% highlight ruby %}
require 'spec_helper'

describe ApplicationController, :type => :controller do
  it "hello world" do
    get :sample
    expect(JSON.parse(response.body)['response']).to eq('Hello World')
  end
end
{% endhighlight %}

But this won't work because `throw :async` will kill the action right away. `throw :async` will make the interpreter go to <a href="https://github.com/macournoyer/thin/blob/a1d69d683b820d4355aaaa4454f4212d76f712db/lib/thin/connection.rb#L84">this line of code defined in the Thin gem</a>. The problem is that Thin is not loaded at all when running a controller test.

In order to properly test an asynchronous action you need to run the test using a real Thin server. You can use <a href="https://github.com/jnicklas/capybara">Capybara</a> to do that.

Gemfile
{% highlight ruby %}
gem 'thin'
gem 'capybara'
gem 'selenium-webdriver'
{% endhighlight %}

In spec/rails_helper.rb:
{% highlight ruby %}
require 'capybara/rails'

Capybara.default_driver = :selenium

Capybara.server do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, :Port => port)
end
{% endhighlight %}

Write the test:

{% highlight ruby %}
describe ApplicationController, :type => :feature do
  it "my test" do
    visit some_path
    expect(page).to have_content('Hello World')
  end
end
{% endhighlight %}

And that's it. Happy testing.