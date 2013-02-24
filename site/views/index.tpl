
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

    .hover_text span.spacer {
       padding:0 5px;
    }

    #norn_desc {
        opacity: 0;
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

              <h4>Difficulty</h4>
              <p>
                <div class="btn-group" data-toggle="buttons-radio">
                  <button type="button" class="active btn btn-primary">AI acts every day</button>
                  <button type="button" class="btn btn-primary">AI acts every Friday</button>
                </div>
              </p>

              <h4>Market</h4>
              <p>
                <div class="btn-group" data-toggle="buttons-checkbox">
                  <button type="button" class="btn btn-primary">Ibovespa</button>
                  <button type="button" class="btn btn-primary">Nasdaq-100</button>
                  <button type="button" class="btn btn-primary">Dow Jones Composite</button>
                </div>
              </p>

              <hr>

              <h4>Overflowing text to show optional scrollbar</h4>
              <p>We set a fixed <code>max-height</code> on the <code>.modal-body</code>. Watch it overflow with all this extra lorem ipsum text we've included.</p>
              <p>Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>
              <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.</p>
              <p>Aenean lacinia bibendum nulla sed consectetur. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla.</p>
              <p>Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>
              <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.</p>
              <p>Aenean lacinia bibendum nulla sed consectetur. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla.</p>
            </div>
            <div class="modal-footer">
              <a href="#" class="btn" data-dismiss="modal">Close</a>
              <a href="#" class="btn btn-primary">Save changes</a>
            </div>
          </div>


    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="static/js/jquery.js"></script>
    <script src="static/js/bootstrap.js"></script>
    <script src="static/js/imghover.js"></script>
    <script type="text/javascript">
    $(function (){

        $(".item").on("click", function() {
            if($(".item").index(this) == 0)
            {
                $("img.verdandi").toggleClass('inactive');
            }
        });
    })
    </script>
  </body>
</html>
