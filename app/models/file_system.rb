class FileSystem < ApplicationRecord
  has_ancestry
  validates :name, presence: true
  has_many_attached :files
end
