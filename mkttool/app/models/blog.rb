class Blog
  include Mongoid::Document
  store_in collection: "blog", database: "blog"
  field :name
end
  