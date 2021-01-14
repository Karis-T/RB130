require 'minitest/autorun'
require 'minitest/reporters' # removes S/F/. that shows what happened with the test
MiniTest::Reporters.use!

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    skip # skip tests when youre in the middle of writing it put it before the test in the method you want to skip
    # pass a string in skip if you want a custom display message
    car = Car.new
    assert_equal(3, car.wheels)
  end
end

=begin
# assert style syntax
  line 1: 'minitest/autorun'
    - this loads all the neccssary files needed to use the gem minitest.
  line 3: require_relative 'car'
    - finds the name of the file we want to test in the current directory
  line 5: Creates our test class. This must subclass from MiniTest::Test to inherit all its methods to write the test
  - to write a test, write an instance method that starts with test_. MiniTest knows this means that this is an individual test that needs to be run
  - inside each test will be a few assertions that we want to verify
  - before we test assertions, we need to set up the data/objects that we want to make assertions against.
  on line 7: we instantiate a new Car object
  - we then use it to check if its @wheel state is 4
  - there are many kinds of tests, but assert_equal is the main one we will use. assert_equal is inherited from the included module MiniTest::Assertions
  - assert equal takes 2 parameters:
      - the expected return value we want
      - the thing we want to test / or the actual value
  - if there is an issue assert_equals saves the error and MiniTest displays it at the end of the test run
  - its useful to have multiple assertions inside a test (instance method)
=end

=begin
Run options: --seed 62238

# Running:

CarTest .

Finished in 0.001097s, 911.3428 runs/s, 911.3428 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

line 32: seed tells MiniTest the order of the tests were run in.
    - the seed is how you tell MiniTest to run the test suite in a particular order. This isn't common but can be hepful when trying to debug something tricky
line 36: the dot indicates nothing went wrong
    - S = skip, F = Failure

=end

=begin
$ ruby car_test.rb

Run options: --seed 8732

# Running:

CarTest F.

Finished in 0.001222s, 1636.7965 runs/s, 1636.7965 assertions/s.

  1) Failure:
CarTest#test_bad_wheels [car_test.rb:13]:
Expected: 3
  Actual: 4

2 runs, 2 assertions, 1 failures, 0 errors, 0 skips

line 70: 2 assertions and 1 failure
line 65: MiniTest gives us which test failed with the expected value and the actual value
line 7: "F" is the test that failed "." is the test that passed
=end
