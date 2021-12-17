{% extends '//mix/template/c_std.sh' %}

{% block configure %}
(

    cat << EOF
{% block extra_modules %}
{% endblock %}
EOF

    (
{% block more_modules %}
{% endblock %}
    )

    IFS=":"; for l in ${PYTHONPATH}; do
        p="${l}/exports"

        if test -f ${p}; then
            cat ${p}
        fi
    done
) | sort | uniq > modules
{% endblock %}
