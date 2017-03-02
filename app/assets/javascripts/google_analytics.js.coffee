jQuery ->
  $(document).ready ->
    $('body').on 'click', '#univ-hmbgr', ->
      dataLayer.push({'event': 'hamburger.click'});
      return
