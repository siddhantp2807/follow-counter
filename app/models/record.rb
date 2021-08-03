class Record < ApplicationRecord
    belongs_to :ig, class_name: 'IgUser'
    belongs_to :follow, class_name: 'IgUser'

    def self.dynamic_followers(arr)
        iguser_id = arr.first["user_id"].to_i

        recs = Record.where(ig_id: iguser_id, unfollowed_at: nil).map {|rec| rec.follow_id.to_i}
        follower_ids = arr.map {|follow| follow["id"].to_i}

        new_follows = follower_ids.difference(recs)

        new_follows.each do |follow|

            found = Record.where(ig_id: iguser_id, follow_id: follow).first
            usr = IgUser.find(follow)
            if found.nil? 
                Record.create(ig_id: iguser_id, follow_id: follow, followed_at: Time.now, unfollowed_at: nil)
                Notification.create(title: "New Follower", message: "#{usr.name} (#{usr.username}) started following you!", ig_user_id: iguser_id, profile_pic_url: usr.profile_pic_url)
            elsif found.unfollowed_at.nil?
                found.update(unfollowed_at: Time.now)
                Notification.create(title: "Lost Follower", message: "#{usr.name} (#{usr.username}) unfollowed you!", ig_user_id: iguser_id, profile_pic_url: usr.profile_pic_url)
            else
                found.update(followed_at: Time.now, unfollowed_at: nil)
                Notification.create(title: "New Follower", message: "#{usr.name} (#{usr.username}) started following you!", ig_user_id: iguser_id, profile_pic_url: usr.profile_pic_url)
            end
            
        end

    end

    def self.static_followers(arr)
        iguser_id = arr.first["user_id"]

        recs = Record.where(ig_id: iguser_id, unfollowed_at: nil).map {|rec| rec.follow_id}
        follower_ids = arr.map {|follow| follow["id"]}

        new_follows = follower_ids.intersection(recs)

        new_follows.each do |follow|

            found = Record.where(ig_id: iguser_id, follow_id: follow, unfollowed_at: nil)
            
            found.first.update(updated_at: Time.now)
        end

    end

    def self.dynamic_following(arr)

        iguser_id = arr.first["user_id"]

        recs = Record.where(follow_id: iguser_id, unfollowed_at: nil).map {|rec| rec.ig_id}
        following_ids = arr.map {|follow| follow["id"]}

        new_followings = following_ids.difference(recs)

        new_followings.each do |follow|

            found = Record.where(follow_id: iguser_id, ig_id: follow, unfollowed_at: nil).first
            usr = IgUser.find(follow)
            if found.nil?
                Record.create(follow_id: iguser_id, ig_id: follow, followed_at: Time.now, unfollowed_at: nil)
                Notification.create(title: "New Following", message: "You started following #{usr.name} (#{usr.username}).", ig_user_id: iguser_id, profile_pic_url: usr.profile_pic_url)
            elsif found.unfollowed_at.nil?
                found.update(unfollowed_at: Time.now)
                Notification.create(title: "You unfollowed someone", message: "You unfollowed #{usr.name} (#{usr.username}).", ig_user_id: iguser_id, profile_pic_url: usr.profile_pic_url)
            else
                found.update(followed_at: Time.now, unfollowed_at: nil)
                Notification.create(title: "New Following", message: "You started following #{usr.name} (#{usr.username}).", ig_user_id: iguser_id, profile_pic_url: usr.profile_pic_url)
            end
            
        end

    end

    def self.static_following(arr)

        iguser_id = arr.first["user_id"]

        recs = Record.where(follow_id: iguser_id, unfollowed_at: nil).map {|rec| rec.ig_id}
        following_ids = arr.map {|follow| follow["id"]}

        new_followings = following_ids.intersection(recs)

        new_followings.each do |follow|

            found = Record.where(follow_id: iguser_id, ig_id: follow, unfollowed_at: nil)
            
            found.first.update(updated_at: Time.now)
        end

    end

end
