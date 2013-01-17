module Dismissable
  private
  def dismiss
    if pvc = presentingViewController
      pvc.dismissViewControllerAnimated(true, completion:nil)
    end
  end
  def dismiss_from(vc)
    vc.dismissViewControllerAnimated(true, completion:nil)
  end
end