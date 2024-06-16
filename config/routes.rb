Rails.application.routes.draw do
  devise_for :admins, controllers: {
    # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
    registrations: "admins/registrations",
    sessions: "admins/sessions",
    passwords: "admins/passwords",
    confirmations: "admins/confirmations"
  }
  
#  get "/admin" => "admin/books#index"
  
#  namespace :admin do
#    resources :books
#  end
  
  get 'relationships/followings'
  get 'relationships/followers'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about"=>"homes#about", as: 'about'
#  devise_for :usersの代わりに以下３行。usersのregistrationscontrollerを参照するように
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
#  post 'homes/guest_sign_in', to: 'homes#guest_sign_in'

  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  get "/search" => "searches#search"
  # get '/search', to: 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  
end




                              #     Prefix Verb   URI Pattern                                                                                       Controller#Action
                              #       root GET    /                                                                                                 homes#top
                              # home_about GET    /home/about(.:format)                                                                             homes#about
                              #     books GET    /books(.:format)                                                                                  books#index
                              #           POST   /books(.:format)                                                                                  books#create
                              # edit_book GET    /books/:id/edit(.:format)                                                                         books#edit
                              #       book GET    /books/:id(.:format)                                                                              books#show
                              #           PATCH  /books/:id(.:format)                                                                              books#update
                              #           PUT    /books/:id(.:format)                                                                              books#update
                              #           DELETE /books/:id(.:format)                                                                              books#destroy
                              #     users GET    /users(.:format)                                                                                  users#index
                              # edit_user GET    /users/:id/edit(.:format)                                                                         users#edit
                              #       user GET    /users/:id(.:format)                                                                              users#show
                              #           PATCH  /users/:id(.:format)                                                                              users#update
                              #           PUT    /users/:id(.:format)                                                                              users#update
                              
                #        new_user_session GET    /users/sign_in(.:format)                                                                          devise/sessions#new
                #             user_session POST   /users/sign_in(.:format)                                                                          devise/sessions#create
                #     destroy_user_session DELETE /users/sign_out(.:format)                                                                         devise/sessions#destroy
                #       new_user_password GET    /users/password/new(.:format)                                                                     devise/passwords#new
                #       edit_user_password GET    /users/password/edit(.:format)                                                                    devise/passwords#edit
                #           user_password PATCH  /users/password(.:format)                                                                         devise/passwords#update
                #                         PUT    /users/password(.:format)                                                                         devise/passwords#update
                #                         POST   /users/password(.:format)                                                                         devise/passwords#create
                # cancel_user_registration GET    /users/cancel(.:format)                                                                           devise/registrations#cancel
                #   new_user_registration GET    /users/sign_up(.:format)                                                                          devise/registrations#new
                #   edit_user_registration GET    /users/edit(.:format)                                                                             devise/registrations#edit
                #       user_registration PATCH  /users(.:format)                                                                                  devise/registrations#update
                #                         PUT    /users(.:format)                                                                                  devise/registrations#update
                #                         DELETE /users(.:format)                                                                                  devise/registrations#destroy
                #                         POST   /users(.:format)                                                                                  devise/registrations#create
                
                # book_favorite DELETE /books/:book_id/favorite(.:format)                                                                favorites#destroy
                #               POST   /books/:book_id/favorite(.:format)                                                                favorites#create
                
            # book_book_comment DELETE /books/:book_id/book_comment(.:format)                                                            book_comments#destroy
                            #   POST   /books/:book_id/book_comment(.:format)                                                            book_comments#create
                            
                    # user_relationships DELETE /users/:user_id/relationships(.:format)                                                           relationships#destroy
                    #                     POST   /users/:user_id/relationships(.:format)                                                           relationships#create
                    #     user_followings GET    /users/:user_id/followings(.:format)                                                              relationships#followings
                    #       user_followers GET    /users/:user_id/followers(.:format)                                                               relationships#followers
                    
                        # search GET    /search(.:format)                                                                                 searches#search
                        
              # messages POST           /messages(.:format)                 messages#create
                    # rooms POST        /rooms(.:format)                    rooms#create
                      # room GET        /rooms/:id(.:format)                rooms#show

#  homes_guest_sign_in POST   /homes/guest_sign_in(.:format)                            homes#new_guest

  #      new_admin_session GET    /admins/sign_in(.:format)                                                                         admins/sessions#new
#            admin_session POST   /admins/sign_in(.:format)                                                                         admins/sessions#create
#    destroy_admin_session DELETE /admins/sign_out(.:format)                                                                        admins/sessions#destroy
 #      new_admin_password GET    /admins/password/new(.:format)                                                                    admins/passwords#new
      #edit_admin_password GET    /admins/password/edit(.:format)                                                                   admins/passwords#edit
      #     admin_password PATCH  /admins/password(.:format)                                                                        admins/passwords#update
       #                   PUT    /admins/password(.:format)                                                                        admins/passwords#update
       #                   POST   /admins/password(.:format)                                                                        admins/passwords#create
#cancel_admin_registration GET    /admins/cancel(.:format)                                                                          admins/registrations#cancel
#   new_admin_registration GET    /admins/sign_up(.:format)                                                                         admins/registrations#new
#  edit_admin_registration GET    /admins/edit(.:format)                                                                            admins/registrations#edit
#       admin_registration PATCH  /admins(.:format)                                                                                 admins/registrations#update
#                          PUT    /admins(.:format)                                                                                 admins/registrations#update
#                          DELETE /admins(.:format)                                                                                 admins/registrations#destroy
#                          POST   /admins(.:format)                                                                                 admins/registrations#create
#              admin_books GET    /admin/books(.:format)                                                                            admin/books#index
#                          POST   /admin/books(.:format)                                                                            admin/books#create
#           new_admin_book GET    /admin/books/new(.:format)                                                                        admin/books#new
#          edit_admin_book GET    /admin/books/:id/edit(.:format)                                                                   admin/books#edit
#               admin_book GET    /admin/books/:id(.:format)                                                                        admin/books#show
#                          PATCH  /admin/books/:id(.:format)                                                                        admin/books#update
#                          PUT    /admin/books/:id(.:format)                                                                        admin/books#update
#                          DELETE /admin/books/:id(.:format)                                                                        admin/books#destroy

