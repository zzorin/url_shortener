Rails.application.routes.draw do
  resources :urls, only: [:create, :show] do
    get 'stats', on: :member
  end

  get '/:id' => "shortener/shortened_urls#show"
end
