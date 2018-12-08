class PunchesController < ApplicationController
  before_action :set_punch,   only: [:edit, :update, :punch_out, :show]
  before_action :set_project,   only: [:create, :update]
  before_action :punch_params,   only: [:update]

  def create
    @punch = Punch.new(project: @project, time_in: Time.zone.now)
    if @punch.save
      @punch.project.check_card
      redirect_to edit_punch_path @punch
    else
      redirect_to project_path @project
    end
  end

  def edit
    @project = @punch.project
    @comment = @punch.comment.blank? ? "Comment here on your work" : @punch.comment

    if @punch.time_worked?
      @pretty_time = pretty_time(@punch.time_worked)
    end
  end

  def update
    if @punch.update_attributes(punch_params)
      @punch.adjust_time
      @punch.project.check_card
      flash[:success] = "Task updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def punch_out
    @punch.time_out = Time.zone.now
    if @punch.save
      @punch.adjust_time
      @punch.project.check_card
      redirect_to project_path @punch.project
    else
      render edit_punch_path @punch
    end
  end

private

  def set_punch
    @punch = Punch.find(params[:id])
  end

  def set_project
    if params[:project_id]
      @project = Project.find(params[:project_id])
    else
      @project = @punch.project
    end
  end

  def punch_params
    params.require(:punch).permit(:comment, :time_in, :time_out)
  end
end
