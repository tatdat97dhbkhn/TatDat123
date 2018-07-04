class Micropost < ApplicationRecord
  belongs_to :user
  scope :created, ->{where created_at: :asc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_content}
  validate  :picture_size

  private
  def picture_size
    errors.add picture: t(".picture_size") if picture.size > 5.megabytes
  end
end
