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
    @todos.map { |todo| todo.title }
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
    @todos.each{ |todo| todo.done! }
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
    puts "---- Today's Todos ----"
    @todos.each { |todo| puts todo }
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
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

list.each do |todo|
  puts todo                   # calls Todo#to_s
end