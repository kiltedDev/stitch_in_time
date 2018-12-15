class ProjectsController < ApplicationController
  before_action :project_params,  only: [:update, :create]

  def show
    @project = Project.find(params[:id])
    @ready = true
    @pretty_time = pretty_time(@project.time_worked)
    if @project.punches.first
      @ready = !@project.punches.first.active?
    end
    @punches = @project.punches.paginate(page: params[:page], per_page: 10)
  end

  def index
    @project  = current_user.projects.build
    @projects = current_user.projects.paginate(page: params[:page], per_page: 10)
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to project_path(@project)
    else
      flash[:error] = "Please enter a name"
      redirect_to user_path(current_user)
    end
  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
