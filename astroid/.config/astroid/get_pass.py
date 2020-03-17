#!/usr/bin/env python3

from os import path
import configparser
import sys

from nacl.public import PrivateKey
import kpxcnm

CONFIG = configparser.ConfigParser()
CONFIG.read(path.expanduser("~/.config/astroid/keys.ini"))

k = kpxcnm.Kpxcnm(PrivateKey(kpxcnm.Kpxcnm._from_b64_str(CONFIG['DEFAULT']['privkey'])),
                  CONFIG['DEFAULT']['dbid'])

k.change_public_keys()
if k.test_associate(True):
    print(k.get_logins(sys.argv[1])[0]['password'])

