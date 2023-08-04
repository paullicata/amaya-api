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
      # puts "Use selected: #{title} - #{author} Grade: #{cleaned_grade}? Select n/y"
      # response = gets.chomp

      # if response == 'n'
      #   puts 'Skipping this Author/Book'
      #   next
      # else
      author_new = Author.create(name: author)
      Book.create(title: title_stripped,
                  author_id: author_new.id,
                  copyright: 'N/A',
                  genre: 'N/A',
                  grade_level: cleaned_grade,
                  description: 'N/A')
      # end
    end
  end

  def self.find_author(first_name, last_name)
    Author.where("authors.first_name = '#{first_name}' and authors.last_name = '#{last_name}'")
  end

  def self.create_author(first_name, last_name)
    Author.create(first_name: first_name, last_name: last_name)
  end

  def self.find_book(title)
    Book.where(title: title)
  end

  def self.create_book(title, author_id, copyright, genre, grade_level, description)
    Book.create(title: title,
                author_id: author_id,
                copyright: copyright,
                genre: genre,
                grade_level: grade_level,
                description: description)
  end

  def self.start
    scan_group, grade = read_and_scan
    find_author_and_book(scan_group, grade)
  end
end

ExtractAuthorsFromTimeout.start



