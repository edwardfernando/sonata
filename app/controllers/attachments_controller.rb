class AttachmentsController < ApplicationController

  before_filter :authenticate_person!
  after_action :verify_authorized

  def destroy
    attachment = Attachment.where(service: params[:service_id], id: params[:id])
    authorize attachment

    attachment.first.destroy

    respond_to do |format|
      format.html{
        render :nothing => true
      }

      format.js{
      }
    end
  end

end
