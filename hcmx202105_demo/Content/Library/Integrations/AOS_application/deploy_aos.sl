namespace: Integrations.AOS_application
flow:
  name: deploy_aos
  inputs:
    - target_host: 10.7.0.235
    - target_host_username: root
    - target_host_password:
        default: 1Q2w3e4r5t
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 80
        'y': 160
      install_java:
        x: 250
        'y': 143
      install_tomcat:
        x: 429
        'y': 145
      install_aos_application:
        x: 598
        'y': 145
        navigate:
          c6a6b870-0c73-a551-95b5-3e41886588c1:
            targetId: 2599705f-4bec-871e-a894-22eb5f40002d
            port: SUCCESS
    results:
      SUCCESS:
        2599705f-4bec-871e-a894-22eb5f40002d:
          x: 776
          'y': 147
