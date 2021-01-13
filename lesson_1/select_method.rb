def select(array)
  counter = 0
  selection = []
  while counter < array.length
    selection << array[counter] if yield(array[counter])
    counter += 1
  end
  selection
end

# alternative with Array#each
def select(array)
  counter = 0
  selection = []
  array.each { |n| selection << n if yield(n) }
  selection
end

array = [1, 2, 3, 4, 5]

p array.select { |num| num.odd? }       # => [1, 3, 5]
p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
p array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true