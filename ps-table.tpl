{*
*	The MIT License (MIT)
*
*	Copyright (c) 2015 Emmanuel MARICHAL
*
*	Permission is hereby granted, free of charge, to any person obtaining a copy
*	of this software and associated documentation files (the "Software"), to deal
*	in the Software without restriction, including without limitation the rights
*	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*	copies of the Software, and to permit persons to whom the Software is
*	furnished to do so, subject to the following conditions:
*
*	The above copyright notice and this permission notice shall be included in
*	all copies or substantial portions of the Software.
*
*	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*	THE SOFTWARE.
*}

<script type="riot/tag">

	<ps-table>

		{if $ps_version >= 1.6}

			<form method="post" method="post" class="form-horizontal clearfix">

				<input type="hidden" name="token" value="">

				<div class="panel col-lg-12">

					<div class="panel-heading">
						<i class="{ opts.icon }" if={ opts.icon }></i> { opts.header }
						<span class="badge">{ this.rows.length }</span>
						<span class="panel-heading-action" if={ this.top_actions }>
							<a class="list-toolbar-btn" href="{ this.base_action_url }&action={ elem.action }" title="{ elem.title }" each={ elem, index in this.top_actions }>
								<span data-toggle="tooltip" class="label-tooltip" data-original-title="{ elem.title }" data-html="true" data-placement="top">
									<i class="process-icon-new"></i>
								</span>
							</a>
						</span>
					</div>

					<div class="table-responsive-row clearfix">
						<table class="table">

							<thead>
								<tr class="nodrag nodrop">
									<th each={ elem, index in this.columns } class="{ this.columns_classes[this.columns.indexOf(elem)] }">
										<span class="title_box">
											{ elem.content }
										</span>
									</th>
									<th class="fixed-width-md"></th>
								</tr>
							</thead>

							<tbody>

								<tr class="odd" each={ row, i in this.rows }>
									<td each={ value, key in this.columns_keys } class="{ this.columns_classes[key] }">
										{ row[value] }
									</td>
									<td if={ this.primary_action }>
										<div class="btn-group-action">
											<div class="btn-group pull-right">
												<a href="{ this.base_action_url }&action={ this.primary_action.action }&{ this.identifier }={ row[this.identifier] }" title="{ this.primary_action.title }" class="edit btn btn-default">
													<i class="icon-{ this.primary_action.icon }"></i> { this.primary_action.title }
												</a>
												<button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
													<i class="icon-caret-down"></i>&nbsp;
												</button>
												<ul class="dropdown-menu" if={ this.secondary_actions }>
													<li each={ elem, index in this.secondary_actions }>
														<a href="{ this.base_action_url }&action={ elem.action }&{ this.identifier }={ row[this.identifier] }" title="{ elem.title }">
															<i class="icon-{ elem.icon }"></i> { elem.title }
														</a>
													</li>
												</ul>
											</div>
										</div>
									</td>
								</tr>

							</tbody>

						</table>
					</div>

				</div>

			</form>

		{else}

			<div class="toolbar-placeholder">
				<div class="toolbarBox toolbarHead">

					<ul class="cc_button" if={ this.top_actions }>
						<li each={ elem, index in this.top_actions }>
							<a class="toolbar_btn" href="{ this.base_action_url }&action={ elem.action }" title="{ elem.title }">
								<img src="{ elem.img }"/>
								<div>{ elem.title }</div>
							</a>
						</li>
					</ul>

					<div class="pageTitle">
						<h3>{ opts.header }</h3>
					</div>
				</div>
			</div>

			<form method="post" class="form">

				<table class="table_grid" name="list_table">
					<tbody>
						<tr>
							<td>
								<table class="table" cellpadding="0" cellspacing="0" style="width: 100%; margin-bottom:10px;">
									<thead>
										<tr class="nodrag nodrop" style="height: 40px">
											<th each={ elem, index in this.columns } class="{ this.columns_classes[this.columns.indexOf(elem)] }">
												<span class="title_box">
													{ elem.content }
												</span>
											</th>
											<th></th>
										</tr>
									</thead>

									<tbody>

										<tr class="row_hover" each={ row, i in this.rows }>
											<td each={ value, key in this.columns_keys } class="{ this.columns_classes[key] }">
												{ row[value] }
											</td>

											<td class="right" style="white-space: nowrap;" if={ this.primary_action }>
												<a href="{ this.base_action_url }&action={ this.primary_action.action }&{ this.identifier }={ row[this.identifier] }" title="{ this.primary_action.title }">
													<img src="{ this.primary_action.img }" alt="{ this.primary_action.title }">
												</a>

												<a each={ elem, index in this.secondary_actions } href="{ this.base_action_url }&action={ elem.action }&{ this.identifier }={ row[this.identifier] }" title="{ elem.title }">
													<img src="{ elem.img }" alt="{ elem.title }">
												</a>

											</td>

										</tr>

										<tr if={ this.rows.length == 0 }>
											<td class="center" colspan="{ this.columns.length + 1 }">{ this.opts.noItemsText }</td>
										</tr>

									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>

			</form>

		{/if}

		<style scoped>

			{if $ps_version == '1.5'}

				.help-context-AdminModules {
					display: none !important;
				}

				> .toolbar-placeholder {
					margin-top: 20px;
				}

				> .toolbar-placeholder .pageTitle h3 {
					font-weight: normal;
				}

				> form {
					margin-bottom: 15px;
				}

			{/if}

		</style>

		content = JSON.parse(this.root.getAttribute('content'))

		this.columns = content.columns
		this.rows = content.rows

		this.columns_classes = []
		this.columns_keys = []

		for (var i in this.columns) {
			this.columns_classes.push(this.columns[i].center == true ? 'center' : '')
			this.columns_keys.push(this.columns[i].key)
		}

		this.base_action_url = currentIndex + '&token={Tools::getAdminTokenLite(Context::getContext()->controller->controller_name)}&' + jQuery.param(content.url_params)

		this.primary_action = content.rows_actions.slice(0, 1)[0]
		this.secondary_actions = content.rows_actions.slice(1)

		this.top_actions = content.top_actions

		this.identifier = content.identifier

	</ps-table>

</script>