#1
class Device
  def initialize
    @recordings = []
  end

  def listen
    record(yield) if block_given?
  end

  def record(recording)
    @recordings << recording
  end

  def play
    puts @recordings.last
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"

#3

def gather(items)
  puts "Let's start gathering food."
  yield(items) if block_given?
  puts "Nice selection of food we have gathered!"
end

items = ['apples', 'corn', 'cabbage', 'wheat']

gather(items) {|items| puts "#{items.join(', ')}"}
