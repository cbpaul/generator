var treeVar = {
	// 是否自动展开
	'autoOpenAll' : true,
	// 是否能添加子类
	'isAdd' : true,
	// 是否能删除
	'isDel' : true,
	// 是否能修改
	'isUpdate' : true,
	// 角色ID
	'roleId' : 0
};


function closeOpenTbody(img) {
	var tr_id = "tr_" + ($(img).attr("id"));
	var tr_child = "tr[id^=" + tr_id + "_]";
	if ($(img).attr("src").indexOf("elbow-minus-nl") > 0) {
		// 执行关闭动作
		$(tr_child).each(function(i) {
			$(this).hide();
		});
		$(img).attr("src", "media/tree/tree/elbow-plus-nl.gif");
	} else {
		// 执行展开动作
		setOpenTrChiled(img, tr_child, tr_id);
	}

}

/**
 * @base 打开孩子TR，当没有孩子TR时，去后台查找。
 * @param img
 *            展开 收缩图标<br>
 * @param tr_children
 *            孩子对象<br>
 * @param tr_id
 *            当前tr 的Id
 */
function setOpenTrChiled(img, tr_children, tr_id) {
	$(img).attr("src", "media/tree/tree/elbow-minus-nl.gif");
	if ($(tr_children).length == 0) {
		postGetNode(tr_id);
	} else {
		openTrChild(tr_id);
	}
}

/**
 * 后台获取子节点
 */
function postGetNode(trNodeId) {
	$.post("controller/ManagerRole/getAuthrityListJSON?id="
			+ (trNodeId.substring(trNodeId.lastIndexOf("_") + 1)), {
		roleId : treeVar.roleId
	}, function(json) {
		if (waitAddTrNodeId != "") {
			json[json.length] = addJson[0];
		}
		addTr(trNodeId, json);
		// 继续展开剩下的
		if (treeVar.autoOpenAll) {
			openFirstNode();
		}
	}, "json");
}

var addJson = [ {
	checkstate : "0",
	complete : "false",
	hasChildren : "false",
	id : "",
	isexpand : "false",
	showcheck : "false",
	text : "",
	value : ""
} ];

var waitAddTrNodeId = "";

function addChildTrNode(addNode) {

	if (!treeVar.isAdd) {
		return;
	}

	var parentId = addNode.id.replace("add_", "");
	var trNodeId = addNode.id.replace("add_", "tr_");
	waitAddTrNodeId = trNodeId;
	var imgObj = $("img[id=" + parentId + "]");
	if (!$(imgObj).attr("id")) {
		$("#div_space_" + parentId).after(
				'<img src="media/tree/tree/elbow-minus-nl.gif"  id="'
						+ parentId + '" onclick="closeOpenTbody(this)">');
		$("#div_space_" + parentId).width(
				$("#div_space_" + parentId).width() - 14);
		addTr(trNodeId, addJson);
	} else if ($(imgObj).attr("src").indexOf("plus") > 0) {
		closeOpenTbody(imgObj);
	} else {
		addTr(trNodeId, addJson);
	}

}



function addTr(trNodeId, json) {
	var parentId = trNodeId.replace("tr_", "");
	var parentWidth = $("#" + (trNodeId.replace("tr_", "div_space_"))).width();


	for ( var i = 0; i < json.length; i++) {

		var thisId = parentId + '_' + json[i].id;
		var trHtml = "<tr id='tr_" + thisId + "'><td>";
		trHtml += ('<div id="div_space_' + thisId
				+ '"   style="display: inline-block;width:'
				+ (parentWidth + 30 + (json[i].hasChildren == "true" ? 0 : 14)) + 'px;">&nbsp;</div>');
		if (json[i].hasChildren == "true") {
			trHtml += '<img src="media/tree/tree/elbow-plus-nl.gif"  id="'
					+ thisId + '" onclick="closeOpenTbody(this)">';
		}

		if (json[i].id != "") {
			trHtml += ('<input type="checkbox" name="treeCheckbox"  id="ck_'
					+ thisId + '"  value="' + json[i].id + '" onclick="treeCheckboxClick(this)" >');
		}


		// json[i].id
		trHtml += ('<span id="inSpan_' + thisId + '"    '
				+ (treeVar.isUpdate ? '' : '')
				+ '  >' + json[i].text + '</span>');
		trHtml += "</td></tr>";
		
		var trArr = $("tr[id^=" + trNodeId + "]");
		if(trArr.length == 1){
			$("tr[id=" + trNodeId + "]").after(trHtml);
		}else{
			var lastId = trNodeId;
			$(trArr).each(function(e){
				var id = $(this).attr("id");
				if((id.split(trNodeId+"_")).length > 1){
					lastId = id;
				}
			});
			$("tr[id=" + lastId + "]").after(trHtml);
		}
		if (json[i].checkState > 0) {
			$("#ck_" + thisId).attr("checked", "true");
			treeCheckboxClick($("#ck_" + thisId));
		}


	}
	waitAddTrNodeId = "";
	$("input:checkbox").uniform();
}

/**
 * 
 * 打开孩子tr,孩子的孩子是否打开根据孩子节点的图片来决定
 * 
 */
function openTrChild(parentId) {

	var tr_children = $("tr[id^=" + parentId + "_]");

	for ( var i = 0; i < tr_children.length; i++) {
		var childId = $(tr_children[i]).attr("id");
		var childIdEnds = childId.replace(parentId + "_", "").split("_");
		if (childIdEnds.length == 1) {
			$(tr_children[i]).show();
			var imgs = $(tr_children[i]).children("td").eq(0).children("img");
			if (imgs.length > 0
					&& $(imgs).eq(0).attr("src").indexOf("elbow-minus-nl") > 0) {
				openTrChild(childId);
			}
		}
	}

	if (waitAddTrNodeId != "") {
		addTr(waitAddTrNodeId, addJson);
	}

}

function treeCheckboxClick(treeCheckbox) {
	if (treeCheckbox.checked) {
		// 选中，反选所有父节点,及所有子节点
		$("input[id^=" + treeCheckbox.id + "_]").each(function(i) {
			this.checked = true;
		});
		var checkIdAry = (treeCheckbox.id).split("_");
		var aryLeg = checkIdAry.length;
		for ( var index = aryLeg - 1; index > 1; index--) {
			var parentId = "ck";
			for ( var addIde = 1; addIde < index; addIde++) {
				parentId += ("_" + checkIdAry[addIde]);
			}
			$("#" + parentId).attr("checked", "true");
		}
	} else {
		// 取消选中
		$("input[id^=" + treeCheckbox.id + "_]").each(function(i) {
			this.checked = false;
		});
	}
	$("input:checkbox").uniform();
}



/**
 * 打开第一个关闭的节点
 */
function openFirstNode() {
	var ocImg = $("img[src='media/tree/tree/elbow-plus-nl.gif']:first");
	if (ocImg) {
		$(ocImg).click();
	}
}

