class Post
  include Mongoid::Document
  include Mongoid::Pagination
  store_in collection: "post", database: "post"
  field :_id
  field :blog_id
  field :name
  field :words
  field :headings
  field :links
  field :fb
  field :twitter
  field :linkedin
end
  