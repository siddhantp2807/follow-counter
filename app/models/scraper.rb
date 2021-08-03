require "json"
require 'selenium-webdriver'
require 'headless'


class Scraper
    def initialize(userid)
        @followers = []
        @followings = []
        @user_id = userid
    end

    def scrape(bot_username, bot_password)
        
        Headless.ly do 
            browser = Selenium::WebDriver.for :chrome
        
            browser.navigate.to "https://instagram.com"
            sleep(5)
        
            browser.find_elements(tag_name: 'input')[0].send_keys(bot_username)
            browser.find_elements(tag_name: 'input')[1].send_keys(bot_password)
        
            sleep(2)
        
            browser.find_elements(tag_name: "button")[1].click
        
            sleep(5)
            
            follower_s = "let userId = '#{@user_id}';\n" + "let followers = []
                try {
        
                    let after = null, has_next = true
                    while (has_next) {
                        await fetch(`https://www.instagram.com/graphql/query/?query_hash=c76146de99bb02f6415203be841dd25a&variables=` + encodeURIComponent(JSON.stringify({
                            id: userId,
                            include_reel: true,
                            fetch_mutual: true,
                            first: 50,
                            after: after
                        }))).then(res => res.json()).then(res => {
                            has_next = res.data.user.edge_followed_by.page_info.has_next_page
                            after = res.data.user.edge_followed_by.page_info.end_cursor
                            followers = followers.concat(res.data.user.edge_followed_by.edges.map(({ node }) => {
                                return {
                                    user_id: userId,
                                    id: node.id,
                                    username: node.username,
                                    full_name: node.full_name,
                                    profile_pic_url: node.profile_pic_url
                                }
                            }))
                        })
                    }
                    
        
                } catch(err) {
                    console.log('Invalid Credentials!')
                }
                return followers;
                "
        
            following_s = "let userId = '#{@user_id}';\n" + "let followings = []
                try {

                    let after = null, has_next = true
                    while (has_next) {
                        await fetch(`https://www.instagram.com/graphql/query/?query_hash=d04b0a864b4b54837c0d870b0e77e076&variables=` + encodeURIComponent(JSON.stringify({
                            id: userId,
                            include_reel: true,
                            fetch_mutual: true,
                            first: 50,
                            after: after
                        }))).then(res => res.json()).then(res => {
                            has_next = res.data.user.edge_follow.page_info.has_next_page
                            after = res.data.user.edge_follow.page_info.end_cursor
                            followings = followings.concat(res.data.user.edge_follow.edges.map(({ node }) => {
                                return {
                                    user_id: userId,
                                    id : node.id,
                                    username: node.username,
                                    full_name: node.full_name,
                                    profile_pic_url: node.profile_pic_url
                                }
                            }))
                        })
                    }
        
                } catch(err) {
                    console.log('Invalid Credentials!')
                }
                console.log(followings)
                return followings;
                "
        
        
            @followers = browser.execute_script(follower_s)

            sleep(5)

            @followings = browser.execute_script(following_s)

        end
    end

    def values
        hash = {}
        self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }

        hash
    end
end