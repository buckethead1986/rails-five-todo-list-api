class ItemsController < ApplicationController
  #before actions load actions in /concerns loaded through applicaiton controller
  before_action :set_todo
  before_action :set_todo_item, only: [:show, :update, :destroy]

  def index
    json_response(@todo.items)
  end

  def show
    json_response(@item)
  end

  def create
    @todo.items.create!(item_params)
    json_response(@todo, :created)
  end

  #head :no_content returns a 200 status code when theres no body.
  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :done)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find_by!(id: params[:id]) if @todo
  end
end
