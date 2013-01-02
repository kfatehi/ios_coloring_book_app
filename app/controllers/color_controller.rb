class ColorController < ViewController::Portrait
  
  outlet :draw_layer
  outlet :page_image

  def viewDidLoad
    $current_book = nil
    $current_page = nil
    restore_book
    restore_page
    if $current_page
      start_drawing!
    end
    super
  end

  def restore_book
    unless current_book_name = App::Persistence['current_book_name']
      p 'There was no book to restore. I will load volume one.'
      current_book_name = 'volume_one'
    else
      p 'Restoring book ' + current_book_name
    end
    load_book Book.new current_book_name
  end

  def restore_page
    unless current_page_number = App::Persistence['current_page_number']
      p 'There was no page to restore. I will load page one.'
      current_page_number = 1
    else
      p 'Restoring page ' + current_page_number.to_s
    end
    load_page $current_book.page(current_page_number)
  end

  def load_book book
    $current_book = book
    App::Persistence['current_book_name'] = book.name
  end

  def load_page page
    $current_page = page
    App::Persistence['current_page_number'] = page.number
    @page_image.image = page.image
  end

  def start_drawing!
    if @draw_view.nil?
      @draw_view = DrawView.new
      @draw_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
      @draw_view.contentMode = UIViewContentModeScaleToFill
      @draw_view.backgroundColor = UIColor.clearColor
    end
    @draw_layer.addSubview(@draw_view)
  end
end