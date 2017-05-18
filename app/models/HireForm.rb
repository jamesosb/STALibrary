class HireForm

  include ActiveModel::Model

  attr_accessor :hires, :children, :books


  def save
    if valid?
      @hire = Hire.new(hire_params)
      @child_1 = @hire.create(child_id: params[:child_1_id])
      @child_2 = @hire.child.create(id: params[:child_2_id])
      @book = @hire.book.create(id: params[:book_id])
    end
  end

end
