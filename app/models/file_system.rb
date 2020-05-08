class FileSystem < ApplicationRecord
  acts_as_nested_set
  validates :name, presence: true
  has_many_attached :files

  def saveAndAttachFiles(files=nil)
    self.save
    unless files.nil?
      files.each do |file|
        self.files.attach(file)
      end
    end
  end
end
