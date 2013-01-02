class Page
  attr_reader :number, :book, :image_path

  def initialize book, number
    @book = book
    @number = number
    @image_path = File.join(@book.path, "#{'%02d' % number}.png")
  end

  def image
    UIImage.alloc.initWithContentsOfFile image_path
  end

  def draw_view
    @draw_view ||= DrawView.build self
  end
end