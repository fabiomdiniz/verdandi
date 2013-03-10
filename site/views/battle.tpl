
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
                <li><a href="#">Logout</a></li>
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
      <li><a href="#top_generals">Top Generals</a></li>
      <li><a href="#achiev">Achievements</a></li>
      <li><a href="#tables">Tables</a></li>
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
      <h3>You</h3>
      <p>Total Assets Now: {{ mtm_now }}</p>
      <p>Total Assets Before: {{ mtm_before }}</p>
    </div>

    <div class="span4 text-center">
      <h3></h3>
      <p class="versus">Versus</p>
      <p></p>
    </div>

    <div class="span4 text-right">
      <h3>{{ ai_name }}</h3>
      <p>Total Assets Now: {{ ai_mtm_now }}</p>
      <p>Total Assets Before: {{ ai_mtm_before }}</p>
    </div>


  </div>
  
  <div class="row">
    <div class="span6">
      <blockquote>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
        <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
      </blockquote>
    </div>
    <div class="span6">
      <blockquote class="pull-right">
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
        <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
      </blockquote>
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
    <li><a href="#sellbuy" data-toggle="tab">Buy/Sell</a></li>
    <li><a href="#trends" data-toggle="tab">Trends</a></li>
    <li><a href="#settings" data-toggle="tab">???</a></li>
  </ul>
  <div class="tab-content">
  <div class="tab-pane active" id="portfolio">
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
  <div class="tab-pane" id="trends">3</div>
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



<!-- Top Generals
================================================== -->
<section id="top_generals">
  <div class="page-header">
    <h1>Top Generals</h1>
  </div>
  <table class="table table-bordered table-striped">
    <thead>
      <tr>
        <th>Button</th>
        <th>Large Button</th>
        <th>Small Button</th>
        <th>Disabled Button</th>
    <th>Button with Icon</th>
    <th>Split Button</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a class="btn" href="#">Default</a></td>
        <td><a class="btn btn-large" href="#">Default</a></td>
        <td><a class="btn btn-small" href="#">Default</a></td>
        <td><a class="btn disabled" href="#">Default</a></td>
        <td><a class="btn" href="#"><i class="icon-cog"></i> Default</a></td>
    <td>
          <div class="btn-group">
            <a class="btn" href="#">Default</a>
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-primary" href="#">Primary</a></td>
        <td><a class="btn btn-primary btn-large" href="#">Primary</a></td>
        <td><a class="btn btn-primary btn-small" href="#">Primary</a></td>
        <td><a class="btn btn-primary disabled" href="#">Primary</a></td>
        <td><a class="btn btn-primary" href="#"><i class="icon-shopping-cart icon-white"></i> Primary</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-primary" href="#">Primary</a>
            <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-info" href="#">Info</a></td>
        <td><a class="btn btn-info btn-large" href="#">Info</a></td>
        <td><a class="btn btn-info btn-small" href="#">Info</a></td>
        <td><a class="btn btn-info disabled" href="#">Info</a></td>
        <td><a class="btn btn-info" href="#"><i class="icon-exclamation-sign icon-white"></i> Info</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-info" href="#">Info</a>
            <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-success" href="#">Success</a></td>
        <td><a class="btn btn-success btn-large" href="#">Success</a></td>
        <td><a class="btn btn-success btn-small" href="#">Success</a></td>
        <td><a class="btn btn-success disabled" href="#">Success</a></td>
        <td><a class="btn btn-success" href="#"><i class="icon-ok icon-white"></i> Success</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-success" href="#">Success</a>
            <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-warning" href="#">Warning</a></td>
        <td><a class="btn btn-warning btn-large" href="#">Warning</a></td>
        <td><a class="btn btn-warning btn-small" href="#">Warning</a></td>
        <td><a class="btn btn-warning disabled" href="#">Warning</a></td>
        <td><a class="btn btn-warning" href="#"><i class="icon-warning-sign icon-white"></i> Warning</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-warning" href="#">Warning</a>
            <a class="btn btn-warning dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-danger" href="#">Danger</a></td>
        <td><a class="btn btn-danger btn-large" href="#">Danger</a></td>
        <td><a class="btn btn-danger btn-small" href="#">Danger</a></td>
        <td><a class="btn btn-danger disabled" href="#">Danger</a></td>
        <td><a class="btn btn-danger" href="#"><i class="icon-remove icon-white"></i> Danger</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-danger" href="#">Danger</a>
            <a class="btn btn-danger dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
      <tr>
        <td><a class="btn btn-inverse" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse btn-large" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse btn-small" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse disabled" href="#">Inverse</a></td>
        <td><a class="btn btn-inverse" href="#"><i class="icon-random icon-white"></i> Inverse</a></td>
    <td>
          <div class="btn-group">
            <a class="btn btn-inverse" href="#">Inverse</a>
            <a class="btn btn-inverse dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul>
          </div><!-- /btn-group -->
    </td>
      </tr>
    </tbody>
  </table>

