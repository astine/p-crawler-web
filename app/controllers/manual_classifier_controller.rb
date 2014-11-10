class ManualClassifierController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sample
    @domain = Domain.limit(-1).skip(rand(Domain.count)).first
  end
end
