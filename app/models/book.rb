class Book
  attr_reader :name, :path, :pages, :page_count

  def initialize name
    @name = name
    @path = File.join(App.resources_path, 'books', @name)
    @pages = Dir.glob("#{@path}/*.png").map {|i| Page.new @path, i[-6..-5].to_i}
    @gallery_page_cells = []
    @pages.each_with_index do |page, index|
      @gallery_page_cells << GalleryPageCell.alloc
    end
    @page_count = @pages.count
  end

  def page number
    @pages[number]
  end

  # Conform to the CollectionView DataSource Protocol

  def collectionView(cv, numberOfItemsInSection:n)
    p "book collection view item count reported as #{page_count.to_s}"
    page_count
  end

  def collectionView(cv, cellForItemAtIndexPath:index_path)
    p "book collection view item building at pos #{index_path.row}"
    @reuseIdentifier ||= "GALLERY_PAGE_CELL"
    cell = cv.dequeueReusableCellWithReuseIdentifier(@reuseIdentifier, forIndexPath:index_path) || begin
      @gallery_cell[index_path.row].initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.page = @pages[index_path.row]
    cell
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
    page current_page_number
  end
end