class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  skip_before_action :authenticate_user!
  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if !book_params.empty? && @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  def show_user_likes
    #@books = Book.joins(liked_books: :users).where('users.id = ?', params[:user_id])

    @books = Book.joins('INNER JOIN liked_books ON liked_books.book_id = books.id
                         INNER JOIN users ON users.id = liked_books.user_id')
                 .where('users.id = ?', params[:user_id])

    render json: @books
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def book_params
    params.require(:book).permit(:author_id, :title, :grade_level, :copyright, :genre, :description, :cover)
  end
end
