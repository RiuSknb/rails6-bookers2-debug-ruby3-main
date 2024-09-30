Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get "home/about"=>"homes#about"
# deviseのルーティングより上にresources :users, ~~~の記述が存在するため、ログインページ(users/sign_in)に
# アクセスをしてもusersのshowページとして呼び出されます。
# usersコントローラーにはログイン制限を掛けているため、ログインページへのリダイレクトが実行され再びログインページが呼び出されますが、これもusersのshowページとして呼び出されます。
# このようにresources :usersの記述が上にあることによりログインページにアクセスしても、usersのshowページとして呼び出されるため無限ループが発生している状態です。
# これを解消するために、devise_forをresources :usersの記述より上にすることでusers/sign_inといったURLはdeviseのコントローラーで処理されるようになります。
  resources :books, only: [:new, :index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create]
  end
  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
