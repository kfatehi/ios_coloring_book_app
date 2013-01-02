class Book
  attr_reader :name, :path

  def initialize name
    @name = name
    @path = File.join(App.resources_path, 'books', @name)
    App::Persistence[@name] ||= {}
  end

  def page number
    Page.new(self, number)
  end

  def self.restore
    unless current_book_name = App::Persistence['current_book_name']
      p 'There was no book to restore. I will load volume one.'
      current_book_name = 'volume_one'
    else
      p 'Restoring book ' + current_book_name
    end
    book = new current_book_name
    App::Persistence['current_book_name'] = book.name
    book
  end

  def restore_page
    unless current_page_number = App::Persistence['current_page_number']
      p 'There was no page to restore. I will load page one.'
      current_page_number = 1
    else
      p 'Restoring page ' + current_page_number.to_s
    end
    App::Persistence['current_page_number'] = current_page_number
    page(current_page_number)
  end
end