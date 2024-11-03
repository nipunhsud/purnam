class ProjectsController < ApplicationController
  turbo_only only: %i[ new edit ]
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    cols = %w[id name description start_date end_date project_collaborators.role]

    @projects = current_account.projects.joins(:project_collaborators).distinct.select(*cols)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: "Project was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
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

    redirect_to projects_path, status: :see_other, notice: "Project was successfully destroyed."
  end

  private
    def set_project
      @project = Project.find(params.expect(:id))
    end

    def project_params
      params.expect(project: %i[ name description start_date end_date ]).merge(owner_account: current_account)
    end
end
