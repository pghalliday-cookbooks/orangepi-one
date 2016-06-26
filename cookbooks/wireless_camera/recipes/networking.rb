ethernet_interface = node['wireless_camera']['ethernet']['interface']
wlan_interface = node['wireless_camera']['wlan']['interface']
wpa_options = node['wireless_camera']['wlan']['wpa_options']

package 'wpasupplicant'

# configure networking
template '/etc/network/interfaces' do
  variables(
    ethernet_interface: ethernet_interface,
    wlan_interface: wlan_interface,
    wpa_options: wpa_options
  )
  force_unlink true
  manage_symlink_source false
  notifies :run, 'bash[restart_network]', :delayed
end

link '/etc/resolv.conf' do
  to '/run/resolvconf/resolv.conf'
  notifies :run, 'bash[restart_network]', :delayed
end

bash 'restart_network' do
  code <<-EOH
  ifdown -a
  ifup -a
  EOH
  action :nothing
end
