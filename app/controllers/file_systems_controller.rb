class FileSystemsController < ApplicationController
  def index
    @roots = FileSystem.roots
    @file_system = FileSystem.new
  end

  def create
    if FileSystem.saveAndAttachFiles(file_system_params)
      flash[:success] = 'Ação efetuada com sucesso'
    else
      flash[:error] = 'Erro na operação, verifique os campos'
    end
    redirect_to root_path
  end

  protected

    def file_system_params
      @file_system_params ||= params.require(:file_system).permit(:name, :parent_id, :file)
    end
end
