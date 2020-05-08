class FileSystemController < ApplicationController
  def index
    @roots = FileSystem.roots
  end

  def create
    if FileSystem.createAndSendFiles(file_system_params)
      flash[:success] = 'Ação efetuada com sucesso'
    else
      flash[:error] = 'Erro na operação, verifique os campos'
    end
    redirect_to root_path
  end

  protected

    def file_system_params
      @file_system_params ||= params.require(:file_system).permit(:name, :files)
    end
end
