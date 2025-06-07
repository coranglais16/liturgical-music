---
title: Home
---
This is a repository of good liturgical music, made available for anybody who wants it.

<table>
	<thead>
		<tr>
			<th scope="col">Composer</th>
			<th scope="col">Title</th>
			<th scope="col">Genre</th>
			<th scope="col">Voicing</th>
		</tr>
	</thead>
	<tbody>
    	{%- for id in site.data.database %}
            {%- include table-rows.html 
                composer=id.composer 
                title=id.title 
                url=id.path 
                genre=id.genre 
                voicing=id.voicing %}
        {%- endfor %}
	</tbody>
</table>

<!-- Then you can access the book entry at the id with site.data.assets[17]. You can create includes with parameters for every type you want to embed. For example:

 <!-- _includes/image.html (id, class)-->
{% assign id = include.id | times: 1 %}
{% assign image = site.data.images[id] %}
<img
  class="{{ include.class }}"
  alt="{{ image.name }}"
  src="{{ image.url }}"
/>