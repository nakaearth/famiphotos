require 'ridgepole'
Rails.application.config.watchable_files.push(Rails.root.join('db/Schemafile').to_s)
