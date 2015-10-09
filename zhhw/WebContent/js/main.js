$(function() {
	var _tabPanel = $("#main");
	$(".easyui-accordion")
			.find("a[link]")
			.each(
					function() {
						$(this)
								.click(
										function() {
											var url = $(this).attr("link");
											var title = $(this).html();
											if (url !== "#" && url !== "") {
												if (!_tabPanel.tabs('exists',
														title)) {
													_tabPanel
															.tabs('add',
																	{
																		title : title,
																		content : '<iframe src="'
																				+ url
																				+ '" style="padding:0;margin:0;border:0;width:100%;height:100%;"></iframe>',
																		closable : true
																	});
													bindfresh(title);
												} else {
													_tabPanel.tabs('select',
															title);
												}
											}
										});
					});// end each
	window.document.addTab = function(url, title) {
		var _tabPanel = $("#main");
		if (!_tabPanel.tabs('exists', title)) {
			_tabPanel
					.tabs(
							'add',
							{
								title : title,
								content : '<iframe src="'
										+ url
										+ '" style="padding:0;margin:0;border:0;width:100%;height:100%;"></iframe>',
								closable : true
							});
			bindfresh(title);
		} else {
			_tabPanel.tabs('select', title);
		}
	}// end window.document.addTab

});// end ready

function goHome() {
	$("#main").tabs('select',"后台首页");
}
function wopen(url) {
	window.open(url,
			'newwindow',
			'height=800,width=1100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
}
function bindfresh(title) {
	/*双击刷新TAB选项卡*/
	$(".tabs-inner").dblclick(function() {
		var _ctab = $('#main').tabs('getTab', title);
		var html = _ctab.html();
		_ctab.html(html);
	});// end $(".tabs-inner").dblclick
}