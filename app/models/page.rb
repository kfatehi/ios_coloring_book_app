class Page
  attr_reader :number, :book, :image_path, :paths, :path_colors

  def initialize book, number
    @book = book
    @number = number
    @image_path = File.join(@book.path, "#{'%02d' % number}.png")
    App::Persistence[@book.name][@number] ||= {}
    @paths = App::Persistence[@book.name][@number][:paths] ||= []
    @path_colors = App::Persistence[@book.name][@number][:path_colors] ||= []
  end

  def image
    UIImage.alloc.initWithContentsOfFile image_path
  end

  def draw_view
    @draw_view ||= DrawView.build self
  end
end