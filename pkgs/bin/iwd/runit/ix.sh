{% extends '//die/hub.sh' %}

{% block run_deps %}
bin/runsrv
bin/iwd/d
bin/iwd/runit/scripts
{% endblock %}
