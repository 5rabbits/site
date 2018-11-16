# Site application controller
class ApplicationController < ActionController::Base
  def home
    @blog_entries = Rails.cache.fetch('blog_entries', expires_in: 12.hours) do
      blog_feed
    end

    # TODO: Está bien hardcodear esto?? 🤨
    @tech = [
      { name: 'Javascript', weight: 2 },
      { name: 'React', weight: 2.5 },
      { name: 'Ruby', weight: 2 },
      { name: 'Ruby on Rails', weight: 2.5 },
      { name: 'PHP', weight: 1.75 },
      { name: 'Machine Learning', weight: 1.75 },
      { name: 'Java', weight: 1.7 },
      { name: 'Python', weight: 1 },
      { name: 'NodeJS', weight: 1.25 },
      { name: 'CSS', weight: 2 },
      { name: 'UX/UI', weight: 2 },
      { name: 'Electron', weight: 1.25 },
      { name: 'React Native', weight: 1.2 },
      { name: 'Go', weight: 1 },
      { name: 'Laravel', weight: 1 },
      { name: 'VueJS', weight: 1 },
    ].shuffle

    min_size = 60

    @team = load_setting('team')
    team_size = @team.size

    (min_size - team_size).times do |i|
      @team << @team[i % team_size]
    end
  end

  def team
    @team = load_setting('team')
  end

  def member
    @team = load_setting('team')
    @member = find_by_name @team, params[:name]
  end

  def community
    repos = [
      'site',
      'dashboard',
      'headerstrip',
      'portrait',
      'react-components',
      'create-react-lib'
    ]

    @repos = Rails.cache.fetch('github_repos', expires_in: 1.day) do
      repos.map do |repo|
        Github.repos.get '5rabbits', repo
      end
    end
  end

  def blog
    redirect_to ENV['BLOG']
  end

  private

  def blog_feed
    blog_url = "#{ENV['BLOG']}/feed"
    feed = Feedjira::Feed.fetch_and_parse(blog_url)
    feed.entries[0..6]
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
