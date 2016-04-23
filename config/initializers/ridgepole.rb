require 'ridgepole'
Rails.application.config.watchable_files.push(Rails.root.join('db/schemas/Schemafile').to_s)
