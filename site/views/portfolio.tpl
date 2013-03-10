<table id="portfolio_table" class="table table-bordered table-striped table-hover">
  <thead>
    <tr>
      <th>Market</th>
      <th>Code</th>
      <th>Name</th>
      <th>Quantity</th>
    </tr>
  </thead>
  <tbody>
    %for i, asset in enumerate(assets):
    <tr>
      <td>{{ MARKETS[asset.name.market_ref][0] }}</td>
      <td>{{ asset.name.code }}</td>
      <td>{{ asset.name.name }}</td>
      <td>{{ asset.shares }}</td>
    </tr>
    %end
  </tbody>
</table>