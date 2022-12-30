{% extends '//die/proxy.sh' %}

{% block run_deps %}
bld/kuroko
bld/wrapcc/dynlink
{% endblock %}

{% block install %}
cd ${out}; mkdir bin; cd bin

base64 -d << EOF > wrapcc
{% include 'wrapcc.krk/base64' %}
EOF

chmod +x *
{% endblock %}
