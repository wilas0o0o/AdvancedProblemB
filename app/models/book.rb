class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites,dependent: :destroy
	has_many :book_comments,dependent: :destroy
	
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2days_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3days_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4days_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5days_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6days_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前
	
	
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
