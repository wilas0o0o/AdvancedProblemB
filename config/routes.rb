Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get "search" => "searches#search"
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only: [:create,:destroy]
    get "followings" => "relationships#followings",as: "followings"
    get "followers" => "relationships#followers",as: "followers"
    get "search" => "users#search"
  end
  resources :books do
    resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create,:destroy]
  end
end