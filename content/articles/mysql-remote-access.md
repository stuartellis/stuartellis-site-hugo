+++
Title = "Enabling Remote Access to MySQL"
Slug = "mysql-remote-access"
Date = "2016-10-22T21:20:00+01:00"
Description = ""
Categories = ["databases"]
Tags = ["database", "mysql", "sql"]
Type = "article"

+++


Setting up MySQL remote access with SSL encryption is surprisingly awkward. This article was pieced together from a number of places, but [a post on the Distracted-IT blog](http://distracted-it.blogspot.co.nz/2014/04/getting-mysql-server-to-run-with-ssl.html) was the most helpful.

<!--more-->

# Before You Begin #

To enable remote access, you need to:

* Create a set of SSL certificates
* Configure MySQL server to enable network access and use the SSL certificates
* Create login accounts that permit remote access

# Creating Self-Signed SSL Certificates for MySQL Server #

> MySQL uses obsolete certificate formats, so you need to use the commands here. [This post explains](http://askubuntu.com/questions/194074/enabling-ssl-in-mysql/439274#439274).

First, create a CA certificate for signing server and client certificates:

    openssl genrsa 2048 > mysql-ca-key.pem
    openssl req -sha1 -new -x509 -nodes -days 3650 -key mysql-ca-key.pem > mysql-ca-cert.pem

To create a certificate for the MySQL server using the CA certificate:

    openssl req -sha1 -newkey rsa:2048 -days 730 -nodes -keyout mysql-server-key.pem > mysql-server-req.pem
    openssl x509 -sha1 -req -in mysql-server-req.pem -days 730 -CA mysql-ca-cert.pem -CAkey mysql-ca-key.pem -set_serial 01 > mysql-server-cert.pem
    openssl rsa -in mysql-server-key.pem -out mysql-server-key.pem

Create a certificate bundle from the server and CA certificates:

    cat mysql-server-cert.pem mysql-ca-cert.pem > mysql-bundle-cert.pem

For each client:

    openssl req -sha1 -newkey rsa:2048 -days 730 -nodes -keyout mysql-client-key.pem > mysql-client-req.pem
    openssl x509 -sha1 -req -in mysql-client-req.pem -days 730 -CA mysql-ca-cert.pem -CAkey mysql-ca-key.pem -set_serial 01 > mysql-client-cert.pem
    openssl rsa -in mysql-client-key.pem -out mysql-client-key.pem

The *Common Name* for the client certificate must be the MySQL username.

# Configuring MySQL Server #

To enable network access, edit the *bind-address* setting in the MySQL configuration file to specify 0.0.0.0:

    bind-address = 0.0.0.0

To use the SSL certificate, you need to copy the file for the CA certificate, the server certificate and the file that contains the private key for the server certificate to the */etc/mysql/* directory. Set the permissions for these files:

    cp mysql-server-cert.pem /etc/mysql/
    cp mysql-ca-cert.pem /etc/mysql/
    cp mysql-server-key.pem /etc/mysql/
    chown mysql:mysql /etc/mysql/*.pem
    chmod 0640 /etc/mysql/*.pem

Edit the MySQL configuration file to specify these in the *mysqld* section:

    ssl-ca=/etc/mysql/mysql-ca-cert.pem
    ssl-cert=/etc/mysql/mysql-server-cert.pem
    ssl-key=/etc/mysql/mysql-server-key.pem
    ssl-cipher=DHE-RSA-AES256-SHA

To protect the server, configure the firewall to only allow connections from specific addresses. For example, if you use *ufw* the command is:

    sudo ufw allow from x.x.x.x to any port 3306 proto tcp

Where x.x.x.x is the IP version 4 address.

# Creating MySQL Accounts for Remote Access #

To create logins that allow them to be used from any client, ensure that the host portion of the username set as the *%* character:

~~~sql
GRANT ALL ON * TO 'username'@'%' IDENTIFIED BY 'passwd' REQUIRE SSL;
~~~

Replace *username* with the username that you would like to use, and replace *passwd* with the password for the new account.

# Login to MySQL from a Remote System #

To connect to the server using SSL:

    mysql -u mylogin -h myserver.mydomain -p --ssl-ca=mysql-bundle-cert.pem --ssl-cert=mysql-client-cert.pem --ssl-key=mysql-client-key.pem

The *ssl-ca* option requires the certificate bundle.

To verify that the connection is protected by SSL, type *\s* at the MySQL prompt. The *SSL* item will show the cipher:

     SSL:			Cipher in use is DHE-RSA-AES256-SHA
