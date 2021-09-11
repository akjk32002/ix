def package(mix):
    deps = [
        'boot/stage/6/clang',
    ]

    return {
        'build': {
            'script': mix.files.build_py,
            'depends': deps,
        },
        'runtime': {
            'depends': deps + [
                'boot/stage/6/env/tools',
            ],
        },
    }
