#!/usr/bin/env python3

'''
Dynamic inventory that loads nodes from the Terraform variables for future
playbooks. Adapted from: 

https://www.jeffgeerling.com/blog/creating-custom-dynamic-inventories-ansible
'''

import os
import sys
import argparse
import yaml

try:
    import json
except ImportError:
    import simplejson as json

class TerraformInventory(object):

    def __init__(self):
        self.inventory = {'terraform': {'hosts': ['localhost'], 'vars': {}}}
        self.read_cli_args()
        self._load_config()
        print(json.dumps(self.inventory))

    # Read the command line args passed to the script.
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action='store_true')
        parser.add_argument('--host', action='store')
        parser.add_argument('--config',
                            action='store',
                            default='./group_vars/terraform.yml')
        self.args = parser.parse_args()
    
    def _load_config(self):
        with open(self.args.config) as f:
            dataMap = yaml.safe_load(f)
        for node in dataMap['nodes']:
            for group in node['groups']:
                if group not in self.inventory:
                    self.inventory[group] = {'hosts': [], 'vars': {}}
                
                for i in range(node['count']):
                    self.inventory[group]['hosts'].append(node['prefix'] + node['name'] + '-' + str(i))

# Get the inventory.
TerraformInventory()