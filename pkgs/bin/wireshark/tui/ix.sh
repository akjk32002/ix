{% extends '//bin/wireshark/t/ix.sh' %}

{% block cmake_flags %}
{{super()}}
BUILD_wireshark=OFF
{% endblock %}
