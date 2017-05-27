class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, only: [:destroy]

    def create
      @product = Product.find params[:product_id]

      @review = Review.new review_params
      @review.product = @product
      @review.user = current_user
      if @review.save
        redirect_to product_path(@product), notice: 'Review Created!'
      else
        render 'products/show'
      end
    end

    def destroy
      @product = @review.product
      # @question = Question.find param[:question_id]
      @review.destroy
      redirect_to product_path(@product), notice: 'Review Deleted!'
    end

    private

    def find_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:body, :rating)
    end

end
