json.extract! project_collaborator, :id, :account_id, :project_id, :role, :created_at, :updated_at
json.url project_collaborator_url(project_collaborator, format: :json)
