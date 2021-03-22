json.extract! task, :id, :name, :description, :status, :project_users_id, :created_at, :updated_at
json.url task_url(task, format: :json)
