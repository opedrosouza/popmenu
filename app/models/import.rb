# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Import < ApplicationRecord
  has_one_attached :file
  validates :file, presence: true
  validate :correct_file_mime_type

  def json_read
    JSON.parse(file.download).with_indifferent_access
  end

  private

  def correct_file_mime_type
    if file.attached? && !file.content_type.match("application/json")
      errors.add(:file, "must be a JSON file")
    end
  end
end
