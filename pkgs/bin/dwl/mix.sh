{% extends '//mix/make.sh' %}

{% block fetch %}
https://github.com/djpohly/dwl/archive/refs/tags/v0.2.1.tar.gz
1930d1f8aa6b748863c2fbb6121b22c2
{% endblock %}

{% block bld_libs %}
lib/c
lib/wayland
lib/wlroots/14
{% endblock %}

{% block bld_tool %}
bin/pkg-config
bin/wayland/protocols
{% endblock %}
