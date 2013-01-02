class Page
  attr_reader :number, :book, :image_path, :identifier, :drawing

  def initialize book, number
    @book = book
    @number = number
    @draw_key = "#{@book.path}-#{'%02d' % number}"
    @image_path = File.join(@book.path, "#{'%02d' % number}.png")
    @drawing = load_drawing
  end

  def load_drawing
    if drawing_data = App::Persistence[@draw_key]
      NSKeyedUnarchiver.unarchiveObjectWithData(drawing_data)
    else ; Drawing.new ; end
  end

  def save_drawing
    drawing_data = NSKeyedArchiver.archivedDataWithRootObject(@drawing)
    App::Persistence[@draw_key] = drawing_data
  end

  def image
    UIImage.alloc.initWithContentsOfFile image_path
  end
end