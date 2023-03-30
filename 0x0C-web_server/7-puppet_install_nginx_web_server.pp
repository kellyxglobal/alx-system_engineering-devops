install Nginx package
package { 'nginx':
  ensure => installed,
}

 Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => running,
  enable => true,
}

# Configure Nginx server
file { '/etc/nginx/sites-available/default':
  content => "
    server {
      listen 80;
      server_name puppr.tech;

      location / {
        root /var/www/html;
        index index.html;
        try_files \$uri \$uri/ =404;
        add_header X-Hello-World 'Hello World!';
      }

      location /redirect_me {
        return 301 https://puppr.tech/;
      }
    }
  ",
}

# Enable default site
file { '/etc/nginx/sites-enabled/default':
  ensure => 'link',
  target => '/etc/nginx/sites-available/default',
}

# Remove default Nginx welcome page
file { '/var/www/html/index.nginx-debian.html':
  ensure => 'absent',
}

