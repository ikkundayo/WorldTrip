Rails.application.routes.draw do

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
}

  devise_for :users, controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
