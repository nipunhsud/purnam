class ProjectsController < ApplicationController
  turbo_only only: %i[new create edit update destroy]

  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @collaboration_projects = current_account.collaboration_projects
  end

  def stakeholder
    @stakeholder_projects = current_account.stakeholder_projects
  end

  def show
    @collaborators = @project.project_collaborators.includes(:account)
    @stakeholders = @project.project_stakeholders.includes(:account)
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    render :new, status: :unprocessable_entity unless @project.save
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy!
  end

  private
    def set_project
      @project = Project.find(params.expect(:id))
    end

    def project_params
      params.expect(project: %i[name description start_date end_date]).merge(owner_account: current_account)
    end
end
