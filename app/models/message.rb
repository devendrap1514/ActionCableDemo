class Message < ApplicationRecord
  self.table_name = :messages

  belongs_to :chat_room

  validates :text, presence: true
end
