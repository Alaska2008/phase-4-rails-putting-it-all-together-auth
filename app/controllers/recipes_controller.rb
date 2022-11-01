class RecipesController < ApplicationController
    before_action :authorized
    def index
        recipes = Recipe.all
        render json: recipes, includes: "users", status: :created
    end

    def create
        recipe = Recipe.create(recipe_params)
        if  recipe.valid?
            render json: recipe, includes: "users", status: :created
        else
            render json: recipe.errors.full_messages, status: :unprocessable_entity
        end

    end

    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end

    def authorized
        return render json: {error: "Not Authorized"}, status: :unauthorized unless session.include? :user_id
    end
end
