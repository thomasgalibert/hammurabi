require "test_helper"
include Ordering

class TodoTest < ActiveSupport::TestCase
  
  def setup
    @user = FactoryBot.create(:user)
    @dossier = FactoryBot.create(:dossier, user: @user)
  end
  
  test "vérifie que l'ordre des todos est correct après leur création" do
    todo1 = FactoryBot.create(:todo, user: @user, todoable: @dossier)
    todo2 = FactoryBot.create(:todo, user: @user, todoable: @dossier)
    todo3 = FactoryBot.create(:todo, user: @user, todoable: @dossier)

    todos = Todo.where(todoable: @dossier)
    initialize_row_order(todos)
  
    todo1.reload
    todo2.reload
    todo3.reload

    assert_equal 3, todo1.row_order
    assert_equal 2, todo2.row_order
    assert_equal 1, todo3.row_order
  end

  test "vérifie que l'ordre des todos est correct après leur suppression" do
    todo1 = FactoryBot.create(:todo, user: @user, todoable: @dossier)
    todo2 = FactoryBot.create(:todo, user: @user, todoable: @dossier)
    todo3 = FactoryBot.create(:todo, user: @user, todoable: @dossier)

    todos = Todo.where(todoable: @dossier)
    initialize_row_order(todos)

    todo1.reload
    todo2.reload
    todo3.reload

    delete_item(todos, todo2)

    todo1.reload
    todo3.reload

    assert_equal 2, todo1.row_order
    assert_equal 1, todo3.row_order
  end

  test "vérifie que l'ordre des todos est correct après l'ajout d'un nouvelle" do
    todo1 = FactoryBot.create(:todo, user: @user, todoable: @dossier)
    todo2 = FactoryBot.create(:todo, user: @user, todoable: @dossier)
    todo3 = FactoryBot.create(:todo, user: @user, todoable: @dossier)

    todos = Todo.where(todoable: @dossier)
    initialize_row_order(todos)

    todo1.reload
    todo2.reload
    todo3.reload

    todo4 = FactoryBot.create(:todo, user: @user, todoable: @dossier)
    add_item_to_list(todos, todo4)

    todo1.reload
    todo2.reload
    todo3.reload
    todo4.reload

    assert_equal 3, todo1.row_order
    assert_equal 2, todo2.row_order
    assert_equal 1, todo3.row_order
    assert_equal 4, todo4.row_order
  end

end
