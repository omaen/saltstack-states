#!/usr/bin/env python

import salt.client
import os


def get_file_content(filename):
    with open(filename, 'r') as f:
        return f.read()


caller = salt.client.Caller()
tag = 'borgbackup/client/add'

caller.sminion.functions['event.send'](
    tag,
    {
        'server': os.environ['SERVER'],
        'public_key': get_file_content(os.environ['PUBLIC_KEY'])
    }
)
