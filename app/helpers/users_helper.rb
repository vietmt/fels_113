module UsersHelper
  def avatar_for user
    avatar = user.avatar? ? user.avatar : Settings.default_avatar
    image_tag avatar, height: 50, width: 50, class:"img-circle"
  end
end
