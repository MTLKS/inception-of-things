# inception-of-things

just learning kubernetes

## descriptions

### p1

use vagrant to provision 2 virtual machines  
install kubernetes on both using k3s: one server, one agent

### p2

builds on p1  
only required to provision 1 virtual machine  
deploy sample application onto kubernetes after installation

### p2-nginx

side-tracked from p2 and installed ingress-nginx before realizing traefik is the default for k3s  
keeping it here just because

### p3

install kubernetes using k3d instead  
install argocd on kubernetes  
deploy sample applications from github using argocd

### bonus

builds on p3  
install gitlab on the vm  
deploy sample application from gitlab instead of github using argocd

## setup

prerequisite setup steps needed to be done on the local machine  
specific for nixos, btw

1.  add to configuration.nix

    ```
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "mtlks" ];

    networking.hosts = {
        "192.168.56.110" = [ "app1.com" "app2.com" "app3.com" "example.com" "argocd.example.com" "gitlab.example.com" ]
    }
    ```

2.  restart machine

    error:
    ```
    The virtual machine 'name' has terminated unexpectedly during startup with exit code 1 (0x1).

    Result Code: NS_ERROR_FAILURE (0x80004005)
    ```

    fix: restart after virtualbox install.

3.  remove kvm modules

    error:
    ```
    VirtualBox can't enable the AMD-V extension. Please disable the KVM kernel extension, recompile your kernel and reboot (VERR_SVM_IN_USE).
    Result Code: NS_ERROR_FAILURE (0x80004005)
    ```

    fix:
    ```
    lsmod | grep kvm
    sudo rmmod kvm_amd kvm
    ```

4.  run nix-shell with shell.nix
