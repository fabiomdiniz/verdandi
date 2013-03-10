
var current_total_s;
var current_quantity_s;

var options = {
        lines: {
            show: true
        },
        points: {
            show: true
        },
        xaxis: {
            mode: "time",
            timeformat: "%H:%M",
        }
    };

function update_owned() {
    $.getJSON('/api/num_shares?match=' + match_key + '&query=' + $("#stock_name").val() + ';', function(data) {
        $("#quantity_owned").val(data);
    });
}

function generic_buy_sell(button_id, val) {
    $(button_id).button('loading');
    var jqxhr = $.getJSON('/api/buy_sell?match=' + match_key + '&stock_name=' + current_key + '&num_shares=' +  val + ';', function() {
        update_total(-1*val*parseFloat($('#price').val()));
        $("#quantity").val(0);
        $("#quantity").change();
        $("#quantity_s").val(0);
        $("#quantity_s").change();
        update_owned();
        $(button_id).button('reset');
    }).error(function(e) {
     alert(e);
     $(button_id).button('reset'); 
    });     
}

function generic_fetch(button_id, url) {
    $(button_id).button('loading');
    function onDataReceived(series) {
        $.plot("#placeholder", [series['series']], options);
        update_price(series['latest']);
        $(button_id).button('reset');
    }

    $.ajax({
        url: url + $("#stock_name").val() + ';',
        type: "GET",
        dataType: "json",
        success: onDataReceived,
        error: function() { $(button_id).button('reset'); }
    });
    update_owned();

        
}

$(document).ready(function() {
   // $('.nav-tabs a').on('click', false);
    /*$('.nav-tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
        return false;
    })*/

    //timezoneJS.timezone.zoneFileBasePath = "static/tz";
    //timezoneJS.timezone.defaultZoneFile = [];
    //timezoneJS.timezone.init({async: false});


    $("#fetch_history_day").click(function () {
        options.xaxis.timeformat = "%H:%M";
        options.xaxis.minTickSize = [1, "hour"],
        generic_fetch("#fetch_history_day", '/api/stockhistoryday?stamp=1&query=');
    });

    $("#fetch_history").click(function () {
        options.xaxis.timeformat = "%d/%m";
        options.xaxis.minTickSize = [1, "day"],
        generic_fetch("#fetch_history", '/api/stockhistory?stamp=1&query=');
    });

    $('#quantity_s').bind("keyup change", function(){
        total_value = parseFloat($(this).val())*parseFloat($('#price').val());
        $('#ammount_s').html('$'+numberWithCommas(total_value));
        current_total_s = total_value
        current_quantity_s = $(this).val();
        if(current_quantity_s > 0) {
          total_value = Math.min(original_money, total_value);
          //used_perc = (100*(available_money+total_value)/original_money).toFixed(0);
          sell_perc = (100*(total_value)/original_money).toFixed(0);
          //$("#progressbar").css('width', used_perc +'%');
          $("#sellbar").css('width', sell_perc +'%');
        }
        else {
          $("#sellbar").css('width', '0%');
        }
    });

    $('#buy').click(function() {
        val = parseFloat($("#quantity").val());
        generic_buy_sell('#buy', val);
    });

    $('#sell').click(function() {
        val = -1*parseFloat($("#quantity_s").val());
        generic_buy_sell('#sell', val);
    });

});