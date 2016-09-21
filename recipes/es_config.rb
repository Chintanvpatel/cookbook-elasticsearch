service "elasticsearch" do
  supports :status => true, :restart => true
  action [ :enable ]
end

template "synonyms.txt" do
  path   "#{node.elasticsearch[:path][:conf]}/synonyms.txt"
  source "synonyms.txt.erb"
  owner node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  notifies :restart, 'service[elasticsearch]' unless node.elasticsearch[:skip_restart]
end

template "stopwords.txt" do
  path   "#{node.elasticsearch[:path][:conf]}/stopwords.txt"
  source "stopwords.txt.erb"
  owner node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  notifies :restart, 'service[elasticsearch]' unless node.elasticsearch[:skip_restart]
end

template "hunspell_es_CO.aff" do
  path   "#{default.elasticsearch[:path][:hunspell]}/es_CO.aff"
  source "es_CO.aff.erb"
  owner node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  notifies :restart, 'service[elasticsearch]' unless node.elasticsearch[:skip_restart]
end

template "hunspell_es_CO.dic" do
  path   "#{default.elasticsearch[:path][:hunspell]}/es_CO.dic"
  source "es_CO.dic.erb"
  owner node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  notifies :restart, 'service[elasticsearch]' unless node.elasticsearch[:skip_restart]
end