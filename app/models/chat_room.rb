class ChatRoom < ApplicationRecord
  self.table_name = :chat_rooms

  belongs_to :user
  has_many :messages

  validates :title, presence: true
end
