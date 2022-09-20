namespace: Integrations.demo.aos.sub_flows
flow:
  name: retry_initialize_artifact
  inputs:
    - host
    - username
    - password
    - artifact_url:
        required: false
    - script_url
    - parameters:
        required: false
  workflow:
    - no_artifact_given:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${artifact_url}'
            - second_string: ''
        publish: []
        navigate:
          - SUCCESS: copy_script
          - FAILURE: copy_artifact
    - copy_artifact:
        do:
          io.cloudslang.demo.aos.sub_flows.remote_copy:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - url: '${artifact_url}'
        publish:
          - artifact_name: '${filename}'
        navigate:
          - SUCCESS: copy_script
          - FAILURE: on_failure
    - copy_script:
        do:
          io.cloudslang.demo.aos.sub_flows.remote_copy:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - url: '${script_url}'
        publish:
          - script_name: '${filename}'
        navigate:
          - SUCCESS: no_artifact_given_1
          - FAILURE: on_failure
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && sh '+deploy_war.sh+' '+get('artifact_name', '')+' '+get('parameters', '')+' > deploy_war.sh.log'}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - timeout: '300000'
        publish:
          - command_return_code
        navigate:
          - SUCCESS: delete_script
          - FAILURE: delete_script
    - delete_script:
        do:
          io.cloudslang.demo.aos.tools.delete_file:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - filename: '${script_name}'
        navigate:
          - SUCCESS: has_succeeded
          - FAILURE: on_failure
    - has_succeeded:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: "${str(command_return_code == '0')}"
        navigate:
          - 'TRUE': SUCCESS
          - 'FALSE': FAILURE
    - no_artifact_given_1:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${script_name}'
            - second_string: postgres.tgz
        publish: []
        navigate:
          - SUCCESS: ssh_command_1
          - FAILURE: no_artifact_given_1_1
    - ssh_command_1:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && sh test.sh '+get('artifact_name', '')+' '+get('parameters', '')+' > '+script_name+'.log'}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
            - timeout: '300000'
        publish:
          - command_return_code
        navigate:
          - SUCCESS: delete_script
          - FAILURE: delete_script
    - no_artifact_given_1_1:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${script_name}'
            - second_string: tomcat
        publish: []
        navigate:
          - SUCCESS: ssh_command_1
          - FAILURE: ssh_command
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      no_artifact_given_1:
        x: 40
        'y': 280
      ssh_command_1:
        x: 40
        'y': 480
      no_artifact_given:
        x: 257
        'y': 6
      no_artifact_given_1_1:
        x: 280
        'y': 280
      ssh_command:
        x: 480
        'y': 280
      copy_script:
        x: 400
        'y': 160
      has_succeeded:
        x: 800
        'y': 320
        navigate:
          b431cef2-32c1-cf2c-3a35-95bf6f12829c:
            targetId: 4012d319-d667-dea9-65f4-2b24e29f9ae5
            port: 'TRUE'
          2c35bbd5-b4ec-37c2-3bde-b1b949f6aeb2:
            targetId: 8f9aa1a2-b5b4-6a09-5bdb-9fb94e9ab2e0
            port: 'FALSE'
      copy_artifact:
        x: 49
        'y': 160
      delete_script:
        x: 600
        'y': 440
    results:
      FAILURE:
        8f9aa1a2-b5b4-6a09-5bdb-9fb94e9ab2e0:
          x: 960
          'y': 240
      SUCCESS:
        4012d319-d667-dea9-65f4-2b24e29f9ae5:
          x: 960
          'y': 480
