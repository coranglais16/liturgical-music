---
title: Home
layout: front_page
---
This is a repository of good liturgical music, made available for anybody who wants it.

{% for p in site.static_files %}
	- [{{ p.path }}]({{ p.path | relative_url }})
{% endfor %}