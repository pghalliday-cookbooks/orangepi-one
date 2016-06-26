login_group = node['orangepi_one']['group']
login_user = node['orangepi_one']['user']
login_home = node['orangepi_one']['home']
login_password = node['orangepi_one']['password']
authorized_keys = node['orangepi_one']['authorized_keys']

ssh_dir = ::File.join login_home, '.ssh'
authorized_keys_file = ::File.join ssh_dir, 'authorized_keys'
sudoers = ::File.join '/etc/sudoers.d', login_user

%w(
  openssh-server
).each do |package_name|
  package package_name
end

group login_group

user login_user do
  shell '/bin/bash'
  password login_password
  home login_home
  gid login_group
  manage_home true
end

directory ssh_dir do
  owner login_user
  group login_group
  mode 0700
end

file authorized_keys_file do
  owner login_user
  group login_group
  mode 0600
  content authorized_keys.join("\n")
end

# add to sudoers with no password
template sudoers do
  source 'sudoers.erb'
  mode 0440
  variables(
    user: login_user
  )
end
