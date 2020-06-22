class FlashMessages
  # usecases:
  # flash.alert = FlashMessages::LORENIPSUN
  # or
  # redirect_to :profiles_path, notice: FlashMessages::LORENIPSUN
  BOOKMARK_CREATED = "Salvo em minha lista"
  BOOKMARK_CREATE_ERROR = "Não foi possível salvar em minha lista"
  BOOKMARK_REMOVED = "Removido da minha lista"
  BOOKMARK_REMOVE_ERROR = "Não foi possível remover da minha lista"

  NOT_AUTHENTICATED = "Você precisa estar logado em sua conta"
  NOT_AUTHORIZED = "Você não possui autorização para isso"

  PROFILE_UPDATE_SUCCESS = "Seu perfil foi atualizado"
  PROFILE_UPDATE_ERROR = "Não foi possível atualizar seu perfil"
  PROFILE_AVATAR_UPDATE_SUCCESS = "O avatar foi atualizado"
  PROFILE_AVATAR_UPDATE_ERROR = "O avatar não foi atualizado"

  SIGNIN_INVALID_USERNAME = "Usuário não existe"
  SIGNIN_INVALID_PASSWORD = "Senha inválida"
  SIGNIN_SUCCESS = "Conectado à sua conta"
  SIGNOUT_SUCCESS = "Você saiu da sua conta"
  SIGNUP_SUCCESS = "Sua conta foi criada"
  SIGNUP_ALREADY_EXISTS = "Você já possui uma conta, faça o login"
  SIGNUP_PASSWORD_UNMATCH = "As senhas informadas não batem"
end