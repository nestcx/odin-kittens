class KittensController < ApplicationController
	def index
		@kittens = Kitten.all
		respond_to do |format|
			format.html
			format.json { render :json => @kittens }
		end
	end
	#response = RestClient.get("http://localhost:3001/kittens", :accept => :json)

	def show
		@kitten = Kitten.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render :json => @kitten }
		end
	end
	#response = RestClient.get("http://localhost:3001/kittens/4", :accept => :json)

	def new
		@kitten = Kitten.new
	end

	def create
		@kitten = Kitten.new(kitten_params)
		if @kitten.save
			flash[:success] = "You created a kitten!"
			redirect_to @kitten
		else
			flash[:danger] = "Error creating kitten"
			render 'new'
		end
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end

	def update
		@kitten = Kitten.find(params[:id])
		if @kitten.update_attributes(kitten_params)
			flash[:success] = "Successfully edited!"
			redirect_to @kitten
		else
			flash[:danger] = "Error editing kitten"
			render 'edit'
		end
	end

	def destroy
		@kitten = Kitten.find(params[:id]).destroy
		flash[:success] = "Kitten destroyed"
		redirect_to kittens_path
	end 

	private

	def kitten_params
		params.require(:kitten).permit(:name, :age, :cuteness, :softness)
	end
end