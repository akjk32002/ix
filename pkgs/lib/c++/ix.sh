{% extends '//die/hub.sh' %}

{% block lib_deps %}
lib/c
lib/c++/{{cplpl_std or '15'}}
{% endblock %}
