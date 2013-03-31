%if assets[0]:
Newly Bought:
<br>
<br>
<table class="portfolio_table table table-bordered table-striped table-hover">
  <thead>
    <tr>
      <th>Market</th>
      <th>Code</th>
      <th>Name</th>
      <th>Quantity</th>
      <th>Current Price</th>
      <th>% Change</th>
    </tr>
  </thead>
  <tbody>
    %for i, asset in enumerate(assets[0]):
    <tr>
      <td>{{ MARKETS[asset.name.market_ref][0] }}</td>
      <td>{{ asset.name.code }}</td>
      <td>{{ asset.name.name }}</td>
      <td>{{ asset.shares }}</td>
      <td>{{ asset.current_price }}</td>
      <td>{{ asset.current_diff }}</td>
    </tr>
    %end
  </tbody>
</table>
%end
%if assets[1]:
Previously Bought:
<br>
<br>
<table class="portfolio_table table table-bordered table-striped table-hover">
  <thead>
    <tr>
      <th>Market</th>
      <th>Code</th>
      <th>Name</th>
      <th>Quantity</th>
      <th>Current Price</th>
      <th>% Change</th>
    </tr>
  </thead>
  <tbody>
    %for i, asset in enumerate(assets[1]):
    <tr>
      <td>{{ MARKETS[asset.name.market_ref][0] }}</td>
      <td>{{ asset.name.code }}</td>
      <td>{{ asset.name.name }}</td>
      <td>{{ asset.shares }}</td>
      <td>{{ asset.current_price }}</td>
      <td>{{ asset.current_diff }}</td>
    </tr>
    %end
  </tbody>
</table>
%end