class HiresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_hire, only: [:show, :edit, :update, :destroy]



  # GET /hires
  # GET /hires.json
  def index
    @hires = Hire.order(created_at: :desc).page(params[:page]).per(10)

  end

  # GET /hires/1
  # GET /hires/1.json
  def show
  end

  # GET /hires/new
  def new

    #@hireform = HireForm.new

    @checkedout = Hire.where('checkedin IS ?', nil)
    job = Array.new
    @checkedout.each do |x|
    job.push x.book_id.to_s
    end
    @job = job


    @books = Book.where('id NOT IN (?)', @job << 0).order(:title)
    @children = Child.where("class_year = ? or class_year = ?" , "2016", "2017").order(:forename)
    @genres = Genre.order(name: :desc )
    @bookscount = @books.count

      shortgenres = Array.new


    @books.each do |x|
      shortgenres.push x.genre_id.to_s
    end

    @shortgenres = shortgenres

    @limitedgenres = Genre.find(@shortgenres)
    @limitedgenres.sort_by! &:name


    @hire = Hire.new


  end

  # GET /hires/1/edit
  def edit
  end

  def from_class

    @classroom = params[:classroom]
    @selected_children = Child.where('classroom = ? AND class_year = ? OR classroom = ? AND class_year = ? ' , @classroom , "2016", @classroom , "2017").order(:forename)

    respond_to do |format|
      format.js.coffee
    end
  end


  def from_category

    @cid = params[:carousel_id]
    @genreparams = "genre"+@cid
    @selected = Book.where(:genre_id => params[@genreparams][:genre_id]).order(:title)

    respond_to do |format|
      format.js.coffee
    end
  end

  def search_checkin

    @istextsearch = params[:is_text_search]

    if params[:is_text_search] == 'yes'

    @search_term = params[:search_hires]

    @search = PgSearch.multisearch(@search_term.to_s).where(:searchable_type => "Child")

    find_search_array = Array.new
    @search.each do |x|
      find_search_array.push x.searchable_id.to_s
    end

    @search = find_search_array

    @children = Kaminari.paginate_array(Child.where("id = ?", @search)).page(params[:page]).per(20)

    else

      @search_term = params[:letter]


      #FIND A LIST ALL CHECKED OUT BOOKS

      @checkedout = Hire.where('checkedin IS ?', nil)

      #PUT ALL THE CHILD ID'S IN AN ARRAY

      childcheck = Array.new
      @checkedout.each do |x|
        childcheck.push x.child_id.to_s
      end


      #FIND ALL THE CHILDREN WITH THE RIGHT LETTER

      searchletters = @search_term

      searchlettersarray = Array.new

      searchletters.each_byte { |b|
        searchlettersarray.push b.chr + "%"
      }

      @childrenwithletters =  Child.where("forename ILIKE ANY ( array[?] )", searchlettersarray).to_a

      childlettersarray = Array.new
      @childrenwithletters.each do |x|
        childlettersarray.push x.id.to_s
      end

      @dedupchildren = childcheck & childlettersarray

      @children = Child.where("id IN (?)", @dedupchildren).to_a
      @children = Kaminari.paginate_array(@children.sort_by! &:forename).page(params[:page]).per(20)

    end




    @childcount = @children.count

    respond_to do |format|
      format.js.coffee
    end
  end

  def checkin

    @checkedout = Hire.where('checkedin IS ?', nil)

    childcheck = Array.new
    @checkedout.each do |x|
      childcheck.push x.child_id.to_s
    end
    @childcheck = childcheck

    @childletters = Child.order(:forename)
    lettersarray = Array.new
    @childletters.each do |x|
      lettersarray.push x.forename[0].to_s
    end
    @childletters = lettersarray.uniq

   @children = Child.find(@childcheck)

    @children = Kaminari.paginate_array(@children.sort_by! &:forename).page(params[:page]).per(5)

    @sub_hire = Hire.where("child_id = ?", params[:child]).order(created_at: :desc)
  end


  # POST /hires
  # POST /hires.json
  def create

    #hire_params.each_with_index do |x,i|

    x = hire_params

        hire_params1 = x['hire_attributes']['1']
        hire_params2 = x['hire_attributes']['2']

     #   logger.debug "THISTHISTHISTHISTHISTHIS11 #{hire_params1}"
     #   logger.debug "THISTHISTHISTHISTHISTHIS22 #{hire_params2}"
    #end

    @hire = Hire.new(hire_params1)
    @hire2 = Hire.new(hire_params2)

    respond_to do |format|
      if @hire.save and @hire2.save
        format.html { redirect_to child_path(@hire.child_id), notice: "You hired some books! You're great!" }
        format.json { render :show, status: :created, location: @hire }
      else
        format.html { render :new }
        format.json { render json: @hire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hires/1
  # PATCH/PUT /hires/1.json
  def update

    @bookid = params[:id]
    @childid = params[:hire][:childid]

    respond_to do |format|
      if @hire.update(hire_params)
        format.html { redirect_to @hire, notice: "Updated! Nice work." }
        format.js.coffee { }
        format.json { render :show, status: :ok, location: @hire }
      else
        format.html { render :edit }
        format.json { render json: @hire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hires/1
  # DELETE /hires/1.json
  def destroy
    @hire.destroy
    respond_to do |format|
      format.html { redirect_to hires_url, notice: 'Deleted, thanks' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hire
      @hire = Hire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hire_params
      params.require(:hire).permit(:child_id, :book_id, :hire ,:checkedin, hire_attributes: [ :child_id, :id, :book_id, :_destroy])
    end
end
