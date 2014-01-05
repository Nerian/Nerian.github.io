---
layout: post
title: DaVinci LMS
description: "DaVinci LMS is a minimal Learning Management System"
modified: 2013-08-19
category: articles
tags: [davinci]
image:
  credit: Gonzalo Rodríguez-Baltanás Díaz
  creditlink: http://nerian.es
comments: true
---

When I was in university Pablo de Olavide we used WebCT for the online presence of teachers and students. It was an extremely useful web system. Among the many thing WebCT could do was to manage documents. So teachers will upload notes for the Java class at the start of the course and students will be able to download it, study it and raise questions before the actual class starts. It was a very useful document store. Another very useful feature that we used intensively was the Task system. So a teacher will say 'Solve problems 13-18 and send me the code'. We will solve them and then send back the code, all using the web interface. It was very handy.

There are many other features, but they were all irrelevant since we didn't use them. Nonetheless it wasn't all perfect. It was far from perfect. The idea, the utility of the application was very good, yet the implementation could be much better. It was slow. The UI was ugly. Some times it will just explode and we will be without WebCT a few days until the IT figure it out what went wrong. Also, it was incredible costly for the university to use it, not just because of the important investment in IT infrastructure to serve 20000 users, but the actual cost of licensing the software. To get you an idea, they can't afford to upgrade to new versions of WebCT. And since the world is in recession and particularly in Spain the government is cutting education budget by 20% (for real) it doesn't seem likely that they will be able to update in years.

So that was the situation. When I was at my final year I took a web development course. I learnt a lot of technologies but the one that caught my eye was Ruby on Rails. It was an amazing piece of technology that allowed small teams to deliver working software in a matter of days instead of weeks or months. Real speed. I decided that I wanted to give it a go to creating a Learning Management System(LMS). I deliberately wanted it to be dead simple to use and to install. I didn't want universities to need a whole staff of IT just to support the platform. It must be open source, so that they could modify the source code to meet they particular needs. It needed to be fast so that people could spend their time actually learning and not just using the learning platform. It should be able to store documents and manage tasks.

* Speed
* Open source
* Easy to use
* Easy to deploy
* Document store
* Task Management

My first attempt was a shit. I didn't really knew how to use Rails and I was a beginner in CSS, HTML, knew nothing about JS. I made every possible mistake. I failed to create useful software, but I learned more and more of Rails. I started again. And again. And again. Each time a new project. Each time a new approach, different tools, different UI, different database, different testing approach, etc. It has become sort of my 'Hello World' application whenever I want to test a new cutting edge tech.

This time, the new tech I wanted to give it a try was Apotomo, a component oriented framework for Rails. I also happen to be reading Designed For Use, a book on Usability, how to improve user interfaces so that they are intuitive, natural, discoverable, easy to learn and master. So as a was reading the book I was designing the UI of the new DaVinci LMS prototype. I think this time I have actually achieve to produce a fully working application that meets the IT needs of a school. And so I wanted to make it public, so that people can try it and give me feedback on what they love and what they hate. Also, I could use more fellow developers on this project so you are welcome to contribute.

Check it out: [https://github.com/Nerian/DaVinci-LMS](https://github.com/Nerian/DaVinci-LMS)

And there is an online demo: [http://davinci-lms-testing.herokuapp.com/en/login](http://davinci-lms-testing.herokuapp.com/en/login)