class TasksController < ApplicationController
  before_action :require_signed_in
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks = @project.tasks.all
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = @project.tasks.build(task_params).tap { |task| task.user = current_user }

    if @task.save
      redirect_to project_tasks_url(@project), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to project_tasks_url(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to project_tasks_url(@project), notice: 'Task was successfully destroyed.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title)
    end
end
