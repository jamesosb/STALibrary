class Hire < ActiveRecord::Base
  paginates_per 20
  after_save { |hire| hire.destroy if hire.book_id.blank? }


  belongs_to :book
  belongs_to :child
  accepts_nested_attributes_for :book
  accepts_nested_attributes_for :child

  #include PgSearch
  #multisearchable :against => [:child_forename]

  #def child_forename
  #  child.forename
  #end

end
