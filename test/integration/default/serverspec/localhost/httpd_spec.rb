require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
  c.path = "/sbin:/usr/sbin"
end

os = backend(Serverspec::Commands::Base).check_os
if os[:family] == "Ubuntu" 
  p = "apache2"
  index = "/var/www/index.html"
else
  p = "httpd"
  index = "/var/www/html/index.html"
end

describe package(p) do
  it { should be_installed }
end

describe service(p) do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe file(index) do
  it { should be_file }
end

