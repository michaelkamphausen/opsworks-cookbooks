#
# Cookbook Name:: dependencies
# Recipe:: update

include_recipe 'packages'
include_recipe 'gem_support'

case node[:platform]
when 'centos','redhat','fedora','amazon'
  #if node[:dependencies][:upgrade_rpms] - not implemented in the application jet
  if node[:dependencies][:upgrade_debs] == 'true'
    execute 'yum -y update' do
      action :run
    end
  end
when 'debian','ubuntu'
  if node[:dependencies][:update_debs] == 'true'
    execute 'apt-get update' do
      action :run
    end
  end

  if node[:dependencies][:upgrade_debs] == 'true'
    execute 'apt-get upgrade -y' do
      action :run
    end
  end
end

if node[:dependencies][:upgrade_gems] == 'true'
  execute 'gem update' do
    action :run
  end
end
