import os
import json

import core.utils as cu
import core.error as ce


def preproc(d):
    for x in d.split('\n'):
        x = x.strip()

        if not x:
            continue

        if x[0] == '#':
            continue

        yield x


def cononize(v):
    s = ' '.join(preproc(v))

    while '  ' in s:
        s = s.replace('  ', ' ')

    return s


def parse_urls(urls):
    cur = {}

    for l in cononize(urls).split(' '):
        if '://' in l:
            cur['url'] = l
        else:
            cur['md5'] = l

        if len(cur) == 2:
            yield cur
            cur = {}


class RenderContext:
    def __init__(self, package):
        self.package = package

    def render(self):
        return json.loads(self.template(self.package.name))

    def fix_list(self, lst):
        return cononize(lst)

    def parse_list(self, lst):
        for x in self.fix_list(lst).split(' '):
            if x:
                yield x

    def string_to_json(self, s):
        return json.dumps(s)

    def urls_to_json(self, urls):
        return json.dumps(list(parse_urls(urls)))

    def list_to_json(self, lst):
        return json.dumps(list(self.parse_list(lst)))

    def load_file(self, name):
        n = os.path.join(os.path.dirname(self.package.name), name)

        return self.package.manager.env.source(n)[0]

    def template(self, path):
        pkg = self.package

        tmpl = pkg.manager.env.get_template(path)
        kind = pkg.flags['kind']

        args = cu.dict_dict_update({
            'ix': self,
            'ix_bin': ' '.join(pkg.config.ops.respawn()),
            'host': pkg.host,
            'tool': pkg.name.startswith('bld/'),
            'name': pkg.name,
            'uniq_id': pkg.uniq_id,
            kind: True,
            pkg.flags['target']['os']: True,
            'boot': pkg.name.startswith('bld/boot/'),
        }, pkg.flags)

        try:
            return self.strip_template(tmpl.render(args))
        except Exception as e:
            raise ce.Error(f'can not render {path}', exception=e)

    def strip_template(self, v):
        vv = v.replace('\n\n\n', '\n\n')

        if vv == v:
            return v

        return self.strip_template(vv)
