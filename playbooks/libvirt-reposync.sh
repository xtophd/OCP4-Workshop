## Authors: 
##   Christoph Doerbeck
##
## Summary:
##
##   TBD 

#---
#- hosts: myVirthost
#
#  vars_files:
#  - vars/libvirt-parms.yml
#
#  tasks:
#
#  - name: "LIBVIRT-SETUP: use rhsm to disable all repos"
#    shell: subscription-manager repos --disable=* 
#
#  - name: "Subscription Manager enable specified repos only"
#    rhsm_repository: 
#      name: "{{ item }}"
#      purge: True
#    loop: "{{ g_repoList }}"

#  - name: "SHELL: disable libvirt 'default' network"
#    shell:
#      cmd: |
#        if `virsh net-list | grep -q default` ; then 
#          virsh net-destroy default
#          virsh net-autostart --network default --disable
#        fi
#
#  - name: "SERVICE: restart service libvirtd"
#    service: name=libvirtd state=restarted enabled=yes masked=no

## For RHEL 8 (ansible 2.5)
#  - name: "Subscription Manager enable specified repos only"
#    rhsm_repository: 
#      name: "{{ item }}"
#      purge: True
#      state: enabled

#  - name: "Clone repos"
#    when: g_repoSync == "True"
#    shell: reposync --newest-only --destdir={{ g_repoDestDir }} --repoid={{ item }}
#    loop: "{{ g_repoList }}"
# 
#  - name: "Create sample repo configs"
#    when: g_repoSync == "True"
#    template:
#      src: "repo-config.j2"
#      dest: "{{ g_repoDestDir }}/{{ item }}.repo"
#      owner: root
#      group: root
#      mode: 0444
#    loop: "{{ g_repoList }}"
#
#  - name: "SELinux restore contexts"
#    when: g_repoSync == "True"
#    shell: restorecon -R {{ g_repoDestDir }}


#  - name: "Subscription Manager enable specified repos only"
#    rhsm_repository: 
#      name: "{{ g_repoList }}" 
#      purge: True
#
#  - name: "Clone repos"
#    when: g_repoSync == "True"
#    shell: reposync --newest-only --destdir={{ g_repoDestDir }} --repoid={{ item }}
#    loop: "{{ g_repoList }}"
# 
#  - name: "Create sample repo configs"
#    when: g_repoSync == "True"
#    template:
#      src: "repo-config.j2"
#      dest: "{{ g_repoDestDir }}/{{ item }}.repo"
#      owner: root
#      group: root
#      mode: 0444
#    loop: "{{ g_repoList }}"
#
#  - name: "SELinux restore contexts"
#    when: g_repoSync == "True"
#    shell: restorecon -R {{ g_repoDestDir }}

