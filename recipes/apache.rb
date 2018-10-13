# Recipe to install Apache

package "httpd" do
  action :install
end

service "httpd" do
  action [:enable, :start]
end

#Virtual Hosts section

node["lamp"]["sites"].each do |sitename, data|
  document_root = "/var/www/html/#{sitename}"

  directory document_root do
    mode "0755"
    recursive true
    action :create
  end

  directory '/etc/httpd/sites-available' do
    mode '0755'
    recursive true
    action :create
  end

  directory "/var/www/html/#{sitename}/public_html" do
    action :create
  end

  directory "/var/www/html/#{sitename}/logs" do
    action :create
  end 

  template "/var/www/html/mediawiki.com/public_html/index.html" do
    source "index.html.erb"
    mode "0644"
  end
 
  template "/etc/httpd/sites-available/#{sitename}.conf" do
    source "vhosts.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => data["port"],
      :serveradmin => data["serveradmin"],
      :servername => data["servername"]
    )
    notifies :restart, "service[httpd]"
  end

end

