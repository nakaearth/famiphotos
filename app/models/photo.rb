class Photo < ActiveRecord::Base
  include IdEncryptable
  include Searchable

  use_switch_point :famiphoto

  belongs_to :user

  validates :description, length: { maximum: 140 }
  validates_attachment :photo,  content_type: { content_type: ["image/jpg",  "image/jpeg",  "image/png",  "image/gif"] }
  validates_attachment_size :photo , :in =>1..5.megabyte, :message=>'ファイルサイズが大きすぎます' 

  if Rails.env.production? 
    has_attached_file :photo,  styles: { medium: "300x300>",  thumb: "100x100>" }
    # has_attached_file :photo,
    #   :storage => :s3,
    #   :s3_credentials=>S3_CREDENTIALS,
    #   :styles => { :medium => "350x350>", :thumb => "100x100>",:original=>"700x700>"},
    #   :url => ":s3_domain_url",
    #   :path=>"photos/:id/:style/:filename"
  else 
    has_attached_file :photo,
      :url=>"/system/img/attaches/:id/:style/:filename",
      :path=>"photos/:id/:style/:filename",
      :styles => { :medium => "350x350>", :thumb => "100x100>",:original=>"700x700>" }
  end
end
