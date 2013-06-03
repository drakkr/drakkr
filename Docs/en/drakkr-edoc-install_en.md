# Drakkr edoc repository installation (Gitit)

The OS considered here is Debian. What else?

## Prerequisites

Enable some Apache2 modules:
* `a2enmod rewrite`
* `a2enmod proxy`
* `a2enmod proxy_http`

## Install Gitit

* `apt-get install gitit`
* `mkdir /opt/gitit`
* `cd /opt/gitit`
* `gitit --print-default-config > my.conf`: initialize Gitit configuration file

## Configure Gitit

TODO

Check Gitit official documentation <https://github.com/jgm/gitit> if needed.

## Configure Apache

Overwrite the `/etc/apache2/site-available/default` configuration:

    <VirtualHost *:80>
	ServerName http://edoc.drakkr.org
	DocumentRoot /opt/gitit/
	RewriteEngine On
	ProxyPreserveHost On
	ProxyRequests Off

	<Proxy *>
	  Order deny,allow
	  Allow from all
	</Proxy>

	ProxyPassReverse /    http://127.0.0.1:5001
	RewriteRule ^(.*) http://127.0.0.1:5001$1 [P]

	ErrorLog /var/log/apache2/error.log
	LogLevel warn

	CustomLog /var/log/apache2/access.log combined
	ServerSignature On

    </VirtualHost>

## Start the server

Restart Apache: `/etc/init.d/apache2 restart`

Start Gitit: 
* `cd /opt/gitit`
* `gitit -f my.conf` 

## Wikidata structure

TODO