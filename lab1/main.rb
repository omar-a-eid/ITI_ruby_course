require 'json'

class Book
  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  #return an object to store it int the json file
  def format() 
    {title: @title, author: @author, isbn: @isbn}
  end
end

class BookInventory
  @@count = 0
  def initialize ()
    @listOfBooks = [];
  end

  def addBook(title, author, isbn)
    book = Book.new(title, author, isbn).format
    @listOfBooks = JSON.parse(File.read('books.json'))
    @listOfBooks.push(JSON.dump(book))
    writeDataToFile(@listOfBooks)
  end

  def removeBook(isbn)
    @listOfBooks.delete_if{|book| isbn == JSON.parse(book)["isbn"]}
    writeDataToFile(@listOfBooks)
  end

  def getBooks()
    JSON.parse(File.read('books.json'))

  end
  
  def displayBooks()
    books = getBooks()
    for book in books
      puts "________________________________________"
      puts "Book"
      puts "Book title: #{JSON.parse(book)['title']}"
      puts "Book author: #{JSON.parse(book)['author']}"
      puts "Book isbn: #{JSON.parse(book)['isbn']}"
      puts "________________________________________"
    end
    
  end
  def writeDataToFile(data)
    File.write('./books.json', JSON.dump(data))
  end
end

$bookInventory = BookInventory.new()

def showActions
  puts "Choose an action: "
  puts "1. list books"
  puts "2. Add new book"
  puts "3. Remove book by ISBN"
  puts "To exit type -1"

end

def handleInput(i)
  case i.to_i
    when 1
      $bookInventory.displayBooks()
    when 2
      puts "Enter Book Title: "
      title = gets
      puts "Enter Book Author: "
      author =  gets
      puts "Enter Book ISBN: "
      isbn =  gets
      $bookInventory.addBook(title, author, isbn)
    when 3
      puts "Enter Book ISBN: "
      isbn = gets
      $bookInventory.removeBook(isbn)
  end
end


i = 1;
while i.to_i != -1
  showActions
  i = gets
  handleInput(i)

end
