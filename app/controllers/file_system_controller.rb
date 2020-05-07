class FileSystemController < ApplicationController
  def index
    @roots = FileSystem.roots
  end
end
