class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :help, :about, :contact]
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
