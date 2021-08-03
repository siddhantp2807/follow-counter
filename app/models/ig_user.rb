class IgUser < ApplicationRecord
    has_many :ig_records, class_name: "Record", foreign_key: 'ig_id'
    has_many :follow_records, class_name: "Record", foreign_key: 'follow_id'
    has_many :notifications

    def self.add_many(arr)

        arr.each do |elmt|
            usr = IgUser.create_or_find_by(id: elmt["id"])
            usr.update(name: elmt["full_name"], username: elmt["username"], profile_pic_url: elmt["profile_pic_url"], updated_at: Time.now)
        end
    end

end
