---
layout: page-fullwidth
show_meta: false
title: "Les événements"
meta_title: "Événement"
subheadline: "Que se passe-t-il dans les prochains mois?"
header:
   image_fullwidth: "agenda.jpg"
permalink: "/senior/evenement/"
---

<div id="blog-index" class="row">
	<div class="small-12 columns t30">		
		<dl class="accordion">
			{% for post in site.categories.evenement limit:1000 %}
                        {% assign loopindex = forloop.index | modulo: 2 %}
			<dd class="accordion-navigation">
			<a href="{{ site.url }}{{ post.url }}" class="accordion-navigation" {% if loopindex == 0 %} style="background: #fff" {% endif %}><span class="iconfont"></span>{{ post.date | date: "%Y-%m-%d" }} › <strong>{{ post.title }}</strong></a>
			</dd>
			{% endfor %}
		</dl>
	</div><!-- /.small-12.columns -->
</div><!-- /.row -->
