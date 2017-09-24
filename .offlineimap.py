import keepasshttp

session = keepasshttp.start('offlineimap')

def get_password( str ):
    return session.getLogins( str )[0]['Password'].value

def get_username( str ):
    return session.getLogins( str )[0]['Login']
