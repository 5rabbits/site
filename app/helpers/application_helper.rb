module ApplicationHelper
  def nav_item_class(*actions)
    classes = ['nav-item']
    classes << 'active' if actions.include?(params[:action])
    classes.join(' ')
  end
end
