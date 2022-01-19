{% extends '//mix/template/autohell.sh' %}

{% block fetch %}
https://github.com/xiph/flac/archive/refs/tags/1.3.3.tar.gz
40de811000d510b9c65d5f1d1f53f26d
{% endblock %}

{% block bld_tool %}
bin/gettext
dev/build/auto/conf/2/69
dev/build/auto/make/1/16
{% endblock %}

{% block setup_tools %}
ln -s $(which xgettext) gettext
{% endblock %}

{% block autoreconf %}
sh autogen.sh
{% endblock %}

{% block lib_deps %}
lib/c
{% endblock %}
