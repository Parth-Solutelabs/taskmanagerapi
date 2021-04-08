class TasksController < ApplicationController
  before_action :set_task, only: %i[ show update destroy ]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show                                            
  end

  # POST /tasks
  # POST /tasks.json
  def create
    projusers = ProjectsUser.find(params[:task][:project_users_id])
    @task = projuser.tasks.build(task_params)

    if @task.save
      render json: @task , status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      render json: { message: I18n.t('task.update.success') }, status: 200
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    render json: { message: I18n.t('task.destroy.success') }, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find_by(id: params[:id])
      unless @task
        render json: { error: I18n.t('task.callbacks.set_task') }, status: 400
      end 
    end  

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :status, :project_users_id)
    end
end
