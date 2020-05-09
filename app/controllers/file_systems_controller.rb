class FileSystemsController < ApplicationController
  def index
    @roots = FileSystem.roots
  end

  def create
    if file_system = FileSystem.saveAndAttachFiles(file_system_params)
      flash[:success] = 'Ação efetuada com sucesso'
      redirect_to root_path
    else
      flash[:error] = 'Erro na operação, verifique os campos'
      render :index
    end
    
  end

  protected

    def file_system_params
      @file_system_params ||= params.require(:file_system).permit(:name, :parent_id, files: [])
    end
end
