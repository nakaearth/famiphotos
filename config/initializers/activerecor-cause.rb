# デフォルトのログ出力を上がいて、fluentdに食わせるのを出力しているので
# このログは出力されない・・・。
ActiveRecord::Cause.match_paths = [Regexp.new(Rails.root.join("lib").to_s)]
ActiveRecord::Cause.log_with_sql = true # default is false
ActiveRecord::Cause.log_mode = :all # default is :single
