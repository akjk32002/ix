{% extends '//mix/template/cmake.sh' %}

{% block fetch %}
# url https://github.com/microsoft/mimalloc/archive/refs/tags/v2.0.2.tar.gz
# md5 40c75843e55e5c02d47fc5b1fda30124
{% endblock %}

{% block deps %}
# bld {{mix.if_linux('lib/musl')}}
# bld env/c/nort boot/final/env/tools
{% endblock %}

{% block cmflags %}
-DMI_OVERRIDE=ON
-DMI_BUILD_STATIC=ON
-DMI_BUILD_SHARED=OFF
-DMI_BUILD_TESTS=OFF
{% endblock %}

{% block postinstall %}
cd ${out}/lib
mv mimalloc-*/* ./
rm mimalloc-*
{% endblock %}

{% block test %}
. ${out}/env

gcc ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} -o main -x c - << EOF
#include <stdlib.h>
#include <locale.h>

int main() {
    free(malloc(1));
    freelocale(0);
    free(realloc(0, 100));

    return 0;
}
EOF

./main
{% endblock %}
