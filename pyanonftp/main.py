from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

def main():
    # Instantiate a dummy authorizer for managing 'virtual' users
    authorizer = DummyAuthorizer()

    # Define a new user having full r/w permissions and a read-only
    # anonymous user having full r/w permissions and a read-only
    authorizer.add_user('root', 'root', '/file-server/', perm='elradfmwMT')
    authorizer.add_anonymous('/file-server-anon/', perm='elradfmwMT')

    # Instantiate FTP handler class
    handler = FTPHandler
    handler.authorizer = authorizer
    # Passive ports
    handler.passive_ports = range(40000, 40009)
    handler.permit_foreign_addresses = True

    handler.banner = "pyanonftp FTP server ready."

    # connect using an address 0.0.0.0 with port 21
    address = ('', 21)
    server = FTPServer(address, handler)

    # set a limit for connections
    server.max_cons = 256
    server.max_cons_per_ip = 5

    # start ftp server
    server.serve_forever()


if __name__ == '__main__':
    main()
