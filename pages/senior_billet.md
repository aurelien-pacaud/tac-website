---
layout: page-fullwidth
show_meta: false
title: "Les billets d'Alain"
meta_title: "Billets"
subheadline: "L'humeur d'Alain après match"
header:
   image_fullwidth: "header_unsplash_5.jpg"
permalink: "/senior/billet/"
---

<div id="blog-index" class="row">
	<div class="small-12 columns t30">		
		<dl class="accordion">
			{% for post in site.categories.billet limit:1000 %}
                        {% assign loopindex = forloop.index | modulo: 2 %}
			<dd class="accordion-navigation">
			<a href="{{ site.url }}{{ post.url }}" class="accordion-navigation" {% if loopindex == 0 %} style="background: #fff" {% endif %}><span class="iconfont"></span>{{ post.date | date: "%Y-%m-%d" }} › <strong>{{ post.title }}</strong></a>
			</dd>
			{% endfor %}
		</dl>
	</div><!-- /.small-12.columns -->
</div><!-- /.row -->
