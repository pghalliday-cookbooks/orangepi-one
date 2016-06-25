# get latest git
apt_repository 'git' do
  uri 'ppa:git-core/ppa'
  distribution node['lsb']['codename']
end

# install packages
%w(
  tmux
  vim
  git
  wget
  curl
).each do |name|
  package name do
    action :upgrade
  end
end
