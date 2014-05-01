require 'active_support/all'

class Post < Thor
  include Thor::Actions

  desc "new", "Creates a new post"
  argument :title
  def new
    date = Time.now.strftime("%Y-%m-%d")
    create_file "_posts/#{(date + '-' + title).parameterize}.md", <<-eos
---
layout: post
title: "#{title}"
cover_image:

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

excerpt: ""
---

{% include email_list.html %}
    eos
  end

end