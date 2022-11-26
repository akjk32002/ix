{% extends '//die/c/cmake.sh' %}

{% block fetch %}
https://github.com/jtanx/libclipboard/archive/refs/tags/v1.1.tar.gz
md5:bddc22070b6804ed63994af49b778b70
{% endblock %}

{% block lib_deps %}
lib/c
lib/darwin/framework/AppKit
{% endblock %}

{% block bld_tool %}
bld/pkg/config
{% endblock %}
