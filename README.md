# orangepi-one

Chef cookbooks to configure an OrangePI One

## Prerequisites

- Orange PI One
- Ubuntu Xenial server Armbian image from http://mirror.igorpecovnik.com/Armbian_5.14_Orangepione_Ubuntu_xenial_3.4.112.7z
- git
- ruby
- ruby-dev
- chef

```
sudo apt-get install git ruby ruby-dev
sudo gem install -N chef
```

## Usage

Switch to `root`

```
sudo su -
```

Recursively clone the repo

```
git clone --recursive https://github.com/pghalliday-cookbooks/orangepi-one.git
cd orangepi-one
```

Copy `attributes.example.json` to `attributes.json`

```
cp attributes.example.json attributes.json
```

Set the options for your environment if they differ.

```json
{
  "orangepi_one": {
    "password": "<PASSWORD_HASH>",
    "authorized_keys": [
      "<AUTHORIZED_KEY>",
      ...
    ],
    "ethernet": {
      "interface": "<INTERFACE_NAME>"
    },
    "wlan": {
      "interface": "<INTERFACE_NAME>",
      "wpa_options": {
        ssid: "<ESSID>",
        psk: "<PASS_PHRASE>",
        ...
      }
    }
  },
  "run_list": [
    "recipe[orangepi_one::default]"
  ]
}
```

Password hashes can be created with the following command

```
openssl passwd -1 "theplaintextpassword"
```

Provision the machine.

```
chef-client -c client.rb
```

Update `attributes.json` and rerun `chef-client` as needed
