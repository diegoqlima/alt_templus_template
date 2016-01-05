# class OmniauthCallbacksController < Devise::OmniauthCallbacksController
#
#   before_filter :require_no_authentication, only: [:facebook, :linkedin]
#
#   def facebook
#     logar("Facebook")
#   end
#
#   def linkedin
#     logar("LinkedIn")
#   end
#
#   private
#
#   def logar(type)
#     @user = Usuario.from_omniauth(request.env["omniauth.auth"])
#     if @user # verifica usuário existente.
#       set_flash_message(:notice, :success, :kind => type) if is_navigational_format?
#       sign_in_and_redirect(@user, :event => :authentication) #this will throw if @user is not activated
#     else # usuário não existe, então verifica se foi pedido de cadastro
#       if request.env["omniauth.auth"].info.email.blank?
#         flash[:error] = "Você precisa permitir acesso ao e-mail para cadastrar."
#         return redirect_to_origin
#       end
#
#       usuario = Usuario.create_from_social(request.env['omniauth.auth'])
#       if usuario.save
#         flash[:success] = "Sua conta foi criada com seus dados do #{type}"
#         sign_in_and_redirect usuario, :event => :authentication #this will throw if @user is not activated
#       else
#         flash[:error] = "Não foi possível criar sua conta: #{usuario.errors.full_messages.to_sentence}."
#         redirect_to_origin
#       end
#     end
#   end
#
#   def redirect_to_origin
#     return redirect_to(request.env['omniauth.origin'] || root_url)
#   end
# end