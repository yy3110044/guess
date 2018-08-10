var empty = function(str) {
	return str == null || "" == str;
};

/**
 * obj.url：链接
 * obj.data：参数
 * obj.success：回功回调函数
 * obj.error：失败回调函数
 * obj.redirectCode：跳转代码，默认为200
 * obj.redirectUrl：跳转url
 */
var loadData = function(obj) {
	$.ajax({
		"type" : "POST",
		"cache" : false,
		"async" : true,
		"contentType" : "application/x-www-form-urlencoded",
		"dataType" : "json",
		"beforeSend" : function(){ //请求之前调用
			addLoadLevel();
		},
		"complete" : function(){ //请求完成后调用，无论成功还是失败
			removeLoadLevel();
		},
		"url" : obj.url,
		"data" : obj.data,
		"success" : function(data, textStatus) {
			if(obj.redirectCode == null) {
				obj.redirectCode = 200;
			}
			if(obj.redirectUrl != null) {
				if(obj.redirectCode == data.code) {
					window.location.href = obj.redirectUrl;
					return;
				}
			}
			if(obj.success != null) {
				obj.success(data, textStatus); //请求成功后调用
			}
		},
		"error" : function(XMLHttpRequest, textStatus, errorThrown){
			showMsg(textStatus);
			if(obj.error != null) {
				obj.error(XMLHttpRequest, textStatus, errorThrown);
			}
		}
	});
};

/**
 * 添加上传文件事件
 * obj.inputId：上传文件表单id
 * obj.url：上传服务器url
 * obj.fileTypes：允许的文件类型数组
 * obj.progressall：进度回调函数 loaded：已上传字节，total：文件总字节
 * obj.done：完成回调函数
 */
var addUploadEvent = function(obj) {
	$("#" + obj.inputId).fileupload({
		url : obj.url,
		type : "POST",
		dataType : "json",
		add : function(e, data){
			var fileType = data.originalFiles[0].type;
			if(obj.fileTypes != null && obj.fileTypes.length > 0) {
				var result = false;
				for(var i=0; i<obj.fileTypes.length; i++) {
					if(fileType == obj.fileTypes[i]) {
						result = true;
						break;
					}
				}
				if(result) {
					data.submit();
				} else {
					showMsg("文件类型错误");
				}
			} else {
				data.submit();
			}
		},
		progressall : obj.progressall,
		done : obj.done
	});
};

/**
 * 添加图像上传事件
 * obj.inputId：上传图片表单id
 * obj.url：上传服务器url
 * obj.imgId：上传成功能的img元素id
 */
var addImageUploadEvent = function(obj) {
	var inputEle = $("#" + obj.inputId);
	inputEle.after('<span id="progressallSpan" style="color:green;"></span><div><img id="' + obj.imgId + '"></div>');
	obj.fileTypes = ["image/gif", "image/jpeg", "image/jpg", "image/png"];
	obj.progressall = function(e, data){
		var rate = parseInt(data.loaded / data.total * 100, 10);
	    $("#progressallSpan").html(rate + "%");
	};
	obj.done = function(e, data){
		var result = data.result;
		if(result.length > 0) {
			$("#progressallSpan").html('<span style="color:red;">' + result[0].msg + '</span>');
			if(result[0].code == 100) {
				$("#" + obj.imgId).attr("src", result[0].result.serverUrl);
			}
		} else {
			$("#progressallSpan").html("返回结果为空");
		}
	};
	addUploadEvent(obj);
};

//填充内容
var getContentStr = function(param) {
	var str = '';
	for(var i=0; i<param.list.length; i++) {
		var obj = param.list[i];
		str += '<tr align="center" class="contentTr">';
		for(var j=0; j<param.fields.length; j++) {
			var field = param.fields[j];
			var tdId = parseInt(Math.random() * 10000000000000000, 10);
			str += '<td id="' + tdId + '">';
			if(field.fn != null) { //方法不为空，执行方法，并返回
				str += field.fn(obj, tdId);
			} else { //直接返回字段值
				str += obj[field.field] == null ? '' : obj[field.field];
			}
			str += '</td>';
		}
		str += '</tr>';
	}
	return str;
};

//填充分页
var getPageStr = function(page){
	var str = '';
	str += '共&nbsp;<span style="color:red;font-weight:bold;">' + page.rowCount+ '</span>&nbsp;条记录，';
	str += '共&nbsp;<span style="color:red;font-weight:bold;">' + page.pageCount + '</span>&nbsp;页，';
	str += '每页&nbsp;<span style="color:red;font-weight:bold;">' + page.pageSize + '</span>&nbsp;条&nbsp;&nbsp;&nbsp;&nbsp;';
	str += '<span>';
	
	if(page.previous) {
		str += '<a href="javascript:;" onclick="query(' + page.pageSize + ', 1)">首页</a>&nbsp;';
		str += '<a href="javascript:;" onclick="query(' + page.pageSize + ', ' + (page.pageNo - 1) + ')">上一页</a>&nbsp;';
	}
	var prePage = page.previousPages;
	for(var i=0; i<prePage.length; i++) {
		str += '<a href="javascript:;" onclick="query(' + page.pageSize + ', ' + prePage[i] + ')">' + prePage[i] + '</a>&nbsp;';
	}
	
	str += '<span>' + page.pageNo + '</span>&nbsp;';

	var nePage = page.nextPages;
	for(var i=0; i<nePage.length; i++) {
		str += '<a href="javascript:;" onclick="query(' + page.pageSize + ', ' + nePage[i] + ')">' + nePage[i] + '</a>&nbsp;';
	}
	if(page.next) {
		str += '<a href="javascript:;" onclick="query(' + page.pageSize + ', ' + (page.pageNo + 1) + ')">下一页</a>&nbsp;';
		str += '<a href="javascript:;" onclick="query(' + page.pageSize + ', ' + page.pageCount + ')">尾页</a>&nbsp;';
	}

	str += '</span>';
	return str;
};

//填充分页结果
var fillResult = function(data, fields) {
	$("tr.contentTr").remove();
	var str = getContentStr({
		"list" : data.result.list,
		"fields" : fields
	});
	$("table.table-bordered").append(str);
	$("#pageTd").html(getPageStr(data.result.page));
};

var addLoadLevel = function() {
	$("body").append('<div class="loadingLevel_blockOverlay" style="text-align:center;z-index:2001;border:none;margin:0px;padding:0px;width:100%;height:100%;top:0px;left:0px;opacity:0.4;filter:alpha(opacity=40);cursor:default;position:fixed;background-color:rgb(255,255,255);"><img alt="刷新中..." src="images/refresh.gif" style="width:50px;height:50px;position:absolute;top:50%;"></div>');
};
var removeLoadLevel = function() {
	$("div.loadingLevel_blockOverlay").remove();
};

var showMsgCount = 0;
var showMsgInterval = null;
var showMsg = function(msg) {
	window.clearInterval(showMsgInterval);
	showMsgCount = 12;
	showMsgInterval = setInterval('showMsgFlash("' + msg + '")', 100);
};
var showMsgFlash = function(msg) {
	if(showMsgCount < 0) {
		window.clearInterval(showMsgInterval);
		return;
	}
	if(showMsgCount % 2 == 0) {
		$("#showMsg").html('<span style="color:red;">' + msg + '</span>');
	} else {
		$("#showMsg").html('<span style="color:green;">' + msg + '</span>');
	}
	showMsgCount --;
};
