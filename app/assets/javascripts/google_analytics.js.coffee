jQuery ->
  $(document).on 'page:change', ->
    if window.ga?
      ga('set',  'location', location.href.split('#')[0])
      ga('send', 'pageview', { "title": document.title })

  $('body').on 'click', '#univ-hmbgr', ->
    ga 'send', 'event', 'Universal Hamburger', 'Click'
    return
