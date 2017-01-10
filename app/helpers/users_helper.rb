module UsersHelper

  def gravatar_for user, options = {size: 80}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def avatar_for user, options = {size: 50}
    size = options[:size]
    if user.image.present?
      link_to image_tag(user.image, size: size), user
    else
      link_to gravatar_for(user, size: size), user
    end
  end
end
