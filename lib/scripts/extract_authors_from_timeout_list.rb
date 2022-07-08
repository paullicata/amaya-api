class ExtractAuthorsFromTimeout


  def self.read_and_scan
    file = File.open("#{Rails.root}/timeout_book_list.txt").read
    author_title = file.scan(/[0-9]\. .*\nBy .*/).flatten
    grade = file.scan(/Best for: .*/).flatten
    return author_title, grade
  end

  def self.find_author_and_book(scan_group, grade)
    scan_group.uniq.each_with_index do |match, index|
      split_group = match.split(/\nBy /)
      title = split_group[0]
      author = split_group[1]
      title_stripped = title.sub(/[0"-9]. /, '')

      cleaned_grade = grade[index].sub(/Best for: /, '')
      puts "Use selected: #{title} - #{author} Grade: #{cleaned_grade}? Select n/y"
      response = gets.chomp

      if response == 'n'
        puts 'here'
        next
      else
        puts "Ack!"
        author_split = author.split
        author = Author.create(first_name: author_split[0], last_name: author_split[1])
        Book.create(title: title_stripped,
                    author_id: author.id,
                    copyright: 'N/A',
                    genre: 'N/A',
                    grade_level: cleaned_grade,
                    description: 'N/A')
      end
    end
  end

  def self.start
    scan_group, grade = read_and_scan
    find_author_and_book(scan_group, grade)
  end
end

ExtractAuthorsFromTimeout.start



