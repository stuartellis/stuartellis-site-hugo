+++
Title = "Configuring nginx"
Slug = "nginx-setup"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["administration"]
Tags = ["linux", "web"]
Type = "article"
Draft = true

+++


The nginx server provides a fast, efficient and easy to configure host for Web applications.

<!--more-->

# Installing nginx #

First of all, decide whether you need standard [nginx](http://nginx.org) or [Phusion Passenger](https://www.phusionpassenger.com/). Passenger adds support for hosting Ruby, Python and Node.js applications. If you need to run PHP use standard nginx and add PHP-FPM.

If you are using Linux, install nginx with your package manager and add Passenger if you need it.

Debian and Ubuntu provide a standard package for nginx:

    $ apt-get install nginx

The Debian and Ubuntu packages include support for multiple sites.

# Security and SSL #

For general security, turn off version identifiers and set an appropriate size limit for uploaded files:

    # Disable display of server information
    server_tokens off;

    # Limit the size of file uploads
    client_max_body_size 10M;

Use the [Mozilla SSL Configuration Generator](https://mozilla.github.io/server-side-tls/ssl-config-generator/) to produce the best SSL configuration for your system. For example, [this link](https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=nginx-1.6.2&openssl=1.0.1f&hsts=yes&profile=modern) provides a configuration that provides high security, and [this configuration](https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=nginx-1.6.2&openssl=1.0.1f&hsts=yes&profile=intermediate) is a practical configuration:

    server {
        listen 443 ssl;

        # Certificates sent to the client in SERVER HELLO are concatenated in ssl_certificate
        ssl_certificate /path/to/signed_cert_plus_intermediates;
        ssl_certificate_key /path/to/private_key;
        ssl_session_timeout 5m;
        ssl_session_cache shared:SSL:50m;

        # Diffie-Hellman parameter for DHE ciphersuites, recommended 2048 bits
        ssl_dhparam /path/to/dhparam.pem;

        # intermediate configuration. tweak to your needs.
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-C    3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-C    3-SHA:!EDH-RSA-DES-C    3-SHA:!KRB5-DES-C    3-SHA';
        ssl_prefer_server_ciphers on;

        # HSTS (ngx_http_headers_module is required) (15768000 seconds = 6 months)
        add_header Strict-Transport-Security max-age=15768000;

        # OCSP Stapling ---
        # fetch OCSP records from URL in ssl_certificate and cache them
        ssl_stapling on;
        ssl_stapling_verify on;

        # verify chain of trust of OCSP response using Root CA and Intermediate certs
        ssl_trusted_certificate /path/to/root_CA_cert_plus_intermediates;

        resolver <IP-OF-DNS-RESOLVER>;

        ....
    }

To generate the DHparam file, use OpenSSL:

    openssl dhparam -out <YOUR-PARAM-FILE>.pem -5 2048

To test your SSL configuration, use [the SSL Labs check](https://www.ssllabs.com/ssltest/).

# Documentation and Resources #

* The [nginx documentation](http://nginx.org/en/docs/) is excellent.
* The [Pitfalls page on the nginx Wiki](http://wiki.nginx.org/Pitfalls) describes some common configuration mistakes.
