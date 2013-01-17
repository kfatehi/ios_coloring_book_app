module Taggable
  # Defines methods based on `tag_hash` to return view with given tag
  # e.g. class MyCell<UITableViewCell;Tags(foo:1, bar:2);end
  # MyCell.new.foo #=> 1
  def Tags(tag_hash)
    tag_hash.each do |meth, tag|
      define_method(meth) { viewWithTag(tag) }
    end
  end
end