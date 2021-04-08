class Api::V1::ProjectUsersController < ApplicationController
before_action :set_project_user, only: %i[ show update destroy ]

# GET /project_users
# GET /project_users.json
def index
  @project_users = ProjectUser.all
end

# GET /project_users/1
# GET /project_users/1.json
def show
end

# POST /project_users
# POST /project_users.json
def create
@project_user = ProjectUser.new(project_user_params)
binding.pry
if @project_user.save
  render json: @project_user , status: :created, location: @project_user
else
  render json: @project_user.errors, status: :unprocessable_entity
end
end

def update
  @project_user = ProjectUser.find_by(id: params[:id])
  if @task.update(project_user_params)
    render json: @project_user 
  else
    render json: @project_user.errors, status: :unprocessable_entity
  end
end

# DELETE /project_users/1
# DELETE /project_users/1.json
def destroy
  @project_user.destroy
  render json: { message: I18n.t('project_user.destroy.success') }, status: 200
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_project_user
    @project_user = ProjectUser.find(params[:id])
    unless @project_user
      render json: { error: I18n.t('project_user.callbacks.set_project_user') }, status: 400
    end 
  end

  # Only allow a list of trusted parameters through.
  def project_user_params
    params.require(:project_user).permit(:project_id, :user_id)
  end
end
