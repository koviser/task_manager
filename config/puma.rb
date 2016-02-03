home = "/var/www/vhosts/liptonsmm.prodigi.com.ua/lipton-sinatra"
root = "#{home}/current"

bind "unix://#{home}/shared/unicorn.sock"
pidfile "#{root}/tmp/puma/puma.pid"
state_path "#{root}/tmp/puma/puma.state"
rackup "#{root}/config.ru"

daemonize true
threads 1, 2
# workers 2
stdout_redirect "#{home}/shared/log/puma.log", "#{home}/shared/log/puma_error.log", true

activate_control_app