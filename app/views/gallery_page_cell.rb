class GalleryPageCell < UICollectionViewCell
  extend Taggable
  attr_reader :page

  Tags page_number:10, img:32

  def page= page
    p 'gallery page cell made'
    @page = page
    page_number.setText page.number.to_s
    img.image = page.image
  end
end