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
    resource :favorites, only: [:create, :destroy]
    # 単数形にすると、/:idがURLに含まれなくなります。
    # コメント機能では「1人のユーザが１つの投稿に対して何度でもコメントできる」
    # という仕様だったため、destroyをする際にidを受け渡して
    # 「どのコメントを削除するのか」を指定する必要がありました。
    # destroyアクションの場合、URLは'/post_images/:post_image_id/post_comments/:id'
    # ようになっており、URLの最後に/:idが含まれます。コントローラで
    # 「params[:id]」と記述することで、このURLに含まれる:idを取得できるのでした。

    # しかし、いいね機能の場合は「1人のユーザーは1つの投稿に対して1回しか
    # いいねできない」という仕様であるため、destroyをする際にもユーザーidと
    # 投稿(post_image)idが分かれば、どのいいねを削除すればいいのかが特定できます。
    # そのため、いいねのidはURLに含める必要がない(params[:id]を使わなくても良い)ため、
    # resourcesではなくresourceを使ってURLに/:idを含めない形にしています。

    # このように、resourceは「それ自身のidが分からなくても、
    # 関連する他のモデルのidから特定できる」といった場合に用いることが多いです。


    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      post 'follow'       # POSTリクエストでフォローを追加
      delete 'unfollow'   # DELETEリクエストでフォローを解除
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
