class Article < ApplicationRecord
  validates :title, :content, presence: true
  has_many :tag_articles, dependent: :destroy
  has_many :tags, through: :tag_articles
  belongs_to :user
end
