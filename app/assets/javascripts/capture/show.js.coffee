$ ->
  favBtn = $("#favorite-btn")

  toggle = -> favBtn.toggleClass("fav-expand")
  switchFav = ->
    if(favBtn.text() == "😍")
      favBtn.html "😑"
    else
      favBtn.html "😍"
      toggle()
      setTimeout toggle, 350

  favBtn.on "click", switchFav
