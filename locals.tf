locals {
  resource_group_name     = "twink-lab"
  resource_group_location = "westeurope"
  admin_user              = "arabadj"
  admin_path              = format("/home/%s/.ssh/authorized_keys", local.admin_user)
  admin_key_data          = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAsQet7FpUFuBylm+JrVxhYkQJlUyeuvxHVLEa3cn37CarrhGmhthr5lSE/2QZnICQ1v+9K1pkznHPJoWhQbFBU4CQ1WzBvcSWjzoPeSgMZm+NT6G+TxK+KuINfVKP5PwxkWYRBBkjTDn404HZYeg4eKo0/j1xQ4JwZIVoqyER/qY/Ipj22ANvnXBVP+vFXXwurb9TnsLnzfc+/eckl7+axtdNTl04npOvo5cZ2RN+g9rth8AZY3pPYq5sjjHyBYssnzyNgri4keXC8Req8XyabfaO6hZ9qrbUjXjCc6OG6AAYk8LxCwI99QAHtWUfd8XblF08vjj+2hMDlxSMKiPEVw== "
}

