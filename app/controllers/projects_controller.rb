class ProjectsController < ApplicationController

  def show
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to user_path(current_user)
    else
      render 'static_pages/home'
    end
  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
