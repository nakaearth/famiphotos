module Search
  class CreateIndexUsecase
    def execute
      # ここからinfrastureのcreate_index処理を呼ぶ
      ElasticsearchIndexGateway.create_index(Consts::Elasticsearch[:index_name][:album])
    end
  end
end
