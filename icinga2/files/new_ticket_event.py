#!/usr/bin/env python

import salt.client
import socket
import subprocess
import os


def get_ticket(client):
    return subprocess.check_output(['icinga2', 'pki', 'ticket', '--cn', client]).strip()

caller = salt.client.Caller()
client = os.environ['CLIENT']
master = socket.getfqdn()
tag = 'icinga2/master/%s/client/add' % master

caller.sminion.functions['event.send'](
    tag,
    {
        'client': client,
        'ticket': get_ticket(client)
    }
)
