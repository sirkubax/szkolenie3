# https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ansible-create-complete-vm
#
# az group create --name azu-eu-west --location westeurope

- name: Create Azure VM
  hosts: localhost
  connection: local
  vars:
    eco_azure:
        name: azu-eu-west-ECO
        location: westeurope
        vnet: 
            ip: 172.16.132.0/24
            name: azu-eu-west-eco-vnet
        subnet: 
            ip: 172.16.132.0/24
            name: azu-eu-west-eco-subnet-a
        sg:
          - name: azu-eu-west-eco-FR-sg
            rules:
            - name: SSH
              protocol: Tcp
              destination_port_range: 22
              access: Allow
              priority: 1001
              direction: Inbound
            - name: vpn
              protocol: Udp
              destination_port_range: 1194
              access: Allow
              priority: 1002
              direction: Inbound
          - name: azu-eu-west-eco-backend-sg
            rules:
            - name: SSH
              protocol: Tcp
              destination_port_range: 22
              access: Allow
              priority: 1001
              direction: Inbound
            - name: vpn
              protocol: Udp
              destination_port_range: 1194
              access: Allow
              priority: 1002
              direction: Inbound
          - name: azu-eu-west-eco-sql-sg
            rules:
            - name: SSH
              protocol: Tcp
              destination_port_range: 22
              access: Allow
              priority: 1001
              direction: Inbound
            - name: vpn
              protocol: Udp
              destination_port_range: 1194
              access: Allow
              priority: 1002
              direction: Inbound

        vm:
            - name: azu-eu-west-eco-FE-01
              network_interface:
                  name: azu-eu-west-eco-subnet-a-ni-vpn
              vm_size: Standard_DS1_v2
              username: ubuntu
              data_disks:
                  - lun: 0
                    disk_size_gb: 64
                    managed_disk_type: Premium_LRS
              managed_disk_type: Premium_LRS
              ip_pub_name: azu-eu-west-eco-FE-01-pubIP
              sg: azu-eu-west-eco-FR-sg

#            - name: azu-compute-eco-backend-01
#              network_interface:
#                  name: azu-eu-west-eco-subnet-a-ni-backend-01
#              vm_size: Standard_DS1_v2
#              username: ubuntu
#              managed_disk_type: Premium_LRS
#              ip_pub_name: azu-eu-west-eco-backend-01-pubIP
#              data_disks:
#                  - lun: 0
#                    disk_size_gb: 255
#                    managed_disk_type: Premium_LRS
#
#            - name: azu-compute-eco-sql-01
#              network_interface:
#                  name: azu-eu-west-eco-subnet-a-ni-sql-01
#              vm_size: Standard_DS1_v2
#              username: ubuntu
#              managed_disk_type: Premium_LRS
#              ip_pub_name: azu-eu-west-eco-sql-01-pubIP
#              data_disks:
#                  - lun: 0
#                    disk_size_gb: 255
#                    managed_disk_type: Premium_LRS


  tasks:
  - name: Create virtual network
    azure_rm_virtualnetwork:
      resource_group: "{{ eco_azure.name }}"
      name: "{{ eco_azure.vnet.name }}"
      address_prefixes: "{{ eco_azure.vnet.ip }}"

  - name: Add subnet
    azure_rm_subnet:
      resource_group: "{{ eco_azure.name }}"
      name: "{{ eco_azure.subnet.name }}"
      address_prefix: "{{ eco_azure.subnet.ip }}"
      virtual_network: "{{ eco_azure.vnet.name }}"

  - name: Create Network Security Group that allows SSH
    azure_rm_securitygroup:
      resource_group: "{{ eco_azure.name }}"
      name: "{{ item.name }}"
      rules:
        - name: SSH
          protocol: Tcp
          destination_port_range: 22
          access: Allow
          priority: 1001
          direction: Inbound
        - name: vpn
          protocol: Udp
          destination_port_range: 1194
          access: Allow
          priority: 1002
          direction: Inbound
    with_items: "{{ eco_azure.sg }}"

  - name: Create public IP address
    azure_rm_publicipaddress:
      resource_group: "{{ eco_azure.name }}"
      allocation_method: Static
      name: "{{ item.ip_pub_name }}"
    with_items: "{{ eco_azure.vm }}"

  - name: Create virtual network inteface card
    azure_rm_networkinterface:
      resource_group: "{{ eco_azure.name }}"
      name: "{{ item.network_interface.name }}"
      virtual_network: "{{ eco_azure.vnet.name }}"
      subnet: "{{ eco_azure.subnet.name }}"
      #public_ip: False  # bug that force us to use pub_ip https://github.com/ansible/ansible/issues/36163
      public_ip_name: "{{ item.ip_pub_name }}"
      security_group: "{{ item.sg }}"
    with_items: "{{ eco_azure.vm }}"

  - name: Create VM
    azure_rm_virtualmachine:
      resource_group: "{{ eco_azure.name }}"
      name: "{{ item.name }}"
      vm_size: "{{ item.vm_size }}"
      admin_username: "{{ item.username }}"
      ssh_password_enabled: false
      ssh_public_keys: 
        - path: "/home/{{ item.username }}/.ssh/authorized_keys"
          key_data: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/jpXse+livl1Ih/eBIpZLLdudSrpxlg4oNb+PecRE8ZhznGHIUg6nnoKb06NHxMO0iERpzZyMRtxoajN7CGqp0LF6VHYUHSiEHPuy1tBiYQ24wx4HWeUefUKq8mRz2Bel5gYyGkl4v+8h0OVfcm+42s6kmDpkYP9MdRQ9sZWbLXZhWH7eLzlsayeqSof1zr7JpbpfMHO2RDQP9ESpp2VEKJA1WARGDIZ5Enfp4qNha7cl7yNCQFB3JgkfHa+LEn3yNnz1u5OuwwEiUmtup5+ham6bSUKgjDBtLzogxwDwAtvdcesjK8uRHZHSQ3/9XBpTFDmbxKK9cfMXZOZJgxYN"
      network_interfaces: "{{ item.network_interface.name }}"
      image:
          offer: UbuntuServer
          publisher: Canonical
          sku: 16.04-LTS
          version: latest
      managed_disk_type: "{{ item.managed_disk_type }}"
      data_disks: "{{ item.data_disks }}"
    with_items: "{{ eco_azure.vm }}"

##This works with ansible.devel (version 2.5)
#  - name: Create managed disk
#    azure_rm_managed_disk:
#      name: mymanageddisk
#      location: "{{ eco_azure.location }}"
#      resource_group: "{{ eco_azure.name }}"
#      disk_size_gb: 4
#
#  - name: Mount the managed disk to VM
#    azure_rm_managed_disk:
#      name: mymanageddisk2
#      location: "{{ eco_azure.location }}"
#      resource_group: "{{ eco_azure.name }}"
#      disk_size_gb: 4
#      managed_by: azu-ve104
