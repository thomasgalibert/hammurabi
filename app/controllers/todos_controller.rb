class TodosController < ApplicationController
  include Ordering
  before_action :authenticate_user!
  before_action :set_todo, only: [:edit, :update, :destroy, :sort]

  def create
    @todo = current_user.todos.create(todo_params)
    add_item_to_list(@todo.todoable.todos, @todo)
    redirect_to @todo.todoable
  end

  def edit
    
  end

  def update
    @todo.update(todo_params)
    redirect_to @todo.todoable
  end

  def sort
    new_position = params[:row_order_position].to_i+1
    reorder_items(@todo.todoable.todos, @todo, new_position)  
    head :no_content
  end

  def destroy
    delete_item(@todo.todoable.todos, @todo)

    respond_to do |format|
      format.html { redirect_to @todo.todoable }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@todo) }
    end
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
    @todoable = @todo.todoable
  end

  def todo_params
    params.require(:todo).permit(:name, :due_at, :done, :todoable_type, :todoable_id)
  end

end