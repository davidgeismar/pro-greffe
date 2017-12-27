class AdministrationController < ApplicationController
  before_action :authenticate_administrator_user
  layout 'administration'

  def dashboard
  end

  def test
  end


  private

  # Authentification for personal Users
  def authenticate_administrator_user
    if !administrator_signed_in?
      redirect_to new_administrator_session_path(), notice: "Connectez vous en tant que administrateur du site"
      return
    end
    if (!current_administrator.is_admin)
      redirect_to root_path(), notice: "Votre compte administrateur n'est pas encore approuvé"
      return
    end
    # ELse it is good
  end

  def authenticate_si_administrator
    if !administrator_signed_in?
      redirect_to new_administrator_session_path(), notice: "Connectez vous en tant que administrateur du site"
      return
    end
    if !current_administrator.is_admin
      redirect_to root_path(), notice: "Votre compte administrateur n'est pas encore approuvé"
      return
    end
    # ELse it is good
  end


end
