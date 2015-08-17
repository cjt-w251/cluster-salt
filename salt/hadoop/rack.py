#!/usr/bin/env python

import sys

ip_map= {
    '10.114.77.140': 'ji',
    '10.114.77.146': 'ji',
    '10.114.77.152': 'ji',
    '10.115.7.156': 'tom',
    '10.115.7.168': 'tom',
    '10.115.7.176': 'tom',
    '10.114.133.107': 'charlie',
    '10.114.133.74': 'charlie',
    '10.114.133.75': 'charlie',
    '10.114.172.11': 'chula',
    '10.114.172.14': 'chula',
    '10.114.172.22': 'chula'
}
name_map= {
    'node1': 'ji',
    'node2': 'ji',
    'node3': 'ji',
    'node4': 'tom',
    'node5': 'tom',
    'node6': 'tom',
    'node7': 'charlie',
    'node8': 'charlie',
    'node9': 'charlie',
    'node10': 'chula',
    'node11': 'chula',
    'node12': 'chula'
}

for arg in sys.argv[1:]:
    rack = '/rack/default'
    if arg in ip_map:
        rack = '/rack/%s' % ip_map[arg]
    else:
        arg = arg.split('.')[0]
        if arg in name_map:
            rack = '/rack/%s' % name_map[arg]
    print rack,
