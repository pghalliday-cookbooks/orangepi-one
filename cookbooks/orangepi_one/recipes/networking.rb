ethernet_interfaces = node['orangepi_one']['ethernet']['interfaces']
wlan_interfaces = node['orangepi_one']['wlan']['interfaces']

# configure networking
template '/etc/network/interfaces' do
  variables(
    ethernet_interfaces: ethernet_interfaces,
    wlan_interfaces: wlan_interfaces
  )
  force_unlink true
  manage_symlink_source false
  notifies :run, 'bash[restart_network]', :delayed
end

bash 'restart_network' do
  code <<-EOH
  ifdown -a
  ifup -a
  EOH
  action :nothing
end
