def add_line_to_test_file
  File.open(test_file, 'a') { |f| f.puts '<p class="super">10</p>'}
end

def reset_test_file_after(&block)
  lines = File.readlines(test_file)

  yield

  File.open(test_file, "w") do |f|
    lines.each { |line| f.puts line }
  end
end

def test_file
  File.dirname(__FILE__) + '/../support/test.html'
end