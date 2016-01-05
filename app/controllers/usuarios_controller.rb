class UsuariosController < ApplicationController
  def edit
    @model = Module.const_get("usuario".camelize)
    @crud_helper = Module.const_get("usuario_crud".camelize)
    @record = Usuario.find(params[:id])
    authorize! :update, @record
  end  
  
  def update
    @record = Usuario.find(params[:id])
    authorize! :update, @record
    if @record.update(params_permitt)
      flash[:success] = "Usuário alterado com sucesso."
      redirect_to :root
    else
      @model = Module.const_get("usuario".camelize)
      @crud_helper = Module.const_get("usuario_crud".camelize)
      render action: :edit
    end
  end
  
  private
  def params_permitt
    params.require(:usuario).permit(:email, :password, :password_confirmation)
  end
end