class Emotion
  include Ehon

     HAPPY = enum 0, name: "幸せ"
  　   SAD = enum 1, name: "悲しい"
     ANGRY = enum 2, name: "怒"
     EXCIT = enum 3, name: "楽しい"
  CONFUSED = enum 4, name: "困惑"
    SCARED = enum 5, name: "恐怖"
end
