namespace: Demo
operation:
  name: print
  python_action:
    use_jython: false
    script: |-
      # do not remove the execute function
      def execute():
          # code goes here
      # you can add additional helper methods below.
      printf "Good Afternoon"
  results:
    - SUCCESS
