Rails.application.routes.draw do
  resources :bonus_grades
  resources :buttons, only: %i[index]
  resources :student_device_mappings
  resources :question_responses
  resources :clicks
  resources :lessons do
    resource :evaluate, only: %i[show], controller: :lesson_evaluations do
      put :update_benchmark, path: :benchmark
    end
  end
  resources :questions do
    member { post :stop }
  end
  resources :students do
    member { post :adjust_score }
  end
  resources :school_classes do
    resource :seating_plan, only: %i[update], controller: :school_classes_seating_plans
  end
  resource :current_school_classes, only: %i[update]
  devise_for :users

  resource :lesson_executions do
    resource :seating_plan, only: %i[show], controller: :lesson_executions_seating_plans
  end

  root 'lesson_executions#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
