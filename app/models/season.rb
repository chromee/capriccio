class Season
  include Ehon

  SPRING = enum 1, name: "春"
  SUMMER = enum 2, name: "夏"
  FALL   = enum 3, name: "秋"
  WINTER = enum 4, name: "冬"
end
