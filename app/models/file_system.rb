class FileSystem < ApplicationRecord
  acts_as_nested_set
  validates :name, presence: true
  has_many_attached :files

  def self.saveAndAttachFiles(attributes)
    if attributes[:parent_id].blank?
      file_system = FileSystem.new(attributes)
    else
      if attributes[:name].blank?
        file_system = FileSystem.find(attributes[:parent_id])
        attributes[:parent_id] = nil
      else
        file_system = FileSystem.new(attributes)
      end
    end
    
    file_system.save
    unless attributes[:file].nil?
      file_system.files.attach(attributes[:file])
    end
    file_system
  end
end
