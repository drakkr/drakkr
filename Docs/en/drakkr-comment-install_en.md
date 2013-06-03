# Drakkr commenting system installation (Juvia)

The OS considered here is Debian. What else?

## Prerequisites

Install necessary Debian and Ruby packages:
* `apt-get install libmysqlclient-dev`: required by Ruby to compile MySQL access
* `apt-get install libapache2-mod-passenger`: enables Apache to serve Ruby pages
* `apt-get install ruby-dev`: required to compile some components
* `apt-get install ruby-sequel`: only if you what to migrate from WordPress
* `REALLY_GEM_UPDATE_SYSTEM=1 gem update --system`: to force Ruby gems non packaged by Debian
* `gem install bundler`: required to install Juvia
* `gem install bundle`: idem
* `gem install therubyracer`: if you don't have Node.js installed or don't want to

## Database

Create juvia user and database:
* If necessary, install MySQL (`apt-get install mysql-server`)
* Connect to MySQL
* `CREATE DATABASE juvia;`
* `CREATE USER 'juvia'@'localhost' IDENTIFIED BY 'the-password';`
* `GRANT ALL PRIVILEGES ON juvia.* TO 'juvia'@'localhost' WITH GRANT OPTION;`

## Install Juvia

* Go where you want to install Juvia and `git clone https://github.com/phusion/juvia.git`
* `cd juvia`
* Add the `gem 'therubyracer'` dependency at the end of the `Gemfile` file
* `cp config/database.yml.example config/database.yml`
* `vi config/database.yml`: insert MySQL credentials in the `_production:_` section, be carefull to put the password between double quotes 
* `cp config/application.yml.example config/application.yml` and edit the `_production:_` section
* Install the necessary dependencies: `bundle install --without='development test' --path=help`
* Install the database schema: `bundle exec rake db:schema:load RAILS_ENV=production`
* Compile the static assets: `bundle exec rake assets:precompile RAILS_ENV=production RAILS_GROUPS=assets`

Consult Juvia official install instructions on <https://github.com/phusion/juvia> if you have any problem.

## Configure an Apache VirtualHost

    <VirtualHost *:80>
	    ServerAdmin webmaster@drakkr.org
	    ServerName http://comment.drakkr.org

	    DocumentRoot /path/to/juvia/public
	    <Directory />
		    Options FollowSymLinks
		    AllowOverride None
	    </Directory>
	    <Directory /path/to/juvia/public>
		    Options Indexes FollowSymLinks MultiViews
		    AllowOverride All
		    Order allow,deny
		    allow from all
	    </Directory>

    </VirtualHost>

Make Apache owner of Juvia: `chown -R www-data:www-data juvia/`

Restart Apache: `/etc/init.d/apache2 restart`

## Juvia configuration

Connect to Juvia: <http://comment.drakkr.org>

Create an administrator account on the first connection.

Create a site and get the Site key (example: n5kdpjp9zkdz89hs21aihom25n3d6mu)

## Jekyll Boostrap configuration

Create the file _includes/custom/comments:

    <div id="comments"/>
    <script type="text/javascript" class="juvia">
    (function() {
	var options = {
	    container   : '#comments',
	    site_key    : 'n5kdpjp9zkdz89hs21aihom25n3d6mu',
	    topic_key   : '{{page.title}}',
	    topic_url   : location.href,
	    topic_title : document.title || location.href,
	    include_base: !window.Juvia,
	    include_css : !window.Juvia
	};

	function makeQueryString(options) {
	    var key, params = [];
	    for (key in options) {
		params.push(
		    encodeURIComponent(key) +
		    '=' +
		    encodeURIComponent(options[key]));
	    }
	    return params.join('&');
	}

	function makeApiUrl(options) {
	    // Makes sure that each call generates a unique URL, otherwise
	    // the browser may not actually perform the request.
	    if (!('_juviaRequestCounter' in window)) {
		window._juviaRequestCounter = 0;
	    }

	    var result =
		'http://comment.drakkr.org/api/show_topic.js' +
		'?_c=' + window._juviaRequestCounter +
		'&' + makeQueryString(options);
	    window._juviaRequestCounter++;
	    return result;
	}

	var s       = document.createElement('script');
	s.async     = true;
	s.type      = 'text/javascript';
	s.className = 'juvia';
	s.src       = makeApiUrl(options);
	(document.getElementsByTagName('head')[0] ||
	document.getElementsByTagName('body')[0]).appendChild(s);
    })();
    </script>

Change Jekyll configuration file: 
* `vi _config.yml`
* And set the value `custom` to the `JB : comments : provider :` parameter