</section>


<!-- Achievements
================================================== -->
<section id="achiev">
  <div class="page-header">
    <h1>Achievements</h1>
  </div>

  <div class="row">
    <div class="span10 offset1">

      <form class="well form-search">
        <input type="text" class="input-medium search-query">
        <button type="submit" class="btn">Search</button>
      </form>

        <form class="well form-search">
          <input type="text" class="input-small" placeholder="Email">
          <input type="password" class="input-small" placeholder="Password">
          <button type="submit" class="btn">Go</button>
        </form>


      <form class="form-horizontal well">
        <fieldset>
          <legend>Controls Bootstrap supports</legend>
          <div class="control-group">
            <label class="control-label" for="input01">Text input</label>
            <div class="controls">
              <input type="text" class="input-xlarge" id="input01">
              <p class="help-block">In addition to freeform text, any HTML5 text-based input appears like so.</p>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="optionsCheckbox">Checkbox</label>
            <div class="controls">
              <label class="checkbox">
                <input type="checkbox" id="optionsCheckbox" value="option1">
                Option one is this and that&mdash;be sure to include why it's great
              </label>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="select01">Select list</label>
            <div class="controls">
              <select id="select01">
                <option>something</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="multiSelect">Multicon-select</label>
            <div class="controls">
              <select multiple="multiple" id="multiSelect">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="fileInput">File input</label>
            <div class="controls">
              <input class="input-file" id="fileInput" type="file">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="textarea">Textarea</label>
            <div class="controls">
              <textarea class="input-xlarge" id="textarea" rows="3"></textarea>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="focusedInput">Focused input</label>
            <div class="controls">
              <input class="input-xlarge focused" id="focusedInput" type="text" value="This is focused…">
            </div>
          </div>
          <div class="control-group">
            <label class="control-label">Uneditable input</label>
            <div class="controls">
              <span class="input-xlarge uneditable-input">Some value here</span>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="disabledInput">Disabled input</label>
            <div class="controls">
              <input class="input-xlarge disabled" id="disabledInput" type="text" placeholder="Disabled input here…" disabled>
            </div>
          </div>
          <div class="control-group">
            <label class="control-label" for="optionsCheckbox2">Disabled checkbox</label>
            <div class="controls">
              <label class="checkbox">
                <input type="checkbox" id="optionsCheckbox2" value="option1" disabled>
                This is a disabled checkbox
              </label>
            </div>
          </div>
          <div class="control-group warning">
            <label class="control-label" for="inputWarning">Input with warning</label>
            <div class="controls">
              <input type="text" id="inputWarning">
              <span class="help-inline">Something may have gone wrong</span>
            </div>
          </div>
          <div class="control-group error">
            <label class="control-label" for="inputError">Input with error</label>
            <div class="controls">
              <input type="text" id="inputError">
              <span class="help-inline">Please correct the error</span>
            </div>
          </div>
          <div class="control-group success">
            <label class="control-label" for="inputSuccess">Input with success</label>
            <div class="controls">
              <input type="text" id="inputSuccess">
              <span class="help-inline">Woohoo!</span>
            </div>
          </div>
          <div class="control-group success">
            <label class="control-label" for="selectError">Select with success</label>
            <div class="controls">
              <select id="selectError">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
              </select>
              <span class="help-inline">Woohoo!</span>
            </div>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-primary">Save changes</button>
            <button type="reset" class="btn">Cancel</button>
          </div>
        </fieldset>
      </form>
    </div>
  </div>

</section>

<!-- Tables
================================================== -->
<section id="tables">
  <div class="page-header">
    <h1>Tables</h1>
  </div>
  
  <table class="table table-bordered table-striped table-hover">
    <thead>
      <tr>
        <th>#</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Username</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Mark</td>
        <td>Otto</td>
        <td>@mdo</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Jacob</td>
        <td>Thornton</td>
        <td>@fat</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
      </tr>
    </tbody>
  </table>
</section>


