class Movie < ActiveRecord::Base
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :directors
  has_and_belongs_to_many :writers
  has_and_belongs_to_many :actors

  scope :title, -> (title) { where("title ilike ?", "%#{title}%")}
  scope :year, -> (year) { where year: year }
  scope :ms_gt, -> (ms_gt) { where("metascore >= ?","#{ms_gt}")} # metascore greater than
  scope :ms_lt, -> (ms_lt) { where("metascore <= ?","#{ms_lt}")} # metascore greater than
  scope :imdb_gt, -> (imdb_gt) { where("imdb_rating >= ?","#{imdb_gt}")}
  scope :imdb_lt, -> (imdb_lt) { where("imdb_rating <= ?","#{imdb_lt}")}
end
