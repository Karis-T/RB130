class TextAnalyzer
  def process
    file = File.open("text.txt")
    file_arr = file.readlines.map(&:chomp)

    hash = {paragraph: 1, lines: 0, words: 0}
    file_arr.each { |l| yield(l, hash) }

    puts "#{hash[:paragraph]} paragraphs"
    puts "#{hash[:lines]} lines"
    puts "#{hash[:words]} words"
    
    file.close
  end
end


analyzer = TextAnalyzer.new

analyzer.process(file_arr) do |l, hash|
  hash[:words] += l.split.length
  hash[:lines] += 1
  hash[:paragraph] += 1 if l == ("")
end

=begin
class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    yield(file.read)
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
analyzer.process { |text| puts "#{text.split("\n").count} lines" }
analyzer.process { |text| puts "#{text.split(' ').count} words" }
=end
