#!/usr/bin/env python

import salt.client
import os


def get_file_content(filename):
    with open(filename, 'r') as f:
        return f.read()


caller = salt.client.Caller()
server = os.environ['SERVER']
tag = 'borgbackup/%s/client/add' % server

caller.sminion.functions['event.send'](
    tag,
    {
        'server': server,
        'public_key': get_file_content(os.environ['PUBLIC_KEY'])
    }
)
