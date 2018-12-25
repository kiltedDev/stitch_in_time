class ProjectsController < ApplicationController
  before_action :project_params,  only: [:update, :create]
  before_action :set_project,  only: [:show, :edit]

  def show
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

  def edit
    @pretty_time = pretty_time(@project.time_worked)
  end

  def update
    if @project.update(project_params)
      @project.check_card
      flash[:success] = "Project updated"
      render 'show'
    else
      render 'edit'
    end

  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end

    def set_project
      @project = Project.find(params[:id])
    end
end
