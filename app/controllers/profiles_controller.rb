class ProfilesController < ApplicationController

  before_filter :authenticate_person!
#  after_action :verify_authorized

  def index
  end

  def edit
  end

end
