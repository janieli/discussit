class Comment < ActiveRecord::Base
	attr_accessible :commenter, :body, :post_id, :post, :user

	belongs_to :post
	belongs_to :user

	validates :body, :presence => true
end