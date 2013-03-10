
    var current_market;
    var current_code;
    var current_name;
    var current_price;
    var current_quantity;
    var current_total;
    var current_key = '';

    var stock_keys = []
    var stock_quantities = []

    function update_forms() {
      $("#stock_quantities").val(stock_quantities.join(';'));
      $("#stock_keys").val(stock_keys.join(';'));
    }

    function update_total(value) {
      available_money = available_money + value;
      used_perc = (100*available_money/original_money);
      $("#progressbar").css('width', used_perc +'%');
      //$("#usedbar").css('width', (100-used_perc) +'%');
      $("#money").html(numberWithCommas(available_money));
    }

    function add_row() {
      if((available_money - current_total) < 0 || parseFloat(current_quantity) <= 0)
      {
        $("#ammount_group").addClass("error");
        return;
      }
      if(current_key != '')
      {
        $("#ammount_group").removeClass("error");
        $('#portfolio_table').append('<tr>' +
                                     '<td>' + current_market + '</td>' +
                                     '<td>' + current_code + '</td>' +
                                     '<td>' + current_name + '</td>' +
                                     '<td>' + current_price + '</td>' +
                                     '<td>' + current_quantity + '</td>' +
                                     '<td>' + numberWithCommas(current_total) + '</td>' +
                                     '<td><i class="icon-remove"></i></td>' +
                                     '</tr>');
        stock_keys.push(current_key);
        stock_quantities.push(current_quantity);
        update_total(-1*current_total);
        $("#quantity").val(0);
        $("#quantity").change();
        update_forms();
      }
    }

    function Integer(v){
        return v.replace(/\D/g,"")
    }

    function numberWithCommas(x) {
        if(isNaN(x)) {
          return '--.--';
        }
        x = Math.round(x*100)/100 
        x = x.toString();
        var pattern = /(-?\d+)(\d{3})/;
        while (pattern.test(x))
            x = x.replace(pattern, "$1,$2");
        return x;
    }


    function remove_row(row) {
          price = row.find('td:eq(3)').html();
          quantity = row.find('td:eq(4)').html();
          update_total(parseFloat(price)*parseFloat(quantity));
          stock_keys.splice(row.prevAll().length, 1);
          stock_quantities.splice(row.prevAll().length, 1);
          update_forms();
          row.remove();
    }

    function update_price(data) {
          item = $('#stock_name').val()
          market_code = item.split(" - ")[0];
          //current_name = item.split(" - ")[1];
          current_market = market_code.split(":")[0];
          current_code = market_code.split(":")[1];
          $("#price").val(data['value']);
          $("#stock_time").html(data['time']);
          current_price = parseFloat(data['value']);
          current_name = data['name'];
          $("#quantity").val(0);
          $("#quantity").change();
          $("#quantity_s").val(0);
          $("#quantity_s").change();
          current_key = data['key'];
    }

    $(function (){

        $('.market_checks').click(function() {
          setTimeout(function() {
          current_key = '';
          $("#markets").val(get_active_markets());
          $('.market_checks:not(.active)').each(function (){
              market_str = $(this).html();
              $('#portfolio_table td:nth-child(1)').each(function (){
                if($(this).html() == market_str) {
                  remove_row($(this).parent());
                }

              });
        }); }, 100);
        })

        $('#portfolio_table tbody').on('click', '.icon-remove', function() {
          remove_row($(this).parent().parent());
        })

        $('#quantity').bind("keyup change", function(){
            total_value = parseFloat($(this).val())*parseFloat($('#price').val());
            $('#ammount').html('$'+numberWithCommas(total_value));
            current_total = total_value
            current_quantity = $(this).val();
            if(total_value >= 0) {
              total_value = Math.min(available_money, total_value);
              used_perc = (100*(available_money-total_value)/original_money);
              buy_perc = (100*(total_value)/original_money);
              $("#progressbar").css('width', used_perc +'%');
              $("#buybar").css('width', buy_perc +'%');
            }
        });

        $('#stock_name').typeahead({
            source: function (query, process) {
                current_key = '';
                return $.getJSON(
                    'api/stockname',
                    { query: query,
                      markets: get_active_markets() },
                    function (data) {
                        return process(data);
                    });
            },
            updater: function(item) {
                market_code = item.split(" - ")[0];
                //current_name = item.split(" - ")[1];
                current_market = market_code.split(":")[0];
                current_code = market_code.split(":")[1];
                return market_code;
            } 

        });


        $(".item").on("click", function() {
            var idx = $(".item").index(this);
            if(idx == 0)
            {
                $("img.verdandi").toggleClass('inactive');
                $("#ai").val(idx);
            }
        });

        $(".difficulty_toggle").click(function() {
          $("#difficulty").val($(this).prevAll().length);
        })
        $(".difficulty_toggle:eq(0)").click();
        $('.market_checks:eq(0)').click();
    })