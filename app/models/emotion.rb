class Emotion
  include Ehon

     HAPPY = enum 1, name: "幸福", icon: "😊"
     EXCIT = enum 2, name: "愉快", icon: "😁"
       SAD = enum 3, name: "悲壮", icon: "😢"
     ANGRY = enum 4, name: "怒り", icon: "😡"
  CONFUSED = enum 5, name: "困惑", icon: "😵"
    SCARED = enum 6, name: "恐怖", icon: "😱"
       SHY = enum 7, name: "照れ", icon: "😆"
 IMPATIENT = enum 8, name: "焦り", icon: "😥"
     WORRY = enum 9, name: "心配", icon: "😓"
   SERIOUS = enum 10, name: "真面目", icon: "😐"
#心配
#真面目
#過酷
end
