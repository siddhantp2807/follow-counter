Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :records

  resources :notifications

  get 'record/followers' => "record#followers"
  get 'record/followings' => "record#followings"
  get 'record/no-follow-back' => "record#no_follow_back"
  get 'record/no-following-back' => "record#no_following_back"
end
