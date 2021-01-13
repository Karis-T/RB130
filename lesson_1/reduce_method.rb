# reduce folds or combines a collection into 1 object.
# reduce sets the return value of the block to the return value of the block  then passes the accumulator onto the next yield

def reduce(array, default_value=0)
  counter = 0
  accumulator = default_value
  while counter < array.length
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end
  accumulator
end

def reduce(array, default_value=0)
  accumulator = default_value
  array.each {|number| accumulator = yield(accumulator, number)}
  accumulator
end


array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }
# => 15
p reduce(array, 10) { |acc, num| acc + num }
# => 25
p reduce(array) { |acc, num| acc + num if num.odd? }
# => NoMethodError: undefined method `+' for nil:NilClass

# extra implementation

def reduce(array, default_value=0)
  accumulator = default_value
  accumulator = case array[0]
                when String then ''
                when Array then []
                when Integer then 0
                end
  array.each { |value| accumulator = yield(accumulator, value) }
  accumulator
end

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']