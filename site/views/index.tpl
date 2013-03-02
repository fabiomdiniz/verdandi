
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Verdandi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="static/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
    body { 
        background: url(static/img/back.png) no-repeat center center fixed; 
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;

    }
    h1 {
        color: black;
        font-size: 100px;
        line-height: 1;
        padding-left: 10px;
    }
    .container {
        width:270px;
        height:150px;
        position:absolute;
        left:50%;
        top:50%;
        margin:-75px 0 0 -135px;
    }
    .jumbotron {
        margin: 80px 0;
        text-align: center;
    }
    .jumbotron .btn {
        font-size: 21px;
        padding: 14px 24px;
    }

    .modal {
        width: 700px;
    }

    .modal-body {
        max-height: 700px;
    }

    .img_wrapper { 
       position: relative; 
       width: 100%; /* for IE 6 */
       cursor:pointer;
    }

    .hover_text { 
       position: absolute; 
       left: 0; 
       width: 100%; 
    }

    .hover_text span { 
       color: white; 
       font: bold 24px/45px; 
       letter-spacing: -1px;  
       background: rgb(0, 0, 0); /* fallback color */
       background: rgba(0, 0, 0, 0.7);
       padding-left: 10%; 
       position: absolute; 
       width: 90%; 
    }

    span.spacer {
       padding:0 5px;
    }

    #norn_desc {
        opacity: 0;
    }

    #portfolio_table td, #portfolio_table th {
        text-align: center;
    }

    .icon-remove {
       cursor:pointer;

    }

    .typeahead.dropdown-menu {
        top: 821px !important; /*Workaround for the typehead, I have no idea how to solve this*/
    }

    </style>

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../assets/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    </head>

  <body>
    <div class="title">
        <h1>Verðandi</h1>
      </div>
    <div class="container">

      <div class="jumbotron">
        <a data-toggle="modal"  id="start_btn" class="btn btn-large btn-info" href="#start">Start Battle</a>
      </div>
</div>
      <div id="start" class="modal hide fade" style="display: none; ">
        <form method="post">

            <div class="modal-header">
              <button class="close" data-dismiss="modal">×</button>
              <h3>Here Comes a New Challenger!</h3>
            </div>
            <div class="modal-body">
              <h4>Choose an Opponent</h4>
              <p>
                <span class="item">
                    <img class="verdandi" src="static/img/verdandi.png"/>
                </span>
                <span class="item">
                    <img class="urdr" src="static/img/urdr.png"/>
                </span>
                <span class="item">
                    <img class="skuld" src="static/img/skuld.png"/>
                </span>
              </p>
              <p id="norn_desc">
                Norn of the present, easy AI
              </p>

              <div class="well form-horizontal">
            <input type="text" name="stock_keys" class="hide" id="stock_keys">
            <input type="text" name="stock_quantities" class="hide" id="stock_quantities">
            <input type="text" name="ai" class="hide" id="ai">
            <input type="text" name="difficulty" class="hide" id="difficulty">
            <input type="text" name="markets" class="hide" id="markets">
              <h4>Difficulty</h4>
              <p>
                <div class="btn-group" data-toggle="buttons-radio">
                  <button type="button" class="active btn btn-primary difficulty_toggle">AI acts every day</button>
                  <button type="button" class="btn btn-primary difficulty_toggle">AI acts every Friday</button>
                </div>
              </p>
              <hr>
              <h4>Markets</h4>
              <p>
                <div class="btn-group" data-toggle="buttons-checkbox">
                  <button type="button" class="market_checks btn btn-primary">Ibovespa</button>
                  <button type="button" class="market_checks btn btn-primary">Nasdaq-100</button>
                  <button type="button" class="market_checks btn btn-primary">Dow Jones Composite</button>
                </div>
              </p>

              <hr>

              <h4>Portfolio</h4>

              <h5 >Available Money: $<span id="money"> 10,000.00</h5>
                  <div class="progress">
                    <div id="progressbar" class="bar" style="width: 100%;"></div>
                </div>
                <br>
                <!--
                <input data-provide="typeahead" type="text" class="input-medium search-query">
                <button id="find_stock" type="button" class="btn">Find Stock</button>
                <span class="spacer"></span>
                Price: <span id="price"> $ --.-- </span>
                <span class="spacer"></span>
                <span class="spacer"></span>
                <span class="spacer"></span>
                Total Ammount: <span id="ammount"> $ --.-- </span>
                <br><br>-->
                    <div class="control-group">
                    <label class="control-label" for="stock_name">Stock: </label>
                    <div class="controls">
                      <input autocomplete="off" type="text" class="input-large" id="stock_name">
                      <button id="find_stock" type="button" class="btn">Find Stock</button>
                    </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="price">Price: </label>
                        <div class="controls">
                            <div class="input-prepend input-append">
                            <span class="add-on">$</span>
                            <input type="text" disabled class="text-right input-small" id="price">
                            <span class="text-right add-on">@ <span id="stock_time">--:--</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="control-group" id="ammount_group">
                    <label class="control-label" for="quantity">Quantity: </label>
                    <div class="controls">
                        <div class="input-append">
                            <input type="text" class="text-right input-small" id="quantity">
                            <span id="ammount" class="text-right add-on">$ --,---.--</span>
                        </div>
                        
                      <button id="buy" type="button" class="btn">Buy</button>
                    </div>
                    </div>


            <table id="portfolio_table" class="table table-bordered table-striped table-hover">
                <thead>
                  <tr>
                    <th>Market</th>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Remove</th>
                  </tr>
                </thead>
                <tbody>
                </tbody>
              </table>


              </div>
            </div>
            <div class="modal-footer">
              <a href="#" class="btn" data-dismiss="modal">Close</a>
              <button type="submit" class="btn btn-primary">Save changes</a>
            </div>
          </form>
          </div>


    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="static/js/jquery.js"></script>
    <script src="static/js/bootstrap.js"></script>
    <script src="static/js/imghover.js"></script>
    <script type="text/javascript">
    var original_money = 10000;
    var available_money = 10000;
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
      $("#progressbar").css('width', (100*available_money/original_money).toFixed(0)+'%');
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
        update_total(-1*current_total);
        stock_keys.push(current_key);
        stock_quantities.push(current_quantity);
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
    function get_active_markets() {
        result = []
        $('.market_checks.active').each(function() {
            result.push($(this).prevAll().length);
        })
        return result.join(';');
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

    $(function (){
        $('#buy').click(add_row);

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

        $("#find_stock").click(function() {
            item = $('#stock_name').val()
            market_code = item.split(" - ")[0];
            //current_name = item.split(" - ")[1];
            current_market = market_code.split(":")[0];
            current_code = market_code.split(":")[1];
            $(this).button('loading');
            $.getJSON('api/stockprice', { query: $("#stock_name").val() }, function(data) {
                $("#price").val(data['value']);
                $("#stock_time").html(data['time']);
                current_price = parseFloat(data['value']);
                current_name = data['name'];
                $("#find_stock").button('reset');
                $("#quantity").val(0);
                $("#quantity").change();
                current_key = data['key'];
            }).error(function() { $("#find_stock").button('reset'); });
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
    </script>
  </body>
</html>
