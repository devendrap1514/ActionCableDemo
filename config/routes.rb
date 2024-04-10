Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :sessions, only: %i[] do
    collection do
      post :login
    end
  end

  resources :users, only: %i[create destroy]
  resources :chat_rooms, only: %i[create show] do
    resources :messages, only: %i[index create]
  end
end
