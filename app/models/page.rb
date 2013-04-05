class Page < ActiveRecord::Base
  attr_accessible :unique_pageviews, :url
end
