class ProductsController < ApplicationController

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)

		respond_to do |format|
			if @product.save
				# flash[:success] = "Product has been added successfully to the database"
				# redirect_to root_url
				format.html { redirect_to @product, notice: 'Product has been added successfully to the database.' }
        		format.json { render :show, status: :created, location: @product }
			else
				format.html { render :new }
        		format.json { render json: @product.errors, status: :unprocessable_entity }
        	end
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])

		# if @product.update_attributes(product_params)
		# 	flash[:success] = "Product has been updated successfully"
		# 	redirect_to root_url
		# else
		# 	render 'edit'
		# end

		respond_to do |format|
	      if @product.update_attributes(product_params)
	        format.html { redirect_to @product, notice: 'Product has been updated successfully.' }
	        format.json { render :show, status: :ok, location: @product }
	      else
	        format.html { render :edit }
	        format.json { render json: @product.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
		@product = Product.find(params[:id])

		if @product.destroy
			flash[:success] = "Product has been deleted successfully"
			redirect_to root_url
		else
			flash[:danger] = "Product can not be deleted"
		end
	end


	private

		def product_params
			params.require(:product).permit(:title, :description, :image, :price)
		end
end
