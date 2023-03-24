class ItemsController < ApplicationController
   rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #  GET /users/:user_id/items
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  # GET /users/:user_id/items/:id
  def show 
    item = Item.find(params[:id])
    render json: item
  end

  # POST /users/:user_id/items
  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(items_params)
    end
      render json: item, status: :created
  end

  private
  #  error not-found method 
  def render_not_found_response
    render json: {error: "User not found"}, status: :not_found
  end

  # items-params method
  def items_params
    params.permit(:name, :description, :price)
  end
end
