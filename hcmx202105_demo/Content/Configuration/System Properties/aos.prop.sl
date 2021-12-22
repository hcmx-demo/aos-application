namespace: ''
properties:
  - script_location: /tmp
  - vcenter_host: 172.16.239.19
  - vcenter_user: "vsphere.local\\\\administrator"
  - vcenter_password:
      value: Cloudywind@1234
      sensitive: false
  - vcenter_image: linux-template
  - vcenter_datacenter: CAPA1 Datacenter
  - vcenter_folder: AOS
  - vm_username: root
  - vm_password:
      value: Cloud_1234
      sensitive: false
  - script_deploy_war: 'http://smax.modeloffice.org:32000/nexus/service/local/repositories/aos/content/deploy_war.sh'
  - script_install_java: 'http://smax.modeloffice.org:32000/nexus/service/local/repositories/aos/content/install_java.sh'
  - script_install_postgres: 'http://smax.modeloffice.org:32000/nexus/service/local/repositories/aos/content/install_postgres.sh'
  - script_install_tomcat: 'http://smax.modeloffice.org:32000/nexus/service/local/repositories/aos/content/install_tomcat.sh'
  - war_repo_root_url: 'http://smax.modeloffice.org:32000/nexus/service/local/repositories/aos/content/'
  - script_retries: '5'
