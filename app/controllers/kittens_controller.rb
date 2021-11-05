class KittensController < ApplicationController

    def index
        @kittens = Kitten.all

        respond_to do |format|
            format.html
            format.json { render :json => @kittens }
        end
    end

    def show
        @kitten = Kitten.find(params[:id])

        respond_to do |format|
            format.html
            format.json { render :json => @kitten }
        end
    end

    def new
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.new(kitten_params)

        if @kitten.save
            flash[:success] = "You successfully added a kitten. D'aww."
            redirect_to kitten_path(@kitten.id)
        else
            flash[:error] = "You filled out your form improperly. Womp womp."
            render :new
        end
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def update
        @kitten = Kitten.find(params[:id])

        if @kitten.update(kitten_params)
            flash[:success] = "Kitten successfully updated."
            redirect_to kitten_path(@kitten.id)
        else
            flash.now[:error] = "You have failed to update the kitten."
            render :edit
        end

    end

    def destroy
        @kitten = Kitten.find(params[:id])
        if @kitten.destroy
            flash[:success] = "Kitten deleted."
            redirect_to root_path
        else
            flash.now[:error] = "Kitten not deleted."
            render :show
        end
    end

    private

    def kitten_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softeness)
    end
end
