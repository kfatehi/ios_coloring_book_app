class ColorController < ViewController::Portrait
  
  outlet :drawing_container
  outlet :page_image
  outlet :menu_view

  def viewDidLoad
    $current_book = Book.restore
    $current_page = $current_book.restore_page
    color $current_page
    super
  end

  def show_menu sender
    @menu_view.show
  end

  def close_menu sender
    @menu_view.hide
  end

  def color page
    @page_image.image = page.image
    $draw_view = DrawView.build(page)
    @drawing_container.addSubview $draw_view
  end

  def viewWillDisappear animated
    $current_page.save_drawing
  end
end