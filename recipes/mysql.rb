
mysqlpass = data_bag_item("mysql", "sqlpass.json")

mysql_client 'default' do
   action :create
end

mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password mysqlpass["password"]
  action [:create, :start]
end
