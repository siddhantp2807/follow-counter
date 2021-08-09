class RecordController < ApplicationController

    def followers
        user_id = params[:user_id]
        
        record_ids = Record.where(ig_id: user_id).pluck(:follow_id)

        @records = record_ids.map{ |id| IgUser.find(id) }

        render json: @records
    end

    def followings
        user_id = params[:user_id]

        record_ids = Record.where(follow_id: user_id).pluck(:ig_id)

        @records = record_ids.map{ |id| IgUser.find(id) }

        render json: @records
    end

    def no_follow_back
        user_id = params[:user_id]

        followers = Record.where(ig_id: user_id, unfollowed_at: nil).pluck(:follow_id)
        following = Record.where(follow_id: user_id, unfollowed_at: nil).pluck(:ig_id)

        record_ids = []
        following.difference(followers).each do |user|
            if following.include?(user)
                record_ids << user
            end
        end

        @records = record_ids.map{ |id| IgUser.find(id) }

        render json: @records
    end

    def no_following_back
        user_id = params[:user_id]

        followers = Record.where(ig_id: user_id, unfollowed_at: nil).pluck(:follow_id)
        following = Record.where(follow_id: user_id, unfollowed_at: nil).pluck(:ig_id)

        record_ids = []
        followers.difference(following).each do |user|
            if followers.include?(user)
                record_ids << user
            end
        end

        @records = record_ids.map{ |id| IgUser.find(id) }

        render json: @records
    end

end