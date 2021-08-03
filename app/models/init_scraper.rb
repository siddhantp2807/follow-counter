require "json"
require 'selenium-webdriver'
require 'headless'


class InitScraper
    def initialize(username)
        @username = username
    end

    def getId(bot_username, bot_password)

        Headless.ly do

            browser = Selenium::WebDriver.for :chrome
        
            browser.navigate.to "https://instagram.com"
            sleep(5)

            browser.find_elements(tag_name: 'input')[0].send_keys(bot_username)
            browser.find_elements(tag_name: 'input')[1].send_keys(bot_password)
        
            sleep(2)
        
            browser.find_elements(tag_name: "button")[1].click
        
            sleep(5)

            id_s = "let username = '#{@username}';\n" + "

            let UserId = '';
            let name = '';
            let profile_pic_url = '';
            let is_private = '';

            try {
                let res = await fetch(`https://www.instagram.com/${username}/?__a=1`)
    
                res = await res.json()
                userId = res.graphql.user.id;
                name = res.graphql.user.full_name;
                profile_pic_url = res.graphql.user.profile_pic_url;
                is_private = res.graphql.user.is_private;
    
            } catch(err) {
                console.log(err);
            }
            return [userId, name, profile_pic_url, is_private];
            "

            @id, @name, @profile_pic_url, @is_private = browser.execute_script(id_s)
            
        end
    end

    def values
        hash = {}
        self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

        hash
    end
end
