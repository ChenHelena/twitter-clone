module TweetsHelper
  def avatar(user, size: { x: 250, y: 250 })
    image_tag user.avatar.variant(resize_to_fill: [size[:x], size[:y]]), class:'rounded-circle' if user && user.avatar.attached?
  end
  def cover_image(user, size: { x: 250, y: 250 })
    image_tag user.avatar.variant(resize_to_fill: [size[:x], size[:y]]) if user && user.avatar.attached?
  end
end