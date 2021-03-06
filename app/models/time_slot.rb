class TimeSlot < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :topic
  belongs_to :presenter, class_name: 'User'

  validates :starts_at, presence: true
  validates :ends_at, presence: true

  attr_accessible :topic_id, :ends_at, :meeting_id, :presenter_id, :starts_at

  after_create :select_topic

  def give_points
    topic.give_points_to(presenter)
  end

private

  def select_topic
    topic.mark_as_selected!(meeting)
  end
end
