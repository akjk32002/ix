{% extends '//util/autohell.sh' %}

{% block fetch %}
# url https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tar.xz
# md5 fddb060b483bc01850a3f412eea1d954
{% endblock %}

{% block deps %}
# bld lib/dlfcn lib/z lib/xz lib/ffi lib/intl lib/gdbm lib/bzip2 lib/iconv
# bld lib/expat lib/sqlite3 lib/ncurses lib/openssl lib/readline
# bld lib/mpdecimal {{'lib/linux' | linux}}
# bld env/std boot/final/env/tools
{% endblock %}

{% block toolconf %}
{% if mix.platform.target.os == 'darwin' %}
ln -s /usr/bin/arch ./
{% endif %}
{% endblock %}

{% block patch %}
sed -e 's/MULTIARCH=\$.*/MULTIARCH=/' \
    -i ./configure

{% block patch_ffi %}
sed -e 's/ffi_type ffi_type.*//'      \
    -e 's/FFI_TYPE_LONGDOUBLE }.*//'  \
    -i Modules/_ctypes/cfield.c

>Modules/_ctypes/malloc_closure.c
{% endblock %}

sed -e 's|/usr/bin/arch|arch|' -i ./configure

sed -e 's|/usr|/eat/shit|' -i ./configure
sed -e 's|/usr|/eat/shit|' -i ./setup.py
sed -e 's|/usr|/eat/shit|' -i ./Makefile.pre.in

(base64 -d | gcc ${CPPFLAGS} ${CFLAGS} ${CONLYFLAGS} ${LDFLAGS} -o fix -x c -) << EOF
{% include 'fix.c/base64' %}
EOF

cat Modules/Setup | ./fix | sed -e 's|-l.*||' | grep -v capi | grep -v nis | grep -v readline | grep -v spwd > Modules/Setup.local

# some hand job
cat << EOF >> Modules/Setup.local
_lsprof _lsprof.c rotatingtree.c
_opcode _opcode.c
_posixshmem _multiprocessing/posixshmem.c -I$(srcdir)/Modules/_multiprocessing
_multiprocessing _multiprocessing/multiprocessing.c _multiprocessing/semaphore.c -I$(srcdir)/Modules/_multiprocessing
_queue _queuemodule.c
{% block extra_modules %}
_ctypes _ctypes/_ctypes.c _ctypes/callbacks.c _ctypes/callproc.c _ctypes/stgdict.c _ctypes/cfield.c _ctypes/malloc_closure.c -DPy_BUILD_CORE_MODULE
_hashlib _hashopenssl.c
_ssl _ssl.c -DUSE_SLL
_lzma _lzmamodule.c
_bz2 _bz2module.c
{% endblock %}
EOF

>setup.py
{% endblock %}

{% block cflags %}
export COFLAGS=$(echo "${COFLAGS}" | tr ' ' '\n' | grep -v 'with-system-ffi' | tr '\n' ' ')
{% endblock %}

{% block coflags %}
--with-ensurepip=no
--with-system-libmpdec
--with-system-expat
--with-system-ffi
{% endblock %}

{% block test %}
$out/bin/python3 -c 'import zlib; import multiprocessing; import cProfile;'
{% block extra_tests %}
$out/bin/python3 -c 'import hashlib; import ssl; import lzma; import bz2;'
{% endblock %}
{% endblock %}

{% block postinstall %}
rm -rf ${out}/lib/python*/config*
rm -rf ${out}/lib/python*/test

find ${out} | grep __pycache__ | xargs rm -rf
{% endblock %}
