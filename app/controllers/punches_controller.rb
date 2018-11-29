class PunchesController < ApplicationController
  before_action :set_project,   only: [:create]
  before_action :set_punch,   only: [:edit, :update, :punch_out, :show]
  before_action :status_check, only: [:show, :edit]

  def create
    @punch = Punch.new(project: @project, time_in: Time.zone.now)
    if @punch.save
      redirect_to edit_punch_path @punch
    else
      redirect_to project_path @project
    end
  end

  def edit
    @project = @punch.project
    if @punch.comment?
      @comment = @punch.comment
    else
      @comment = "Comment here on your work"
    end
  end

  def punch_out
    @punch.time_out = Time.zone.now
    if @punch.save
      redirect_to project_path @punch.project
    else
      render punch_out_path @punch
    end
  end

  private

  def status_check
    if @punch.active?
      redirect_to punch_out_path @punch
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_punch
    @punch = Punch.find(params[:id])
  end
end
