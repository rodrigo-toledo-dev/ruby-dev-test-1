class FileSystem < ApplicationRecord
  acts_as_nested_set
  validates :name, presence: true
  has_many_attached :files

  def self.saveAndAttachFiles(attributes)
    begin
      file_system = FileSystem.new(attributes)
      file_system.save!
      unless attributes.try(:files).nil?
        files.each do |file|
          file_system.files.attach(file)
        end
      end
      true
    rescue => exception
      false
    end
    
  end
end
