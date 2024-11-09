class ProjectStakeholdersController < ApplicationController
  turbo_only only: %i[new create edit update destroy]

  before_action :set_project
  before_action :set_project_stakeholder, only: %i[edit update destroy]
  before_action :set_accounts, only: %i[new create edit update]

  def new
    @project_stakeholder = ProjectStakeholder.new
  end

  def edit
  end

  def create
    @project_stakeholder = @project.project_stakeholders.new(project_stakeholder_params)

    render :new, status: :unprocessable_entity unless @project_stakeholder.save
  end

  def update
    render :edit, status: :unprocessable_entity unless @project_stakeholder.update(project_stakeholder_params)
  end

  def destroy
    @project_stakeholder.destroy!
  end

  private
    def set_project
      @project = Project.find params.expect(:project_id)
    end

    def set_project_stakeholder
      @project_stakeholder = @project.project_stakeholders.find params.expect(:id)
    end

    def set_accounts
      @accounts = Account.all.excluding @project.stakeholders
      @accounts = @accounts.to_a << @project_stakeholder.account if @project_stakeholder.present?
    end

    def project_stakeholder_params
      params.expect(project_stakeholder: [ :account_id ])
    end
end
