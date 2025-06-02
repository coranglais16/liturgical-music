---
title: Home
layout: front_page
---
This is a repository of good liturgical music, made available for anybody who wants it.

{% for id in site.data.database %}
- {{ id.composer }}: [{{ id.title }}]({{ id.path }}): {{ id.voicing }}
{% endfor %}

---------

<!-- Then you can access the book entry at the id with site.data.assets[17]. You can create includes with parameters for every type you want to embed. For example:

 <!-- _includes/image.html (id, class)-->
{% assign id = include.id | times: 1 %}
{% assign image = site.data.images[id] %}
<img
  class="{{ include.class }}"
  alt="{{ image.name }}"
  src="{{ image.url }}"
/>