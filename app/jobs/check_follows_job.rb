class CheckFollowsJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later

    bot = Bot.first

    scraper = Scraper.new(id)
    scraper.scrape(bot.username, bot.password)

    data = scraper.values

    IgUser.add_many(data["followers"])

    Record.dynamic_followers(data["followers"])
    Record.static_followers(data["followers"])

    IgUser.add_many(data["followings"])

    Record.dynamic_following(data["followings"])
    Record.static_following(data["followings"])
    
  end

end
