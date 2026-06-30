---
title: Home
---
This is a repository of good liturgical music, made available for anybody who wants it.

Last updated: {{ date }}  <!-- put Liquid code for date updated here -->
There are currently {{ site.static_files | size }} motets in the repository.

<div class="table-responsive">
    <table class="table table-sm table-hover" 
          data-toggle="table" 
          data-search="true" 
          data-sortable="true">
    	<thead>
    		<tr>
    			<th scope="col" data-field="composer" data-sortable="true">Composer</th>
    			<th scope="col" data-field="title" data-sortable="true">Title</th>
    			<th scope="col" data-field="genre" data-sortable="true">Genre</th>
    			<th scope="col" data-field="voicing" data-sortable="true">Voicing</th>
    		</tr>
    	</thead>
    	<tbody class="table-group-divider">
        	{% for id in site.data.database %}
                {% include table-rows.html 
                    composer=id.composer 
                    title=id.title 
                    url=id.path 
                    genre=id.genre 
                    voicing=id.voicing %}
          {% endfor %}
    	</tbody>
    </table>
</div>

<!-- Then you can access the book entry at the id with site.data.assets[17]. You can create includes with parameters for every type you want to embed. For example:

 <!-- _includes/image.html (id, class)-->
{% assign id = include.id | times: 1 %}
{% assign image = site.data.images[id] %}
<img
  class="{{ include.class }}"
  alt="{{ image.name }}"
  src="{{ image.url }}"
/>