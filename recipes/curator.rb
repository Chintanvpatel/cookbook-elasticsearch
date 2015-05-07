include_recipe 'python::pip'

easy_install_package "pbr" do
    action :install
end 

easy_install_package "six" do
    version node.elasticsearch[:six][:version]
    action :install
end

python_pip "elasticsearch-curator" do
    version node.elasticsearch[:curator][:version]
    action :install
end

# see http://docs.opscode.com/resource_cron.html
node.elasticsearch[:curator][:cron].sort.each do |cronjob, jobdetails|
    cron cronjob do
        action jobdetails[:action].nil? ? :create : jobdetails[:action]
        minute jobdetails[:minute]
        hour jobdetails[:hour]
        day jobdetails[:day]
        weekday jobdetails[:weekday]
        month jobdetails[:month]
        mailto jobdetails[:mailto]
        user jobdetails[:user]
        path jobdetails[:path].nil? ? "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin" : jobdetails[:path]
        command %Q{ #{jobdetails[:command]} }
    end
end
