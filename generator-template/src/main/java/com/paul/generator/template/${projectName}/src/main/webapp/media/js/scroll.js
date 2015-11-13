(function($) {
	var defaults = {
		contentNode 	: "ul",
		listNode	 	: "li",
		size			: 3
	};
	var delay = 2000;
	var scrollTimer = null;
	var settings = {};
	$.fn.scroll = function(options) {
		var $this=$(this);
		$.extend(settings, defaults, options);
		$this.each(function(index) {
			if($this.find(settings.listNode).size()>settings.size){
				var thidNode = $($this.get(index));
				var $ulNode = thidNode.find(settings.contentNode);
				var outerHeight = $ulNode.find(settings.listNode + ':first').outerHeight(true);
				console.info(outerHeight);
				thidNode.css("height",(settings.size*outerHeight)+"px");
				$($this.get(index)).hover(function() {
					clearInterval(scrollTimer);
				}, function() {
					scrollTimer = setInterval(function() {
						Scroll.scroll($($this.get(index)));
					}, delay);
				}).triggerHandler('mouseout');
			}
		});
	};
	var Scroll = {
		scroll : function(node) {
			var $ulNode = node.find(settings.contentNode);
			var $lineHeight = $ulNode.find(settings.listNode + ':first').height();
			$ulNode.animate({
				'marginTop' : -$lineHeight + 'px'
			}, 600, function() {
				$ulNode.css({
					'margin' : '0 0 0 10px'
				}).find(settings.listNode + ':first').appendTo($ulNode);
			});
		}
	};
})(jQuery);
