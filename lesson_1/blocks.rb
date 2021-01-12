# method implementation that'll take block and/or argument
def say(words)
  yield if block_given?
  puts "> " + words
end

# specific method invocation that takes 2 args: 1 string and 1 block that clears the screen when yielded to
say("hi there") do
  system 'clear'
end

# outputs > hi there


# method implementation where yield takes an argument (6 is sent to the block and assigned to parameter |num|)
def increment(number)
  if block_given?
    yield(number + 1)
  end
  number + 1
end


# method invocation
increment(5) do |num|
  puts num
end

# outputs 6
# => 6


def test
  yield(1, 2)
end

test { |num| puts num }

# outputs 1 (2 is ignored as there's no parameter for it in the block)


def test
  yield(1)
end

test do |num1, num2|
  puts "#{num1} #{num2}"
end

# outputs 1  with whitespace as theres no second parameter so nil is assigned to num2


# use different blocks to supply a different return value to the method implementation. Be careful about the return value of the block

def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

compare('hello') { |word| word.upcase }

# Before: hello
# After: HELLO
# => nil

compare('hello') { |word| word.slice(1..2) }

# Before: hello
# After: el
# => nil

compare('hello') { |word| "nothing to do with anything" }

# Before: hello
# After: nothing to do with anything
# => nil

compare('hello') { |word| puts "hi" }

# Before: hello
# hi
# After:
# => nil

# too many depenencies and not flexible enough to accomodate any method invocation
def compare(str, flag)
  after = case flag
          when :upcase
            str.upcase
          when :capitalize
            str.capitalize
          # etc, we could have a lot of 'when' clauses
          end

  puts "Before: #{str}"
  puts "After: #{after}"
end

compare("hello", :upcase)

# Before: hello
# After: HELLO
# => nil

# sandwich before and after block alterations
def time_it
  time_before = Time.now
  yield
  time_after = Time.now

  puts "it took #{time_after - time_before} seconds."
end

time_it { sleep(3) } # sleep pauses execution based on the number of seconds passed in.

 # It took 3.003767 seconds.
 # => nil

time_it { "hello world" }
# It took 3.0e-06 seconds.
# => nil

my_file = File.new("some_file.txt", "w+")
# write to this file using my_file.write
my_file.close

File.open("some_file.txt", "w+") do |file|
  # write to this file using file.write
end
# file is closed automatically from the method after the block is finished.

# explicit blocks allow us to use blocks in a flexible way
def test(&block)
  puts "What's &block? #{block}"
end

test { sleep(1) }

# What's &block? #<Proc:0x007f98e32b83c8@(irb):59>
# => nil

def test2(block)
  puts "hello"
  block.call # calls block that was originally passed to test()
  puts "good-bye"
end

def test(&block)
  puts "1"
  test2(block)
  puts "2"
end

test { puts "xyz" }
# => 1
# => hello
# => xyz
# => good-bye
# => 2