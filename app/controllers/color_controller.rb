class ColorController < ViewController::Portrait
  
  outlet :drawing_container
  outlet :page_image
  outlet :menu_button
  outlet :menu_view

  def viewDidLoad
    $current_book = Book.restore
    $current_page = $current_book.restore_page
    color $current_page
    super
  end

  def show_menu sender
    @drawing.disable
    @menu_button.hide
    @menu_view.show
  end

  def close_menu sender
    @drawing.enable
    @menu_button.show
    @menu_view.hide
  end

  def color page
    @page_image.image = page.image
    @drawing_container.addSubview page.draw_view
  end
end