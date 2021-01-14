require 'minitest/autorun'

require_relative 'car'

describe 'Car#wheels' do
  it 'has 4 wheels' do
    car = Car.new
    car.wheels.must_equal 4   # this is the expectation
  end
end

=begin
# expectation style syntax
  - tests are grouped into describe blocks.
  - individual tests are written with it method
  - instead of assertions(methods) we used 'expecation matchers'
  - this DSL doesn't look like ruby syntax
  - the test looks the same as MiniTest
=end
