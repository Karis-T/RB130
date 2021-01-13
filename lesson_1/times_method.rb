def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end
  number  # returns original argument to match behaviour of #times
end

times(5) do |num|
  puts num
end

=begin
1. Method invoation starts at line 10
  - times is invoked with two arguments: `5` and a block of code
2. Execution begins on line 2
  - we initialize the local variable `counter` and assign it to 0
3. Execution continues on line 3
  - The while conditional evaluates to true
4. Execution on line 4 yields to a block
  - this executes the block with argument `counter`
5. Execution jumps to line 10
  - this sets `counter` to the blocks local variable `num`
6. Execution continues on line 11
  - we output the local variable `num`
7. We reach the end of the block on line 12 and execution comes back to the times method implementation on line 5
  - counter is incremented by 1
8. We reach the end of the while loop on line 6 and execution continues on line 3, repeating steps 3 to 7
9. The while conditional will eventually evaluate to false, allowing the flow of execution to jump to line 7.
10. Since we have reached the end of the method on line 10 the last expression in the method is returned, - the local variable `number`
=end
