class Child < ActiveRecord::Base
  paginates_per 20
  has_attached_file :childimg, styles: { large: "500x500>", medium: "300x300>", small: "192x192" ,thumb: "100x100>" },
                    default_url: "/images/:style/missing.png",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => "stalib",
                    :path => "/:style/:id/:filename"

  validates_attachment_content_type :childimg, content_type: /\Aimage\/.*\Z/
  validates_presence_of :classroom, :nickname

  has_many :hires, dependent: :destroy
  has_many :books, through: :hires

  include PgSearch
  multisearchable :against => [:forename]
  PgSearch.multisearch_options = {
      :using => {:tsearch => {:prefix => true}
      }
  }


#  def child_forename
#    child.forename
#  end

end
