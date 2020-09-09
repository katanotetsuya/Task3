class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
  	@books = Book.all
  	@book = Book.new
  end

  def show
    # @books = Book.all
    # @user = User.find(params[:id])
    # @book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
      flash[:notice] = 'You have creatad book successfully.'
  		redirect_to book_path(@book)
  	else
  		@books = Book.all
  		@user = User.find(current_user.id)
  		render "index"
  	end
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user.id != @user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
