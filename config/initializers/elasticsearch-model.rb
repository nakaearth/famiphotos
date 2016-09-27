Elasticsearch::Model.client = Elasticsearch::Client.new(
  # hosts: [ { host: "192.168.25.20", port: 9200 }, { host: "192.168.25.30", port: 9200 }, { host: "192.168.25.40", port: 9200} ],
  hosts: [{ host: "192.168.25.20", port: 9200 }],
  retry_on_failure: true,
  reload_connection: true,
  randomize_hosts: true,
  request_timeout: 10,
  reload_connections: 500,
  sniffer_timeout: 3,
  reload_on_failure: true,
  log: true
)
