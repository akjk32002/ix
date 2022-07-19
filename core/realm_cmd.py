import core.utils as cu
import core.manager as cm
import core.cmd_line as cc


def group_realms(l):
    d = []

    for x in l:
        kind, op, v = x

        if d and d[-1][2]['r'] != v['r']:
            yield d
            d = []

        d.append(x)

    if d:
        yield d


def cli_mut(ctx):
    mngr = cm.Manager(cc.config_from(ctx))

    if args := ctx['args']:
        for d in group_realms(cc.lex(args)):
            mngr.ensure_realm(d[0][2]['r']).mut(d).install()
    else:
        for r in mngr.iter_realms():
            r.mut([]).install()


def cli_list(ctx):
    mngr = cm.Manager(cc.config_from(ctx))

    if ctx['args']:
        for a in ctx['args']:
            for x in mngr.load_realm(a).pkgs['list']:
                print(x)
    else:
        for r in mngr.list_realms():
            print(r)


def cli_purge(ctx):
    cm.Manager(cc.config_from(ctx)).load_realm(ctx['args'][0]).uninstall()
