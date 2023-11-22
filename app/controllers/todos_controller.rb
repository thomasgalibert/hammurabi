class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:edit, :update, :sort]

  def create
    @todo = current_user.todos.create(todo_params)
    redirect_to @todo.todoable
  end

  def edit
    
  end

  def update
    @todo.update(todo_params)
    redirect_to @todo.todoable
  end

  def sort
    @todo.update(row_order_position: params[:row_order_position])
    head :no_content
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