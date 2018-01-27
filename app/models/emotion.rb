class Emotion < ActiveHash::Base
  self.data = [
    { id:  1, name: "NORMAL"    , ja_name: "普通", icon: "😐" },
    { id:  2, name: "HAPPY"     , ja_name: "笑顔", icon: "😊" },
    { id:  3, name: "EXCIT"     , ja_name: "愉快", icon: "😁" },
    { id:  4, name: "SAD"       , ja_name: "悲壮", icon: "😢" },
    { id:  5, name: "ANGRY"     , ja_name: "怒り", icon: "😡" },
    { id:  6, name: "CONFUSED"  , ja_name: "困惑", icon: "😵" },
    { id:  7, name: "SCARED"    , ja_name: "恐怖", icon: "😱" },
    { id:  8, name: "SHY"       , ja_name: "照れ", icon: "😆" },
    { id:  9, name: "IMPATIENT" , ja_name: "焦り", icon: "😥" },
    { id: 10, name: "WORRY"     , ja_name: "心配", icon: "😓" },
  ]

#真剣
#過酷
end
