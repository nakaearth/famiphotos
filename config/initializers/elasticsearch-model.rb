Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: "localhost", port: 9200,  
  retry_on_failure: true, 
  reload_connection: true, 
  randomize_hosts: true, 
  log: true
)
