login_user = node['wireless_camera']['user']
login_group = node['wireless_camera']['group']
login_home = node['wireless_camera']['home']

target_dir = ::File.join login_home, 'motion'

directory target_dir do
  mode 0777
  owner login_user
  group login_group
end

cookbook_file '/etc/modules' do
  notifies :run, 'bash[load_modules]', :immediately
end

bash 'load_modules' do
  code <<-EOH
    modprobe gc2035
    modprobe vfe_v4l2
  EOH
  action :nothing
end

package 'motion'

cookbook_file '/etc/default/motion' do
  notifies :restart, 'service[motion]', :delayed
end

template '/etc/motion/motion.conf' do
  variables(
    target_dir: target_dir
  )
  notifies :restart, 'service[motion]', :delayed
end

service 'motion' do
  supports :status => true, :restart => true, :reload => false
  action [:enable, :start]
end
