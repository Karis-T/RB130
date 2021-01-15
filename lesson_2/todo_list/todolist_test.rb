require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list << @todo1
    @list << @todo2
    @list << @todo3
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_add
    assert_raises(TypeError) {@list.add(1)}
  end

  def test_instance_of_todo
    assert_instance_of(Todo, @list.<<(@todo1).last)
  end

  def test_item_at
    assert_raises(IndexError) {@list.item_at(3)}
    assert_equal(@todo2, @list.item_at(1))
  end

  def test_mark_done_at
    assert_raises(IndexError) {@list.mark_done_at(3)}
    assert_equal(@todo2.done!, @list.mark_done_at(1))
  end

  def test_mark_undone_at
    assert_raises(IndexError) {@list.mark_undone_at(3)}
    assert_equal(@todo2.undone!, @list.mark_undone_at(1))
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) {@list.remove_at(3)}
    assert_equal(@todo2, @list.remove_at(1))
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(1)

    assert_equal(output, @list.to_s)

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!

    assert_equal(output, @list.to_s)
  end

  def test_each
    arr = []
    @list.each { |todo| arr << todo }
    assert_equal(@todos, arr)
    assert_same(@list, @list.each{"test"})
  end

  def test_select
    assert_equal(TodoList.new(@list.title).to_s, @list.select(&:done?).to_s)
  end

  def test_find_by_title
    assert_equal(@todo1, @list.find_by_title("Buy milk"))
  end

  def test_all_done
    new_list = TodoList.new(@list.title)
    new_list << @todo2
    new_list.done!
    assert_equal(new_list.all_done.to_s, @list.all_done.to_s)
  end

  def test_all_not_done
    new_list = TodoList.new(@list.title)
    new_list << @todo1
    new_list << @todo2
    new_list << @todo3
    assert_equal(new_list.all_not_done.to_s, @list.all_not_done.to_s)
  end

  def test_mark_done
    assert_equal(@list.find_by_title("Buy milk").done!, @list.mark_done("Buy milk"))
  end

  def test_mark_all_undone
    assert_equal(@list, @list.mark_all_undone)
  end
end