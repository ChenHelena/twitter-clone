class Message < ApplicationRecord
  belongs_to :user
  belongs_to :message_thread
  validates :body, presence: true

  include ActionView::Helpers::DateHelper
  
  def formatted_timestamp
    if (Time.zone.now - created_at) < 1.day
      time_ago_in_words(created_at) + ' ' + 'ago'
    else
      created_at.in_time_zone('Taipei').strftime("%^b %e")
    end
  end
end
