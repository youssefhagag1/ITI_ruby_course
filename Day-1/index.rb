BOOKS_FILE = "books.txt"

class Inventory

  def initialize
    @books = []
    load_books
  end

  def load_books
    if File.exist?(BOOKS_FILE)

      lines = File.readlines(BOOKS_FILE)

      for line in lines
        parts = line.chomp.split(",")

        book = {
          "title" => parts[0],
          "author" => parts[1],
          "isbn" => parts[2],
          "count" => parts[3].to_i
        }

        @books.push(book)
      end
    end
  end

  def save_books
    file = File.open(BOOKS_FILE, "w")

    for book in @books
      line = "#{book['title']},#{book['author']},#{book['isbn']},#{book['count']}"
      file.puts(line)
    end

    file.close
  end

  def list_books

    if @books.length == 0
      puts "No books found"
      return
    end

    # manual sorting by ISBN
    n = @books.length

    for i in 0...n
      for j in 0...(n - i - 1)

        if @books[j]["isbn"] > @books[j + 1]["isbn"]

          temp = @books[j]
          @books[j] = @books[j + 1]
          @books[j + 1] = temp

        end
      end
    end

    index = 1

    for book in @books

      puts "Book ##{index}"
      puts "Title : #{book['title']}"
      puts "Author: #{book['author']}"
      puts "ISBN  : #{book['isbn']}"
      puts "Count : #{book['count']}"
      puts "----------------------"

      index = index + 1
    end
  end

  def add_book(title, author, isbn)

    if title == "" || author == "" || isbn == ""
      puts "Invalid input"
      return
    end

    found = false

    for book in @books

      if book["isbn"] == isbn

        book["count"] = book["count"] + 1
        book["title"] = title
        book["author"] = author

        found = true

        puts "Book already exists. Count increased."
      end
    end

    if found == false

      new_book = {
        "title" => title,
        "author" => author,
        "isbn" => isbn,
        "count" => 1
      }

      @books.push(new_book)

      puts "Book added successfully."
    end

    save_books
  end

  def remove_book(isbn)

    if isbn == ""
      puts "Invalid ISBN"
      return
    end

    index = -1

    for i in 0...@books.length

      if @books[i]["isbn"] == isbn
        index = i
      end
    end

    if index != -1

      @books.delete_at(index)

      save_books

      puts "Book removed successfully."

    else
      puts "Book not found"
    end
  end

    def search_by_title(title)

    found = false

    for book in @books

        if book["title"].casecmp(title) == 0

        print_book(book)

        found = true
        end
    end

    if found == false
        puts "No books found"
    end
    end


    def search_by_author(author)

    found = false

    for book in @books

        if book["author"].casecmp(author) == 0

        print_book(book)

        found = true
        end
    end

    if found == false
        puts "No books found"
    end
    end


  def search_by_isbn(isbn)

    found = false

    for book in @books

      if book["isbn"] == isbn

        print_book(book)

        found = true
      end
    end

    if found == false
      puts "No books found"
    end
  end

  def print_book(book)

    puts "Title : #{book['title']}"
    puts "Author: #{book['author']}"
    puts "ISBN  : #{book['isbn']}"
    puts "Count : #{book['count']}"
    puts "----------------------"

  end

end

inventory = Inventory.new

loop do

  puts
  puts "1. List Books"
  puts "2. Add Book"
  puts "3. Remove Book"
  puts "4. Search by Title"
  puts "5. Search by Author"
  puts "6. Search by ISBN"
  puts "7. Exit"

  print "Choose option: "

  choice = gets.chomp

  if choice == "1"

    inventory.list_books

  elsif choice == "2"

    print "Enter title: "
    title = gets.chomp

    print "Enter author: "
    author = gets.chomp

    print "Enter ISBN: "
    isbn = gets.chomp

    inventory.add_book(title, author, isbn)

  elsif choice == "3"

    print "Enter ISBN: "
    isbn = gets.chomp

    inventory.remove_book(isbn)

  elsif choice == "4"

    print "Enter title: "
    title = gets.chomp

    inventory.search_by_title(title)

  elsif choice == "5"

    print "Enter author: "
    author = gets.chomp

    inventory.search_by_author(author)

  elsif choice == "6"

    print "Enter ISBN: "
    isbn = gets.chomp

    inventory.search_by_isbn(isbn)

  elsif choice == "7"

    puts "Goodbye"
    break

  else

    puts "Invalid option"

  end

end

