class InitRunJob < ApplicationJob
  queue_as :default

  def perform(username)

    bot = Bot.first
    scrape = InitScraper.new(username)
    scrape.getId(bot.username, bot.password)

    return false if scrape.values['is_private'] == true

    usr = IgUser.create_or_find_by(id: scrape.values["id"])
    usr.update(username: scrape.values["username"], name: scrape.values["name"], profile_pic_url: scrape.values["profile_pic_url"])

    return true

  end
end
