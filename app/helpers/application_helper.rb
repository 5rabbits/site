module ApplicationHelper
  # TODO: Traer las imágenes desde medium
  def blog_entry_author_image(entry)
    case entry.author
    when 'b(f)rutalchrist'
      'https://cdn-images-1.medium.com/fit/c/120/120/1*oikhBBl5diLscG3R1O14bA.png'
    when 'Tamara Luque Namuncura'
      'https://cdn-images-1.medium.com/fit/c/120/120/1*8A4YuGwmPPE6szKOj8aZ-Q.jpeg'
    when 'Javier Segovia'
      'https://cdn-images-1.medium.com/fit/c/120/120/1*iQXLw-kaFX6FD6ROjQuISg.jpeg'
    else
      asset_url('default-profile.jpg')
    end
  end
end
