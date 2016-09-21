template "synonyms1.txt" do
  path   "#{node.elasticsearch[:path][:conf]}/synonyms1.txt"
  source "synonyms.txt.erb"
  owner node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  notifies :restart, 'service[elasticsearch]' unless node.elasticsearch[:skip_restart]
end