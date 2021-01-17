#1
assert_equal(true, value.odd?)

#2
assert_equal('xyz', value.downcase)

#3
assert_nil(value)

#4
assert_empty(list)

#5
assert_includes(list, 'xyz')

#6
assert_raises(NoExperienceError) {employee.hire}

#7
assert_kind_of(Numeric, value)

#8
assert_same(list, list.process)

#9
refute_includes(list, 'xyz')