class FileSystem < ApplicationRecord
  acts_as_nested_set
  validates :name, presence: true, if: :parent_id_blank?
  has_many_attached :files

  def self.saveAndAttachFiles(attributes)
    return false if attributes[:name].blank? && attributes[:parent_id].blank?
    file_system = FileSystem.new
    if attributes[:name].blank?
      file_system = FileSystem.find(attributes[:parent_id])
      attributes[:parent_id] = nil
    end
    file_system.attributes = attributes
    file_system.save
    file_system
  end

  protected

  def parent_id_blank?
    parent_id.blank?
  end
end
