---
layout: post
title: "So you want to learn MongoDB?"
cover_image:

category: articles

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

excerpt: "Aren't you tired of thinking about your business models as a set of tables? What if you could represent them as a crystal clear mirror of your mental model?"
---

__MongoDB is a NoSQL database. What the hell does that even mean?__

We all know the old good MySQL. MySQL is a relational database. That means your queries follow relational logic: "this collection of Users and this collection of Poll Answers relate to each other by this user_id attribute. Given that relation, find all the Poll Answers for this particular user". That's SQL.

__So does this mean that MongoDB, being a NoSQL database, doesn't have relational queries?__

Actually, you can do those queries in MongoDB too. In fact they are pretty common.

__But you said...__

Yeah, NoSQL is an awful name to describe a set of characteristics that really has nothing to do with SQL, or lack of thereof. What NoSQL stands for is about giving you the choice on how you structure you data: and thereby what particular queries are given more speed than others.

In MySQL you store your data in tables. Each table is a collection of elements that all share the same fundamental structure. In the case of a User collection we would probably find 'First Name', 'Last Name' and 'Age'. All of those elements do have all those attributes, even if they are set to a null value. Relational databases enforce this quality; if you try to store a User with an arbitrary attribute such has 'Favorite Color' the database won't let you. In MySQL, elements within a particular table have an homogeneous structure.

By contrast, in MongoDB your collections are heterogeneous. Each element can have a different structure. Inside the Mutants collection you could create an element that has the 'Name', 'Favorite Food' and 'Age' attributes, and then some other element that is completely different: 'Name', 'Weaknesses', 'Location'. And it's all okay. In MongoDB collections are heterogeneous.

Now you are probably thinking:

__But how can I query a collection with completely different elements? How could I find a User by name for example, if I can't be sure that the element have a name attribute?__

And you would be 100% right.

This is one of the things that people confuse the most. That you could do this, doesn't mean you must or need to. Heterogeneous collections exist so that you can have the choice to structure your data as you need; exactly as you need and when you need. If you are modeling a collection of Users, you probably want to have 'First Name' and 'Last Name' attributes on each element. Awesome, enforce that. But in MongoDB that is enforced at the application level, not at the database level. Your business logic belongs outside the database.

MongoDB specialty is storing data, not your mental models. In a NoSQL database such as MongoDB, relationships and structure are implicit, instead of explicit. They do exist, but they are not enforced at the Database level.

__Example?__

Let's go back the User collection. Let's say we have this structure:

{% highlight ruby %}
 # User
 {
   'First Name': 'John'
   'Last Name': 'Doe'
   'Age': '25'
 }
{% endhighlight %}

That is a very simple model. Both MongoDB and MySQL could store this kind of element very easily.

In MySQL we would have a table called Users, with fields:

* first_name: VARCHAR(255)
* last_name: VARCHAR(255)
* age: INT.

In MongoDB we would store this document directly. The name of the attributes for this particular element will be stored in the document.

* 'First Name': UTF-8 String
* 'Last Name': UTF-8 Strings
* 'Age': Integer

Pretty simple, both MySQL and MongoDB can model this in a pretty direct way. The tricky part comes when you want to store complex data for a particular user. For example, a list of favorite colors.

In MongoDB we would simply store the document as this:

{% highlight ruby %}
{
  'First Name': 'John',
  'Last Name': 'Doe',
  'Age': '25',
  'Favorite Colors': ['red', 'blue', 'yellow']
}
{% endhighlight %}

Very simple. The data structure maps to our mental model 1-1.

MySQL don't have the ability to store collections inside an element. The way you would model this in MySQL is by creating a user_colors table that will store a collection of elements with the following attributes:

* id: A unique identifier for this element.
* color: Name of the color.
* user_id: Attribute that relates this element to one user.

So for finding all the favorite colors of a particular user you will take the user_colors collection and filter by a particular user_id: the remaining elements will be the collection of colors for a particular user. A relational query.

__Wait a minute, doesn't that mean I can do the same thing with both?__

Yes.

Most applications business models can be modeled in a SQL database. That is why they are so popular; they get the job done. Yet I do find it more naturally to use MongoDB to model business objects. Its rich document-based way of composing elements lends itself to naturally model any business model. The heterogeneous collection afford me the flexibility of migrating data with zero-downtime. Its design principles induced a simple implementation in which the database can horizontally scale.

Working with MongoDB is a joy.

And I invite you to take the best course there is in order to learn it:

[https://education.mongodb.com/](https://education.mongodb.com/)

Shameless self-promotion: 7% of the people got 100% of the score. I was one of them. What about you?