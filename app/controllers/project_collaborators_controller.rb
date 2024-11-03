class ProjectCollaboratorsController < ApplicationController
  before_action :set_project_collaborator, only: %i[ show edit update destroy ]

  # GET /project_collaborators or /project_collaborators.json
  def index
    @project_collaborators = ProjectCollaborator.all
  end

  # GET /project_collaborators/1 or /project_collaborators/1.json
  def show
  end

  # GET /project_collaborators/new
  def new
    @project_collaborator = ProjectCollaborator.new
  end

  # GET /project_collaborators/1/edit
  def edit
  end

  # POST /project_collaborators or /project_collaborators.json
  def create
    @project_collaborator = ProjectCollaborator.new(project_collaborator_params)

    respond_to do |format|
      if @project_collaborator.save
        format.html { redirect_to @project_collaborator, notice: "Project collaborator was successfully created." }
        format.json { render :show, status: :created, location: @project_collaborator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project_collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_collaborators/1 or /project_collaborators/1.json
  def update
    respond_to do |format|
      if @project_collaborator.update(project_collaborator_params)
        format.html { redirect_to @project_collaborator, notice: "Project collaborator was successfully updated." }
        format.json { render :show, status: :ok, location: @project_collaborator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project_collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_collaborators/1 or /project_collaborators/1.json
  def destroy
    @project_collaborator.destroy!

    respond_to do |format|
      format.html { redirect_to project_collaborators_path, status: :see_other, notice: "Project collaborator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_collaborator
      @project_collaborator = ProjectCollaborator.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_collaborator_params
      params.expect(project_collaborator: [ :account_id, :project_id, :role ])
    end
end
