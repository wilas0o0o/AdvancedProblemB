class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites,dependent: :destroy
	has_many :book_comments,dependent: :destroy
	
  scope :created_today, -> { where(created_at: Time.zone.now.all_day)}
	scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day)}
	scope :created_week, -> { where(created_at: (((Time.current.at_end_of_day) - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day))}
	scope :created_lastweek, -> { where(created_at: (((Time.current.at_end_of_day) - 13.day).at_beginning_of_day)..(((Time.current.at_end_of_day) - 7.day).at_end_of_day))}
	
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(content,method)
  	if method == "perfect"
  		Book.where(title: content)
  	elsif method == "forward"
  		Book.where("title LIKE ?", content + "%")
  	elsif method == "backward"
  		Book.where("title LIKE ?", "%" + content)
  	elsif method == "partical"
  		Book.where("title LIKE ?", "%" + content + "%")
  	end
  end
end
