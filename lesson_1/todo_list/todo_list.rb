=begin
This class represents a collection of Todo objects.
You can perform typical collection-oriented actions
on a TodoList object, including iteration and selection.
=end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, "Can only add todo objects" if todo.class != Todo
    @todos << todo
  end

  alias_method :<<, :add

  def size
    @todos.length
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos.clone
  end

  def done?
    @todos.all?{ |todo| todo.done? }
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    todo = @todos.fetch(index)
    todo.done!
  end

  def mark_undone_at(index)
    todo = @todos.fetch(index)
    todo.undone!
  end

  def done!
    each{ |todo| todo.done! }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.fetch(index)
    @todos.delete_at(index)
  end

  def to_s
    string = "---- #{title} ----"
    string << @todos.map { |todo| todo.to_s.join("\n") }
    string
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    new_list = TodoList.new(title)
    each {|todo| new_list << todo if yield(todo) }
    new_list
  end

  def find_by_title(str)
    select { |todo| todo.title == str }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !(todo.done?) }
  end

  def mark_done(str)
    find_by_title(str).done!
  end

  alias_method :done!, :mark_all_done

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

=begin
This class represents a todo item and its associated
data: name and description. There's also a "done"
flag to show whether this todo item is done.
=end

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
    description == otherTodo.description &&
    done == otherTodo.done
  end
end


todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect