require 'csv'

class ProjectsController < ApplicationController
  before_action :project_params,  only: [:update, :create]
  before_action :set_project,  only: [:show, :edit, :update]

  def show
    @ready = true
    @pretty_time = pretty_time(@project.time_worked)
    @rate = "15.00"
    if @project.punches.first
      @ready = !@project.punches.first.active?
      @rate = '%.2f' % ( @project.estimate / (@project.time_worked / 60 / 60) )
    end
    @punches = @project.punches.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.csv {
        send_data @project.to_csv,
        filename: "#{@project.name.parameterize.underscore}.csv",
        disposition: "inline"
       }
    end
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
    if @project.update_attributes(project_params)
      @project.check_card
      flash[:success] = "Project updated"
      redirect_to project_path @project
    else
      render 'edit'
    end

  end

  private

    def project_params
      params.require(:project).permit(:name, :description, :estimate)
    end

    def set_project
      @project = Project.find(params[:id])
    end
end
