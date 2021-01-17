#1
def step(start, fin, counter)
  next_count = start
  (start..fin).each do |value|
    next unless next_count == value
    yield(value)
    next_count = (value += counter)
  end
end

step(1, 10, 3) { |value| puts "value = #{value}" }

#2

def zip(arr1, arr2)
  arr1.map.with_index { |ele, idx| [ele, arr2[idx]] }
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

#3

def map(arr)
  new_arr = []
  arr.each {|ele| new_arr << yield(ele)}
  new_arr
end

p map([1, 3, 6]) { |value| value**2 } #== [1, 9, 36]
p map([]) { |value| true } #== []
p map(['a', 'b', 'c', 'd']) { |value| false } #== [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } #== ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } #== [[1], [1, 2, 3], [1, 2, 3, 4]]

#4
def count(*args)
  num = 0
  [*args].each {|ele| num += 1 if yield(ele)}
  num
end

#5
def drop_while(arr)
  idx = 0
  new_arr = arr.clone
  while yield(arr[idx])
    break if new_arr.empty?
    new_arr.shift
    idx += 1
  end
  new_arr
end


p drop_while([1, 3, 5, 6]) { |value| value.odd? } #== [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } #== [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } #== []
p drop_while([1, 3, 5, 6]) { |value| false } #== [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } #== [5, 6]
p drop_while([]) { |value| true } #== []

#6

def each_with_index(collection)
  collection.each { |value| yield(value, collection.index(value))}
end


result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]

#7
def each_with_object(arr, obj)
  arr.each { |val| yield(val, obj) }
  obj
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result #== [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result #== [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result #== { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result #== {}

#8

def max_by(array)
  new_arr = []
  array.each {|ele| new_arr << yield(ele)}
  idx = new_arr.index(new_arr.max)
  idx.nil? ? nil : array[idx]
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil

#9

def each_cons(arr)
  arr.each_with_index { |val, idx| return unless arr[idx+1]; yield(val, arr[idx+1]) }
end

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
#result == nil
p hash #== { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash #== {}
#result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash #== {'a' => 'b'}
#result == nil

#10

def each_cons(arr, lngth)
  arr.each_with_index do |val, idx|
    return unless arr[idx + (lngth-1)]
    lngth == 1 ? yield(arr[idx]) : yield(arr[idx, lngth])
  end
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash == {}