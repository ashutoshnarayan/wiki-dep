#Download tarfile

remote_file "#{Chef::Config[:file_cache_path]}/" + node['lamp']['mediawiki']['tarball']['name'] do
  source node['lamp']['mediawiki']['tarball']['url']
end

# extract tarfile

bash 'extract_mediawiki' do
  user 'root'
  cwd '/var/www'
  code "tar -zxf #{Chef::Config[:file_cache_path]}/" + node['lamp']['mediawiki']['tarball']['name'] 
  action :run
end

directory '/var/www/mediawiki' do
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end

bash 'links' do
  cwd '/var/www'
  user 'root'
  code <<-EOH
  /bin/mv "#{node['lamp']['mediawiki']['app']}-#{node['lamp']['mediawiki']['version']} #{node['lamp']['mediawiki']['app']}"
  ln -s "mediawiki-#{node['lamp']['mediawiki']['version']}/ mediawiki"
  chown -R apache:apache "/var/www/mediawiki-#{node['lamp']['mediawiki']['version']}"
  EOH
end


#restart httpd

service "httpd" do
  action :restart
end

package 'firewalld' do
  action :install
end

bash 'enable_ports_disable_selinux' do
  code <<-EOH
  firewall-cmd --add-service=http
  firewall-cmd --add-service=https
  restorecon -FR "/var/www/mediawiki-#{node['lamp']['mediawiki']['version']}/"
  restorecon -FR /var/www/mediawiki
  EOH
end

