class GalleryPageCell < UICollectionViewCell
  extend Taggable
  Tags page_number:10, img:32

  def setSelected(selected, animated:animated)
    p 'set selected!'
    self.layer.borderColor = UIColor.yellowColor.CGColor
    self.layer.borderWidth = (selected ? 2 : 0).to_f
    self.layer.backgroundColor = UIColor.yellowColor.CGColor
  end

  def page= page
    p 'gallery page cell made'
    @page = page
    self.page_number.setText @page.number.to_s
    self.img.image = @page.thumb
  end
end