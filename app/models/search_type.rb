class SearchType < ActiveHash::Base
  include ActiveHash::Enum
  enum_accessor :type

  self.data = [
    { id:  1, type: "COMMENT", name: "comment" },
    { id:  2, type: "TAG"    , name: "tag" },
  ]
end
