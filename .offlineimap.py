import keepasshttp
import sys, os

def blockPrint():
    sys.stdout = open(os.devnull, 'w')

def enablePrint():
    sys.stdout = sys.__stdout__

session = keepasshttp.start('offlineimap')

def get_password( str ):
    blockPrint()
    passw = session.getLogins( str )[0]['Password'].value
    enablePrint()
    return passw

def get_username( str ):
    blockPrint()
    login = session.getLogins( str )[0]['Login']
    enablePrint()
    return login
