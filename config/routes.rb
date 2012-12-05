Myapp::Application.routes.draw do

  devise_for :users

  resources :meetleagues do
      collection do
        get 'add'
      end
      member do
        get 'join'
        #get 'credits'
      end 

  end
  #match '/auth/facebook/callback' => 'authentications#create'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/home/' => 'home#index'
  resources :trackleagues

  resources :leagueusers



  resources :trackusers

  resources :comments

  resources :rankings

  resources :bets

  resources :credits

  resources :horses do
      collection do
        #get ''
      end
      member do
        get 'scratch'
        #get 'credits'
      end 

  end

  match "myleagues" => "users#myleagues", :as => :myleagues
  match "mytracks" => "users#mytracks", :as => :mytracks

 ### Pusher ###############
  match "push_card_message" => "cards#push_message", :as => :push_card_message

  match "card_message" => "cards#message", :as => :card_message
#########################

  resources :leagues  do
      collection do
        #get ''
      end
      member do
        get 'join'
        get 'quit'
        #get 'credits'
      end 

  end


  resources :cards do
      collection do
        #get 'message'
      end
      member do
        get 'close'
        get 'open'
        get 'message'
        #get 'credits'
      end 

  end

  resources :meets do
      collection do
        #get ''
      end
      member do
        get 'refresh_credits'
        #get 'credits'
      end 

  end

  resources :tracks

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  resources :users

  ##### tracks
    resources :tracks do
      collection do
        #get 'members'
      end
      member do
        #get 'users'
        #get 'credits'
      end 
      ### track/meets
      resources :meets do
        collection do
          #get 'members'
        end
        member do
          #get 'users'
        end 
      end ## end resources meets
    end ### resources tracks

  ##### races
    resources :races do
      collection do
       get 'send_message'
        #get 'members'
      end
      member do
        get 'close'
        get 'payout'
        
        #get 'credits'
      end 
      ### track/meets
      #resources :meets do
      #  collection do
          #get 'members'
     #   end
      #  member do
          #get 'users'
      #  end 
      #end ## end resources meets
    end ### resources race


 # end
end
