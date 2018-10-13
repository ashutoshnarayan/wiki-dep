
mysqlpass = data_bag_item("mysql", "sqlpass.json")


package %w( php php-mysql php-gd php-xml mariadb-server mariadb ) do
  action :install
end

service "mariadb" do
  action [:enable, :start]
end

cookbook_file '/tmp/mysql_setup.sh' do
  source 'mysql_setup.sh'
  mode '0755'
  action :create
end

execute "setup_mysqldb" do
  command "sh /tmp/mysql_setup.sh"
end

#script 'mysql_setup' do
#  interpreter "bash"
#  user 'root'
#  cwd "/tmp"
#  code <<-EOH
#    PASS=`pwgen -s 40 1`
#    mysql -u root <<MY_Q
#    CREATE DATABASE wikidatabase1;
#    CREATE USER 'wiki2'@'localhost' IDENTIFIED BY '$PASS';
#    GRANT ALL PRIVILEGES ON wikidatabase1.* TO 'wiki2'@'localhost';
#    FLUSH PRIVILEGES; 
#    MY_Q
#  EOH
#end
