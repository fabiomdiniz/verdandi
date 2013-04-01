
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Verdandi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Stock Market All-Knowing Maiden">
    <meta name="author" content="Fábio Diniz">

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <link href="static/css/bootstrap.css" rel="stylesheet">
    <link href="static/css/battle.css" rel="stylesheet">
    <link href="static/css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="static/css/font-awesome.min.css" rel="stylesheet">
    <link href="static/css/bootswatch.css" rel="stylesheet">

   <script type="text/javascript">

  //ga code

   </script>

  </head>

  <body class="preview" id="top" data-spy="scroll" data-target=".subnav" data-offset="80">


  <!-- Navbar
    ================================================== -->
  <div class="navbar navbar-fixed-top" id="main_navbar">
    <div class="navbar-inner">
      <div class="container" style="width: auto;">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        <a class="brand" href="#main_navbar">Meyjar Verðandi</a>
        <div class="nav-collapse">
          <!--<ul class="nav">
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>-
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>-->
          <ul class="nav pull-right">
            <form class="navbar-search pull-left" action="">
              <input type="text" class="search-query span2" placeholder="Search">
            </form>
            <li><a href="#">Link</a></li>
            <li class="divider-vertical"></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Settings <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="/surrender?match={{ match_key }};">Surrender</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="{{ logout_url }}">Logout</a></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.nav-collapse -->
      </div>
    </div><!-- /navbar-inner -->
  </div><!-- /navbar -->


    <div class="container" id="main_container">


<!-- Masthead
================================================== -->
<header class="jumbotron subhead" id="overview">
  <div class="row">
    <div class="span6">
      <h1>Meyjar Verðandi</h1>
      <p class="lead">Stock Market All-Knowing Maiden</p>
    </div>
    <div class="span6">
      <div class="bsa well">
          <div id="bsap_1277971" class="bsarocks bsap_c466df00a3cd5ee8568b5c4983b6bb19"></div>
      </div>
    </div>
  </div>
  <div class="subnav">
    <ul class="nav nav-pills">
      <li><a href="#summary">Summary of the Last Battle</a></li>
      <li><a href="#next_strat">Next Strategy</a></li>
      <li><a href="#market_overview">Market Overview</a></li>
      <li><a href="#top_generals">Top Generals</a></li>
      <li><a href="#achiev">Achievements</a></li>
      <li><a href="#miscellaneous">Miscellaneous</a></li>
    </ul>
  </div>
</header>




<!-- Summary
================================================== -->
<section id="summary">
  <div class="page-header">
    <h1>Summary of the Last Battle</h1>
  </div>

  <!-- Headings & Paragraph Copy -->
  <div class="row">
    <div class="span4">

<div class="container-fluid">
  <div class="row-fluid">
    <div class="span8">
      <h3>You</h3>
      <p>Total Assets Now: ${{ format(mtm_now, ',.2f') }}</p>
      <p>Total Assets Before: ${{ format(mtm_before, ',.2f') }}</p>
    </div>
    <div class="span4">
      % if perc >= 0:
      <p class="text-success perc">+
      % else:
      <p class="text-error perc">
      % end
        {{ round(100*perc, 2) }}%
      </p>
    </div>
  </div>
</div>

    </div>

    <div class="span4 text-center">
      <h3></h3>
      % if quote == '':
      <p class="versus">You Win!</p>
      % else:
      <p class="versus">You Lose!</p>
      % end:
      <p></p>
    </div>

    <div class="span4 text-right">

<div class="container-fluid">
  <div class="row-fluid">
    <div class="span4">
      % if ai_perc >= 0:
      <p class="text-success perc">+
      % else:
      <p class="text-error perc">
      % end
        {{ round(100*ai_perc, 2) }}%
      </p>
    </div>
    <div class="span8">
      <h3>{{ ai_name }}</h3>
      <p>Total Assets Now: ${{ format(ai_mtm_now, ',.2f') }}</p>
      <p>Total Assets Before: ${{ format(ai_mtm_before, ',.2f') }}</p>
    </div>
  </div>
</div>



    </div>


  </div>
  
  <div class="row">
    <div class="span6">
    </div>
    <div class="span6">
%if quote != '':
      <blockquote class="pull-right">
        <p>{{ quote }}</p>
        <small>Verdandi</small>
      </blockquote>
%end
    </div>
  </div>

</section>


