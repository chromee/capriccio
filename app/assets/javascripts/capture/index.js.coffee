$ ->
  $grid = $('#grid').masonry {
    itemSelector: '.grid-item',
    gutterWidth: 5,
    fitWidth: true,
    isAnimated: true,
    animationOptions: {
      duration: 500,
      easing: 'swing'
    },
  }

  $msnry = $grid.data 'masonry'

  $container = $grid.infiniteScroll {
    path: '.pagination .next a',
    append: '.grid-item',
    outlayer: $msnry,
    scrollThreshold: 10,
    hideNav: '.pagination a[rel=next]',
    status: '.page-load-status',
  }

  relayout = () ->
    $grid.masonry()
  setTimeout relayout, 100
  setTimeout relayout, 1000
  setTimeout relayout, 3000