<!-- Miscellaneous
================================================== -->
<section id="miscellaneous">
  <div class="page-header">
    <h1>Miscellaneous</h1>
  </div>

  <div class="row">
    <div class="span4">

      <h3 id="breadcrumbs">Breadcrumbs</h3>
      <ul class="breadcrumb">
        <li class="active">Home</li>
      </ul>
      <ul class="breadcrumb">
        <li><a href="#">Home</a> <span class="divider">/</span></li>
        <li><a href="#">Library</a> <span class="divider">/</span></li>
        <li class="active">Data</li>
      </ul>
    </div>
    <div class="span4">
      <h3 id="pagination">Pagination</h3>
      <div class="pagination">
        <ul>
          <li><a href="#">&larr;</a></li>
          <li class="active"><a href="#">10</a></li>
          <li class="disabled"><a href="#">...</a></li>
          <li><a href="#">20</a></li>
          <li><a href="#">&rarr;</a></li>
        </ul>
      </div>
      <div class="pagination pagination-centered">
        <ul>
          <li class="active"><a href="#">1</a></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">4</a></li>
          <li><a href="#">5</a></li>
        </ul>
      </div>
    </div>
    
    <div class="span4">
      <h3 id="pager">Pagers</h3>
        
        <ul class="pager">
          <li><a href="#">Previous</a></li>
          <li><a href="#">Next</a></li>
        </ul>
        
        <ul class="pager">
          <li class="previous disabled"><a href="#">&larr; Older</a></li>
          <li class="next"><a href="#">Newer &rarr;</a></li>
        </ul>
    </div>
  </div>


  <!-- Navs
  ================================================== -->

  <div class="row">
    <div class="span4">

      <h3 id="tabs">Tabs</h3>
      <ul class="nav nav-tabs">
        <li class="active"><a href="#A" data-toggle="tab">Section 1</a></li>
        <li><a href="#B" data-toggle="tab">Section 2</a></li>
        <li><a href="#C" data-toggle="tab">Section 3</a></li>
      </ul>
      <div class="tabbable">
        <div class="tab-content">
          <div class="tab-pane active" id="A">
            <p>I'm in Section A.</p>
          </div>
          <div class="tab-pane" id="B">
            <p>Howdy, I'm in Section B.</p>
          </div>
          <div class="tab-pane" id="C">
            <p>What up girl, this is Section C.</p>
          </div>
        </div>
      </div> <!-- /tabbable -->
      
    </div>
    <div class="span4">
      <h3 id="pills">Pills</h3>
      <ul class="nav nav-pills">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">Profile</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Dropdown <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
          </ul>
        </li>
        <li class="disabled"><a href="#">Disabled link</a></li>
      </ul>
    </div>
    
    <div class="span4">
      
      <h3 id="list">Lists</h3>
        
      <div class="well" style="padding: 8px 0;">
        <ul class="nav nav-list">
          <li class="nav-header">List header</li>
          <li class="active"><a href="#">Home</a></li>
          <li><a href="#">Library</a></li>
          <li><a href="#">Applications</a></li>
          <li class="nav-header">Another list header</li>
          <li><a href="#">Profile</a></li>
          <li><a href="#">Settings</a></li>
          <li class="divider"></li>
          <li><a href="#">Help</a></li>
        </ul>
      </div>
    </div>
  </div>


<!-- Labels
================================================== -->

  <div class="row">
    <div class="span6">
      <h3 id="labels">Labels</h3>
      <span class="label">Default</span>
      <span class="label label-success">Success</span>
      <span class="label label-warning">Warning</span>
      <span class="label label-important">Important</span>
      <span class="label label-info">Info</span>
      <span class="label label-inverse">Inverse</span>
    </div>
    <div class="span6">
      <h3 id="badges">Badges</h3>
      <span class="badge">Default</span>
      <span class="badge badge-success">Success</span>
      <span class="badge badge-warning">Warning</span>
      <span class="badge badge-important">Important</span>
      <span class="badge badge-info">Info</span>
      <span class="badge badge-inverse">Inverse</span>
    </div>
  </div>
  <br />

<!-- Progress bars
================================================== -->


  <h3 id="progressbars">Progress bars</h3>

  <div class="row">
    <div class="span4">
      <div class="progress">
        <div class="bar" style="width: 60%;"></div>
      </div>
    </div>
    <div class="span4">
      <div class="progress progress-info progress-striped">
        <div class="bar" style="width: 20%;"></div>
      </div>
    </div>
    <div class="span4">
      <div class="progress progress-danger progress-striped active">
        <div class="bar" style="width: 45%"></div>
      </div>
    </div>
  </div>
  <br />


<!-- Alerts & Messages
================================================== -->


  <h3 id="alerts">Alerts</h3>

  <div class="row">
    <div class="span12">
        <div class="alert alert-block">
          <a class="close">&times;</a>
          <h4 class="alert-heading">Alert block</h4>
          <p>Best check yo self, you're not looking too good. Nulla vitae elit libero, a pharetra augue. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</p>
        </div>
    </div>
  </div>
  <div class="row">
    <div class="span4">
      <div class="alert alert-error">
        <a class="close">&times;</a>
        <strong>Error</strong> Change a few things up and try submitting again.
      </div>
    </div>
    <div class="span4">
      <div class="alert alert-success">
        <a class="close">&times;</a>
        <strong>Success</strong> You successfully read this important alert message.
      </div>
    </div>
    <div class="span4">
      <div class="alert alert-info">
        <a class="close">&times;</a>
        <strong>Information</strong> This alert needs your attention, but it's not super important.
      </div>
    </div>
  </div>


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
