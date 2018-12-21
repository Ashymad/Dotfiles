#!/usr/bin/env python3

from os import path
import configparser
import sys

import kpxcnm
from nacl.public import PrivateKey

config = configparser.ConfigParser()
config.read(path.expanduser("~/.config/astroid/keys.ini"));

k = kpxcnm.Kpxcnm(PrivateKey(kpxcnm.Kpxcnm._from_b64_str(config['DEFAULT']['privkey'])),
                  config['DEFAULT']['dbid'])

k.change_public_keys()
if k.test_associate(True):
    print(k.get_logins(sys.argv[1])[0]['password'])
