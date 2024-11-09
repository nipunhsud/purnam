class ProjectCollaboratorsController < ApplicationController
  turbo_only only: %i[new create edit update destroy]

  before_action :set_project
  before_action :set_project_collaborator, only: %i[edit update destroy]
  before_action :set_accounts, only: %i[new create edit update]

  def new
    @project_collaborator = @project.project_collaborators.new
  end

  def create
    @project_collaborator = @project.project_collaborators.new(project_collaborator_params)

    render :new, status: :unprocessable_entity unless @project_collaborator.save
  end

  def edit
  end

  def update
    render :edit, status: :unprocessable_entity unless @project_collaborator.update(project_collaborator_params)
  end

  def destroy
    @project_collaborator.destroy!
  end

  private
    def set_project
      @project = Project.find params.expect(:project_id)
    end

    def set_project_collaborator
      @project_collaborator = @project.project_collaborators.find params.expect(:id)
    end

    def set_accounts
      @accounts = Account.all.excluding @project.collaborators
      @accounts = @accounts.to_a << @project_collaborator.account if @project_collaborator.present?
    end

    def project_collaborator_params
      params.expect(project_collaborator: %i[account_id role])
    end
end
