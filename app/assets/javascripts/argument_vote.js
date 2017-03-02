$(document).ready(function() {
  $('#vote-agree').click(function() {
    activateButton($(this));
    updateStatement('agree');
    dataLayer.push({'event': 'argument.vote.agree'});
  });

  $('#vote-doubt').click(function() {
    activateButton($(this));
    updateStatement('doubt');
    dataLayer.push({'event': 'argument.vote.doubt'});
  });

  var activateButton = function(button) {
    $('#vote-form').slideDown(300);
    button
    .removeClass('inactive')
    .siblings().addClass('inactive');
  }

  var updateStatement = function(statement) {
    var newStatement;
    switch(statement) {
      case 'agree':
        newStatement = $('#pro_statement').val();
        $('#signature_negation').val('false');
        break;
      case 'doubt':
        newStatement = $('#con_statement').val();
        $('#signature_negation').val('true');
        break;
      default:
        newStatement = '';
    }
    $('#argument-statement').html(newStatement);
  }

  var clipboard = new Clipboard('.button-copy');

  clipboard.on('success', function(e) {
    dataLayer.push({'event': 'argument.copy.successful'});
    displayCopySuccess();
    e.clearSelection();
  });

  clipboard.on('error', function(e) {
  dataLayer.push({'event': 'argument.copy.failed'});
    displayHighlightSuccess();
  });

  var selectElementContents = function(el) {
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
  }

  $('#argument-statement').click(function() {
    dataLayer.push({'event': 'argument.statement.click'});
    var el = document.getElementById("argument-statement");
    selectElementContents(el);
  });

  var displayCopySuccess = function() {
    $.magnificPopup.open({
      items: {
        src: '#copied-successfully',
        type: 'inline'
      },
      fixedContentPos: false,
      fixedBgPos: true,
      overflowY: 'auto',
      closeBtnInside: true,
      preloader: false,
      midClick: true,
      removalDelay: 300,
      mainClass: 'my-mfp-zoom-in'
    }, 0);
  };

  var displayHighlightSuccess = function() {
    $.magnificPopup.open({
      items: {
        src: '#highlighted-successfully',
        type: 'inline'
      },
      fixedContentPos: false,
      fixedBgPos: true,
      overflowY: 'auto',
      closeBtnInside: true,
      preloader: false,
      midClick: true,
      removalDelay: 300,
      mainClass: 'my-mfp-zoom-in'
    }, 0);
  };
});
