Elasticsearch::Model.client = Elasticsearch::Client.new(
  hosts: [ { host: "192.168.25.20", port: 9200 }, { host: "192.168.25.30", port: 9200 }, { host: "192.168.25.40", port: 9200} ],  
  retry_on_failure: false, 
  reload_connection: true, 
  randomize_hosts: true, 
  log: true
)
