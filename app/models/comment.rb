class Comment < ActiveRecord::Base
	attr_accessible :body, :post_id, :post, :user

	belongs_to :post
	belongs_to :user
	has_many :votes, as: :voteable

	validates :body, :presence => true

	def total_votes
		self.votes.where(vote: true).size - self.votes.where(vote: false).size
	end

end