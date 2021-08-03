class Bot < ApplicationRecord
    encrypts :username
    encrypts :password
end
