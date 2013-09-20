class Search
  include Mongoid::Document
def self.search(search)
  return "OLA"
  #search_condition = "%" + search + "%"
  #find(:all, :conditions => ['title LIKE ? OR descriptin LIKE ?', search_condition, search_condition])
end
end