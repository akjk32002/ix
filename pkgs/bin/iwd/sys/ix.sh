{% extends '//bin/iwd/t/ix.sh' %}

{% block bld_libs %}
{{super()}}
lib/readline
{% endblock %}

{% block build_flags %}
compress
{% endblock %}

{% block install %}
{{super()}}
rm ${out}/bin/iwmon
{% endblock %}
