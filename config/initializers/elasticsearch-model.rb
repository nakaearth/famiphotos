Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: "192.168.25.20", port: 9200,  
  retry_on_failure: true, 
  reload_connection: true, 
  randomize_hosts: true, 
  log: true
)
