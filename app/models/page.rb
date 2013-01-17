class Page
  attr_reader :number, :book, :image_path, :identifier, :drawing, :thumb

  def initialize book_path, number
    @number = number
    @draw_key = "#{book_path}-#{'%02d' % number}"
    @image_path = File.join(book_path, "#{'%02d' % number}.png")
    @thumb_path = File.join(book_path, 'thumbs', "#{'%02d' % number}.png")
    @drawing = load_drawing
    @thumb = UIImage.imageWithContentsOfFile @thumb_path
  end

  def image
    UIImage.imageWithContentsOfFile @image_path
  end

  def load_drawing
    if drawing_data = App::Persistence[@draw_key]
      p 'loading saved drawing'
      NSKeyedUnarchiver.unarchiveObjectWithData(drawing_data)
    else ; Drawing.new ; end
  end

  def save_drawing
    p 'saving drawing'
    drawing_data = NSKeyedArchiver.archivedDataWithRootObject(@drawing)
    App::Persistence[@draw_key] = drawing_data
  end
end