class FlashMessages
  # usecases:
  # flash.alert = FlashMessages::LORENIPSUN
  # or
  # redirect_to :profiles_path, notice: FlashMessages::LORENIPSUN

  SIGNIN_INVALID_USERNAME = "Usuário não existe"
  SIGNIN_INVALID_PASSWORD = "Senha inválida"
  SIGNIN_SUCCESS = "Conectado à sua conta"
  SIGNOUT_SUCCESS = "Você saiu da sua conta"

  NOT_AUTHENTICATED = "Você precisa estar logado em sua conta"
  NOT_AUTHORIZED = "Você não possui autorização para isso"

  PROFILE_UPDATE_SUCCESS = "Seu perfil foi atualizado"
  PROFILE_UPDATE_ERROR = "Não foi possível atualizar seu perfil"
end