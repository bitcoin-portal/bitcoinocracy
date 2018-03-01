$(document).ready(function() {
    window.displayAsCashAddr = function(context, legacyAddress) {
        var cashAddr = bchaddr.toCashAddress(legacyAddress);
        var cashAddrShort = cashAddr.replace('bitcoincash:', '');
        context.html(cashAddrShort);
    };

    window.loopAllAsCashAddr = function() {
        $('.bitcoin-address a, .bitcoin-address span').each(function( index ) {
            var context = $(this);
            var legacyAddress = context.parent().data('legacy-address');
            var currentDisplay = context.parent().data('address-display-format');

            if (bchaddr.isLegacyAddress(legacyAddress) && $('#cash-address-toggle').is(":checked")) {
                window.displayAsCashAddr(context, legacyAddress);
            }
        });
    }

    window.loopAllAsLegacyAddr = function() {
        $('.bitcoin-address a, .bitcoin-address span').each(function( index ) {
            var context = $(this);
            var legacyAddress = context.parent().data('legacy-address');
            context.html(legacyAddress);
        });
    }

    $('#cash-address-toggle').change(function() {
        var context = $(this);
        localStorage.setItem('displayAsCashAddr', context.is(":checked"));

        if (context.is(":checked")) {
            window.loopAllAsCashAddr();
        } else {
            window.loopAllAsLegacyAddr();
        }
    });

    var configDisplayAsCashAddr = localStorage.getItem('displayAsCashAddr') == null ? true : (localStorage.getItem('displayAsCashAddr') == 'true');
    if (configDisplayAsCashAddr) {
        $('#cash-address-toggle').prop('checked', true);
        window.loopAllAsCashAddr();
    } else {
        $('#cash-address-toggle').removeAttr('checked');
        window.loopAllAsLegacyAddr();
    }
});
  