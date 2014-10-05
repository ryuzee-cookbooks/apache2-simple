require 'spec_helper'

if os[:family] == "ubuntu" 
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