<!-- Next Strategy
================================================== -->
<section id="next_strat">
  <div class="page-header">
    <h1>Next Strategy</h1>
  </div>
    <ul class="nav nav-tabs">
    <li><a id="portfolio_link" href="#portfolio" data-toggle="tab">Portfolio</a></li>
    <li><a id="ai_portfolio_link" href="#ai_portfolio" data-toggle="tab">AI Portfolio</a></li>
    <li><a href="#sellbuy" data-toggle="tab">Buy/Sell</a></li>
    <li><a id="trends_link" href="#trends" data-toggle="tab">History</a></li>
    <li><a href="#settings" data-toggle="tab">???</a></li>
  </ul>
  <div class="tab-content">
  <div class="tab-pane active" id="portfolio">
  </div>
  <div class="tab-pane" id="ai_portfolio">
  </div>
  <div class="tab-pane well form-horizontal" id="sellbuy">
    <h5 >Available Money: $<span id="money"> 10,000.00</h5>
    <div class="progress">
      <div id="progressbar" class="bar bar-info" style="width: 100%;"></div>
      <div id="buybar" class="bar" style="width: 0%;"></div>
      <div id="sellbar" class="bar bar-success" style="width: 0%;"></div>
    </div>

    <div class="row-fluid">
      <div class="span7">
        <div class="control-group">
          <label class="control-label" for="stock_name">Stock: </label>
          <div class="controls">
            <input autocomplete="off" type="text" class="input-large" id="stock_name">
            <button id="fetch_history_day" type="button" class="btn">Fetch Hourly History</button>
            <button id="fetch_history" type="button" class="btn">Fetch Daily History</button>
          </div>
        </div>
        <div class="demo-container">
          <div id="placeholder" class="demo-placeholder"></div>
        </div>
      </div>
      <div class="span5 buysell_div">
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
        <div class="control-group">
          <label class="control-label" for="price">Quantity Owned: </label>
          <div class="controls">
              <input type="text" disabled class="text-right input-small" id="quantity_owned">
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
        <div class="control-group" id="ammount_s_group">
          <label class="control-label" for="quantity">Quantity: </label>
          <div class="controls">
            <div class="input-append">
              <input type="text" class="text-right input-small" id="quantity_s">
              <span id="ammount_s" class="text-right add-on">$ --,---.--</span>
            </div>
            <button id="sell" type="button" class="btn">Sell</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="tab-pane" id="trends">
      <div id="trends_placeholder"></div>
  </div>
  <div class="tab-pane" id="settings">4</div>
</div>
<!--
  <div class="navbar">
    <div class="navbar-inner">
      <div class="container" style="width: auto;">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        <a class="brand" href="#">Project name</a>
        <div class="nav-collapse">
          <ul class="nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-search pull-left" action="">
            <input type="text" class="search-query span2" placeholder="Search">
          </form>
          <ul class="nav pull-right">
            <li><a href="#">Link</a></li>
            <li class="divider-vertical"></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <div class="navbar navbar-inverse">
    <div class="navbar-inner">
      <div class="container" style="width: auto;">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        <a class="brand" href="#">Project name</a>
        <div class="nav-collapse">
          <ul class="nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-search pull-left" action="">
            <input type="text" class="search-query span2" placeholder="Search">
          </form>
          <ul class="nav pull-right">
            <li><a href="#">Link</a></li>
            <li class="divider-vertical"></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
-->
</section>


<!-- Tables
================================================== -->
<section id="market_overview">
  <div class="page-header">
    <h1>Market Overview</h1>
  </div>
 Coming Soon!
  </section>


<!-- Top Generals
================================================== -->
<section id="top_generals">
  <div class="page-header">
    <h1>Top Generals</h1>
  </div>
  Coming Soon!
  </section>


<!-- Achievements
================================================== -->
<section id="achiev">
  <div class="page-header">
    <h1>Achievements</h1>
  </div>
Coming Soon!
  </section>



<!-- Miscellaneous
================================================== -->
<section id="miscellaneous">
  <div class="page-header">
    <h1>Miscellaneous</h1>
  </div>
Coming Soon!
  </section>

<br><br><br><br>

     <!-- Footer
      ================================================== -->
      <hr>

      <footer id="footer">
        <p class="pull-right"><a href="#top">Back to top</a></p>
        <div class="links">
          <a href="http://github.com/fabiomdiniz/verdandi">Source Code</a>
          <a href="http://flavors.me/fabiomdiniz">Author</a>
        </div>
        Based on the Theme Cyborg Made by <a href="http://thomaspark.me">Thomas Park</a>. Contact him <a href="mailto:hello@thomaspark.me">hello@thomaspark.me</a>.<br/>
        Code licensed under the <a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License v2.0</a>.<br/>
        Made with <a href="http://twitter.github.com/bootstrap/">Bootstrap</a>. Source code hosted on <a href="http://pages.github.com/">GitHub</a>. Icons from <a href="http://fortawesome.github.com/Font-Awesome/">Font Awesome</a>. Web fonts from <a href="http://www.google.com/webfonts">Google</a>. Favicon by <a href="https://twitter.com/geraldhiller">Gerald Hiller</a>.</p>
      </footer>

    </div><!-- /container -->



    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="static/js/jquery.flot.js"></script>
    <script src="static/js/jquery.flot.time.js"></script>
    <script src="static/js/jquery.flot.axislabels.js"></script>
    <script src="static/js/jquery.flot.categories.js"></script>
    <script src="static/js/bootstrap.js"></script>
    <script src="static/js/bootswatch.js"></script>
    <script src="static/js/battle.js"></script>
    <script src="static/js/buysell.js"></script>
    <script type="text/javascript">
    function get_active_markets() {
        return "{{ active_markets }}";
    }
    var original_money = 20000;
    var available_money = {{ money_available }};
    var ai_match_key = '{{ ai_match_key }}';
    var match_key = '{{ match_key }}';
      $(function (){
        update_total(0);
      });
    </script>
  </body>
</html>
