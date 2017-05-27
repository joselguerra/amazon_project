class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def create

     @product = Product.new(product_params)
     @product.user = current_user
     if @product.save
       # redirect_to question_path({ id: @question.id })
       # redirect_to question_path({ id: @question })
       flash[:notice] = 'Product created'
       redirect_to product_path(@product)
     else
       # this will render the `app/views/questions/new.html.erb` to show the form
       # again (with errors). The default behaviour is to render `create.html.erb`
       flash.now[:alert] = 'Please fix errors below'
       render :new
     end
  end

  def show
    @review = Review.new
    @reviews = @product.reviews.order(created_at: :desc)
    # @product = Product.find params[:id]
  end

def index
  @products = Product.all
end

 def edit
    # @product = Product.find params[:id]
  end

  def update
      # @product = Product.find params[:id]
      if @product.update(product_params)
        redirect_to product_path(@product), notice: 'Product updated'
      else
        render :edit
      end
  end

    def destroy
      @product.destroy
      redirect_to products_path, notice: 'Product deleted'
      # q = Product.find params[:id]
      # q.destroy
      # redirect_to products_path
    end

    private

    def product_params
      params.require(:product).permit([:title, :description, :price])
    end

    def find_product
      @product = Product.find params[:id]
    end

end
