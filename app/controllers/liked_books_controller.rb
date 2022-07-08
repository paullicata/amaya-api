class LikedBooksController < ApplicationController
  before_action :set_liked_book, only: [:show, :update, :destroy]

  skip_before_action :authenticate_user!
  # GET /liked_books
  def index
    @liked_books = LikedBook.all

    render json: @liked_books
  end

  # GET /liked_books/1
  def show
    render json: @liked_book
  end

  # POST /liked_books
  def create
    @liked_book = LikedBook.new(liked_book_params)

    if @liked_book.save
      render json: @liked_book, status: :created, location: @liked_book
    else
      render json: @liked_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /liked_books/1
  def update
    if !liked_book_params.empty? && @liked_book.update(liked_book_params)
      render json: @liked_book
    else
      render json: @liked_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /liked_books/1
  def destroy
    @liked_book.destroy
  end

  private

  def set_liked_book
    @liked_book = LikedBook.find(params[:id])
  end

    # Only allow a trusted parameter "white list" through.
  def liked_book_params
    params.require(:liked_book).permit(:user_id, :book_id)
  end

end
