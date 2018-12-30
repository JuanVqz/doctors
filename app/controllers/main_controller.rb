class MainController < ApplicationController
  skip_before_action :scope_current_hospital, only: :index

  def index
  end

  def hospital
  end
end
