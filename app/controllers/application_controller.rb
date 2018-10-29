# Site application controller
class ApplicationController < ActionController::Base
  def home
    @blog_entries = Rails.cache.fetch('blog_entries', expires_in: 12.hours) do
      blog_feed
    end
  end

  def team
    @team = load_setting('team')
  end

  def member
    @team = load_setting('team')
    @member = find_by_name @team, params[:name]
  end

  def community; end

  def blog
    redirect_to ENV['BLOG']
  end

  private

  def blog_feed
    blog_url = "#{ENV['BLOG']}/feed"
    feed = Feedjira::Feed.fetch_and_parse(blog_url)
    feed.entries[0..4]
  end

  def find_by_name(team, name)
    team.find do |member|
      name_key(member['name'].underscore) == name_key(name)
    end
  end

  def name_key(name)
    name.underscore
        .downcase
        .tr(' ', '_')
  end

  def load_setting(setting)
    YAML.load_file(
      Rails.root.join("config/#{setting}.yml")
    )
  end
end
