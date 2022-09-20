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
  - script_deploy_war: 'http://k8s-master.modeloffice.org:30004/repository/tools/chef/bootstrap/install.sh'
  - script_install_java: 'http://k8s-master.modeloffice.org:30004/repository/AOS-build/AOS/AOS-HCMX-100-PIPELINE-hcm-cdf-rc1/hcm-cdf/hcmx/install_java.sh'
  - script_install_postgres: 'http://k8s-master.modeloffice.org:30004/repository/AOS-build/AOS/AOS-HCMX-100-PIPELINE-hcm-cdf-rc1/hcm-cdf/hcmx/install_postgres.sh'
  - script_install_tomcat: 'http://k8s-master.modeloffice.org:30004/repository/AOS-build/AOS/AOS-HCMX-100-PIPELINE-hcm-cdf-rc1/hcm-cdf/hcmx/install_tomcat.sh'
  - war_repo_root_url: 'http://k8s-master.modeloffice.org:30004/repository/AOS-build/AOS/AOS-HCMX-100-PIPELINE-hcm-cdf-rc1/'
  - script_retries: '5'
  - artifact_base_url: 'http://k8s-master.modeloffice.org:30004/repository/AOS-build/AOS/'
