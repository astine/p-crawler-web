class ManualClassifierController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def show_page
    @domain = Domain.limit(-1).skip(rand(Domain.count)).first
  end

  def save_classification
    @domain = Domain.find(params[:domain])
    manual_class = {:pornography? => params[:pornography?] == "on",
                    :sexuality? => params[:sexuality?] == "on",
                    :commercial_spam? => params[:commercial_spam?] == "on",
                    :political? => params[:political?] == "on",
                    :terrorism? => params[:terrorism?] == "on",
                    :illegal_activities? => params[:illegal_activities?] == "on"}
    @domain.manual_class = manual_class
    @domain.save
    redirect_to :back
  end
end
