class BooksController < ApplicationController

	before_action :authenticate_user!


	before_action :correct_user, only: [:edit, :update ,:destroy]

	def create
	  @book = Book.new(book_params)
	  @book.user_id = current_user.id
	  if @book.save
	    redirect_to book_path(@book.id), :notice => "You have creatad book successfully."
	  else
	  	@books = Book.all
	    render :index
	  end

	end

	def index
	 @book = Book.new
	 @books = Book.all
	 @user = current_user
	end

	def show
      @book_show = Book.find(params[:id])
	  @book = Book.new
	  @user = @book_show.user
	end


	def edit
	  @book_show = Book.find(params[:id])
	end

	def update
	  @book_show = Book.find(params[:id])
	  if @book_show.update(book_params)
	  redirect_to book_path(@book_show.id), :notice => "You have updated book successfully."
	  else
	  	render :edit
	  end
	end

	def destroy
      @book_show = Book.find(params[:id])
      @book_show.destroy
      redirect_to books_path
	end

    private
    def book_params
      params.require(:book).permit(:title, :body, :user_id)
    end
    def correct_user
    	@book_show = Book.find(params[:id])
    	if current_user != @book_show.user
    	   redirect_to books_path
    	end
    end

end
