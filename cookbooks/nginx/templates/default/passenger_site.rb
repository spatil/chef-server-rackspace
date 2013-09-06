server {

  # File upload allowances
  client_max_body_size 50M;
  client_body_buffer_size 128k;

  # if you're running multiple servers, instead of "default" you should
  # put your main domain name here
  listen 80;

  # you could put a list of other domain names this application answers
  server_name <%= @domains.join(' ') %>;
  access_log /var/log/nginx/<%= @sitename %>.log;
  rewrite_log on;

  root <%= File.join @deploy_path, @sitename %>/current/public;
  #index index.html index.htm;
  passenger_enabled on;

  #try_files $uri/index.html $uri.html $uri @unicorn;

  # if the request is for a static resource, nginx should serve it directly
  # and add a far future expires header to it, making the browser
  # cache the resource and navigate faster over the website
  # this probably needs some work with Rails 3.1's asset pipe_line
  location ~ ^/(assets|images|javascripts|stylesheets|system)/ {
    expires max;
    add_header Cache-Control public;
    break;
  }

  error_page 500 502 503 504 /50x.html;

}
