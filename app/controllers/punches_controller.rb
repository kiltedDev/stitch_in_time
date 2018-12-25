class PunchesController < ApplicationController
  before_action :set_punch,     only: [:edit, :update, :punch_out, :show, :destroy]
  before_action :set_project,   only: [:create, :update, :destroy]
  before_action :check_active,  only: [:create]
  before_action :punch_params,  only: [:update]

  def create
    time_in = Time.zone.now
    @punch = Punch.new(project: @project, time_in: Time.zone.now)
    if @punch.save
      @punch.project.check_card
      @timer_props = { start_time: time_in.to_datetime.strftime("%Q").to_i }
      render 'edit'
    else
      render 'edit'
    end
  end

  def edit
    @project = @punch.project
    @comment = @punch.comment.blank? ? "Comment here on your work" : @punch.comment
    @pretty_time = pretty_time(@punch.time_worked)
    @timer_props = { start_time: @punch.time_in.to_datetime.strftime("%Q").to_i }
  end

  def update
    if @punch.update(punch_params)
      @punch.adjust_time
      @punch.project.check_card
      flash[:success] = "Task updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    Punch.find(params[:id]).destroy
    flash[:success] = "Punch deleted"
    redirect_to project_path @project
  end

  def punch_out
    @punch.time_out = Time.zone.now
    if @punch.save
      @punch.adjust_time
      @punch.project.check_card
      redirect_to project_path @punch.project
    else
      render 'edit'
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

  def check_active
    if @project.punches.first && @project.punches.first.active?
      redirect_to edit_punch_path @project.punches.first
    end
  end

  def punch_params
    params.require(:punch).permit(:comment, :time_in, :time_out)
  end
end
