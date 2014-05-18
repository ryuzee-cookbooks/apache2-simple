#
# Cookbook Name:: apache2-simple
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

if node["platform"] == "centos" and node["platform_version"][0] == "5" 
  include_recipe "yum::remi"
end

case node["platform"]
when "centos", "redhat", "amazon", "scientific", "fedora"

  %w{httpd}.each do |package_name|
    package package_name do
      action :upgrade
    end
  end

  file "/etc/httpd/conf.d/welcome.conf" do
    action :delete
  end

  directory "#{node['apache2-simple']['document_root']}" do
    owner "root"
    group "root"
    mode 00755
    action :create
    recursive true
    only_if { node['apache2-simple']['create_document_root'] == true }
  end

  file "#{node['apache2-simple']['document_root']}/index.html" do
    action :create_if_missing
    content "It works!"
  end

  template "/etc/httpd/conf/httpd.conf" do
    source "httpd.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, 'service[httpd]'
  end

  service "httpd" do
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
  end

when "ubuntu","debian"

  %w{apache2}.each do |package_name|
    package package_name do
      action :upgrade
    end
  end

  service "apache2" do
    supports :restart => true, :reload => true, :status => true
    action [:enable, :start]
  end

end

# vim: filetype=ruby.chef
