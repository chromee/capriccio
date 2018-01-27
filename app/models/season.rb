class Season < ActiveHash::Base
  self.data = [
    { id:  1, name: "SPRING", ja_name: "春" },
    { id:  2, name: "SUMMER", ja_name: "夏" },
    { id:  3, name: "FALL"  , ja_name: "秋" },
    { id:  4, name: "WINTER", ja_name: "冬" },
  ]
end
