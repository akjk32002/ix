{% extends 't/ix.sh' %}

{% block cmake_flags %}
BUILD_APPS=OFF
{{super()}}
{% endblock %}
