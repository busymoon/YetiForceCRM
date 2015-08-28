{*<!-- {[The file is published on the basis of YetiForce Public License that can be found in the following directory: licenses/License.html]} --!>*}
{strip}
	{foreach key=KEY item=SUP_DATA from=$SUP_RECORD_DATA}
		{assign var="DISCOUNT" value=$DISCOUNT + $SUP_DATA['discount']}
		{assign var="TAXS" value=Supplies_SupField_Model::getTaxParam($SUP_DATA['taxparam'],$SUP_DATA['net'], $TAXS)}
	{/foreach}
	<div class="row">
		<div class="col-md-4">
			<table class="table table-bordered suppliesSummaryContainer">
				<thead>
					<tr>
						<th>
							<img src="{vimage_path('Discount24.png')}" alt="{vtranslate('LBL_DISCOUNT', $SUPMODULE)}" />&nbsp;&nbsp;
							<strong>{vtranslate('LBL_DISCOUNTS_SUMMARY',$SUPMODULE)}</strong>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="textAlignRight">
							{CurrencyField::convertToUserFormat($DISCOUNT, null, true)} {$CURRENCY_SYMBOLAND['symbol']}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-4">
			<table class="table table-bordered suppliesSummaryContainer">
				<thead>
					<tr>
						<th colspan="2">
							<img src="{vimage_path('Tax24.png')}" alt="{vtranslate('LBL_TAX', $SUPMODULE)}" />&nbsp;&nbsp;
							<strong>{vtranslate('LBL_TAX_SUMMARY',$SUPMODULE)}</strong>
						</th>
					</tr>
				</thead>
				<tbody>
					{foreach item=TAX key=KEY from=$TAXS}
						{assign var="TAX_AMOUNT" value=$TAX_AMOUNT + $TAX}
						<tr>
							<td class="textAlignRight" width='70px'>
								{$KEY}%
							</td>
							<td class="textAlignRight">
								{CurrencyField::convertToUserFormat($TAX, null, true)} {$CURRENCY_SYMBOLAND['symbol']}
							</td>
						</tr>
					{/foreach}
					<tr>
						<td class="textAlignRight" width='70px'>
							{vtranslate('LBL_AMOUNT',$SUPMODULE)}
						</td>
						<td class="textAlignRight">
							{CurrencyField::convertToUserFormat($TAX_AMOUNT, null, true)} {$CURRENCY_SYMBOLAND['symbol']}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		{if $BASE_CURRENCY['id'] != $CURRENCY}
			{assign var="RATE" value=$BASE_CURRENCY['conversion_rate']/$CURRENCY_SYMBOLAND['rate']}
			<div class="col-md-4">
				<table class="table table-bordered suppliesSummaryContainer">
					<thead>
						<tr>
							<th colspan="2">
								<strong>{vtranslate('LBL_CURRENCIES_SUMMARY',$SUPMODULE)}</strong>
							</th>
						</tr>
					</thead>
					<tbody>
						{foreach item=TAX key=KEY from=$TAXS}
							{assign var="CURRENY_AMOUNT" value=$CURRENY_AMOUNT + $TAX}
							<tr>
								<td class="textAlignRight" width='70px'>
									{$KEY}%
								</td>
								<td class="textAlignRight">
									{CurrencyField::convertToUserFormat($TAX * $RATE, null, true)} {$BASE_CURRENCY['currency_symbol']}
								</td>
							</tr>
						{/foreach}
						<tr>
							<td class="textAlignRight" width='70px'>
								{vtranslate('LBL_AMOUNT',$SUPMODULE)}
							</td>
							<td class="textAlignRight">
								{CurrencyField::convertToUserFormat($CURRENY_AMOUNT * $RATE, null, true)} {$BASE_CURRENCY['currency_symbol']}
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		{/if}
	</div>
{/strip}
