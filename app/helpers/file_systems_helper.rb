module FileSystemsHelper
  def file_system_options
    nested_set_options(FileSystem) {|i| "#{'--' * i.level} #{i.name} (#{i.files.count} arquivo(s))" }
  end
end
