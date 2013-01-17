class GalleryPageCell < UICollectionViewCell
  extend Taggable
  Tags page_number:10, img:32, button:45

  def setSelected(selected, animated:animated)
    self.layer.borderColor = UIColor.yellowColor.CGColor
    self.layer.borderWidth = (selected ? 2 : 0).to_f
  end

  def page= page
    p 'gallery page cell made'
    @page = page
    self.page_number.setText @page.number.to_s
    self.img.image = @page.thumb
    self.button.on(:touch_up_inside) do |btn|
      p "set current page to #{@page.number}"
      $current_page = @page
    end
  end
end