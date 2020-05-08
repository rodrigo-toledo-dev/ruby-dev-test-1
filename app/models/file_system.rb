class FileSystem < ApplicationRecord
  acts_as_nested_set
  validates :name, presence: true
  has_many_attached :files
end
