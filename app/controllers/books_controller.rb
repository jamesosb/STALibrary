class BooksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.order(:title).page(params[:page]).per(10)

    @bookletters = Book.order(:title)
    lettersarray = Array.new
    @bookletters.each do |x|
      lettersarray.push x.title[0].to_s
    end
    @bookletters = lettersarray.uniq

    @children = Child.order(:nickname)
    @genres = Genre.order(:name)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  def index_by_letter

    @bookletters = Book.order(:title)
    lettersarray = Array.new
    @bookletters.each do |x|
      lettersarray.push x.title[0].to_s
    end
    @bookletters = lettersarray.uniq


  @children = Child.order(:nickname)
  @genres = Genre.order(:name)

  @cletter = params[:letter]

  @books = Book.where('substr(title, 1, 1) = ?', params[:letter]).order(:title).page(params[:page]).per(50)

    respond_to do |format|
      format.html
      format.js.coffee
    end
  end

  # GET /books/new
  def new
    @book = Book.new

  end

  # GET /books/checkin
  def checkin
    @books = Book.all
  end

  # GET /books/editall
  def editall
    @books = Book.all
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :genre_id, :ISBN, :bookimg)
    end
end
