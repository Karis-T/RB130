class Series
  def initialize(series)
    @series = series
  end

  def slices(n)
    raise ArgumentError if @series.length < n
    @series.chars.map(&:to_i).each_cons(n).to_a
  end

end

series = Series.new('01234')
p series.slices(2)