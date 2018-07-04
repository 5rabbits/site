# Site application controller
class ApplicationController < ActionController::Base
  def home
    @blog_entries = Rails.cache.fetch('blog_entries', expires_in: 12.hours) do
      blog_feed
    end
  end

  def about; end

  def community; end

  def blog
    redirect_to ENV['BLOG']
  end

  private

  def blog_feed
    blog_url = "#{ENV['BLOG']}/feed"
    feed = Feedjira::Feed.fetch_and_parse(blog_url)
    feed.entries
  end
end
