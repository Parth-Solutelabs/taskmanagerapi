class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy tasks]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  def create
    @project = current_organization.projects.build(project_params)
    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    
    if @project.update(project_params)
      render json: @project 
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    render json: { message: I18n.t('project.destroy.success') }, status: 200
  end

  def tasks
    @tasks = @project.tasks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by(id: params[:id])
      unless @project
        render json: { error: I18n.t('project.callbacks.set_project') }, status: 400
      end
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :organization_id)
    end


end
