---
title: Home
layout: front_page
---
This is a repository of good liturgical music, made available for anybody who wants it.

{% for p in site.static_files %}
- [{{ p.path }}]({{ p.path | relative_url }})
{% endfor %}

{% assign motet = site.data.database[0] %}
{% for id in site.data.database %}
	- {{ id.name }}
{% endfor %}


---------



- [{{ motet.name }}]({{ motet.url }}): {{ motet.voicing }}

<!-- Then you can access the book entry at the id with site.data.assets[17]. You can create includes with parameters for every type you want to embed. For example:

 <!-- _includes/image.html (id, class)-->
{% assign id = include.id | times: 1 %}
{% assign image = site.data.images[id] %}
<img
  class="{{ include.class }}"
  alt="{{ image.name }}"
  src="{{ image.url }}"
/>
-->