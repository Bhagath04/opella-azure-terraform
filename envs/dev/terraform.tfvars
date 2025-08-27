project      = "opella"
environment  = "dev"
location     = "eastus"
address_space= ["10.10.0.0/16"]
subnets = {
  app = {
    address_prefixes = ["10.10.1.0/24"]
    nsg_enabled      = true
  }
  data = {
    address_prefixes = ["10.10.2.0/24"]
    nsg_enabled      = false
  }
}
vm_admin_username = "azureuser"
# paste your ~/.ssh/id_rsa.pub or similar
vm_admin_ssh_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC26Vgny+76bHUxbHcOCDsadbteduN4Dgiue+i2VYGp5cdYs9LDVmfvM866msbfIPPvmRzyeJqg2m0/bp2xI0GzlLQRIh0CI7gNnDRazn6XhyHV2uZsj+ee9mWKl/Hb5+fPGeYZuXIFvcP8tltDlWSOmzF+TXj2NOtSMuu6F2fE+vXhp+l8OrrxwAC4VUuM1Qiov49+HfRwrZ9zoajVaqgwwgIF5evx/4PBDdpCJeMM4EnMAbp4VTqSxMdF4Kgt+htVWNzscKnPHfaKQNpqLwb7ePAXEa1NrlrMFN+DN23mgLm9MotueHC5eJsU9ae/Whc4d1/CMu38Dme+AXcBY1lyb9eaTbGBcFA4dg2rm8jl2EQEbbIIeNwYHIItLQd4HzVhFfatCgjAZalIlAzZ6a+nVrWtu1c3Sk1xrv4OoPl/nZWaXHzdkoJVC1KpYIXHkioTzYhBzxCwQmlVc6xgkOIzNLlu3Gh/B0itHsRNX1vMlTWMBUJNHyR2b7v2O3xpHdBBiM36CMv3mvCBvhivHLANFkQ2wDGrWdY4+hPbEXI9mZeRoXxD+mXoQVQ3wDagJztXhpiFnazDTl44wVnGBWzcfW/vGzFGjMSICdDxXvsIiPnmmAK8gMVRk/76AGaWqzGlHgNTApygZ4YGhe3EgitrI7RW5HKSfy8Ao+CAWxiWVw== bhag@SandboxHost-638918612512529424"
