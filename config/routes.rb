Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      resources :projects, module: 'api/v1'
      resources :project_users, module: 'api/v1'
      resources :tasks, module: 'api/v1'
      devise_for :users, controllers: {registrations: 'api/v1/users/registrations', sessions: 'api/v1/users/sessions' }
      devise_for :organizations, controllers: {registrations: 'api/v1/organizations/registrations', sessions: 'api/v1/organizations/sessions' }      
      
      
    end
  end
end
