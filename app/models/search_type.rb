class SearchType < ActiveHash::Base
  include ActiveHash::Enum
  enum_accessor :type

  self.data = [
    { id:  1, type: "TAG"    , name: "tag" },
    { id:  2, type: "COMMENT", name: "comment" },
  ]
end
