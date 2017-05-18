class Book < ActiveRecord::Base

  has_attached_file :bookimg, styles: { large: "500x500>", medium: "300x300>", small: "192x192" ,thumb: "100x100>" },
                    default_url: "/images/:style/missing.png",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => "stalib",
                    :path => "/:style/:id/:filename"


  validates_attachment_content_type :bookimg, content_type: /\Aimage\/.*\Z/
  validates_presence_of :title
  has_many :hires, dependent: :destroy
  has_many :children, through: :hires
  belongs_to :genres
end
