version: 1
config:
- type: physical
  name: ${network_interface}
  subnets:
    - type: static
      address: ${ip_address}
      gateway: ${gateway}