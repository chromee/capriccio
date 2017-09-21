class Season
  include Ehon

  SPRING = enum 0, name: "春"
  SUMMER = enum 1, name: "夏"
  FALL   = enum 2, name: "秋"
  WINTER = enum 3, name: "冬"
end
