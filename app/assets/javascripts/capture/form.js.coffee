# Animeサジェスト
window.animeSuggest = (animes) ->
  new Suggest.Local(
    "anime-text",
    "anime-suggest",
    animes,
    {
      dispMax: 10,
      interval: 1000,
      listTagName: "li",
      classMouseOver: "over list-group-item",
      classSelect: "select list-group-item",
      defaultClass: "list-group-item"
    })

# 画像読み込み
window.fileRead = ->
  $("#picture").change ->
    $('#pictureCoverTextField').val $(this).val()

  $("#browser-btn").on "click", ->
    $("#picture").click()

  $('form').on 'change', 'input[type="file"]', (e) ->
    file = e.target.files[0]
    reader = new FileReader()
    $preview = $(".cap-image")

    # 画像ファイル以外の場合は何もしない
    if file.type.indexOf("image") < 0
      return false

    # ファイル読み込みが完了した際のイベント登録
    reader.onload = ((file) ->
      return (e) ->
        $preview.empty() # 既存のプレビューを削除
        # .prevewの領域の中にロードした画像を表示するimageタグを追加
        img = $('<img>').attr({src: e.target.result, class: "cap-image center", title: file.name})
        $preview.append(img)
    )(file);

    reader.readAsDataURL(file)