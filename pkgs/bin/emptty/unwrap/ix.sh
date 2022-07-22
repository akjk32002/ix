{% extends '//die/go/c.sh' %}

{# TODO(pg): get rid of /usr/bin/getent reference #}

{% block fetch %}
https://github.com/tvrzna/emptty/archive/864c0ec71bdb9309b0458fdaae141654ad04aa93.tar.gz
sem:17a33795aee47d65721505bf6bb011d3638cfa46d1af313cc79eba8e452a3b97
{% endblock %}

{% block go_tags %}
nopam
noxlib
noutmp
{% endblock %}

{% block install %}
mkdir ${out}/bin
cp emptty ${out}/bin/
{% endblock %}

{% block patch %}
sed -e 's|env: Xorg|env: Wayland|' -i src/desktop.go
{% endblock %}