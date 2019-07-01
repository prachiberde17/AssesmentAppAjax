<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.assessment.data.*, java.text.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0037)https://www.mynextmove.org/explore/ip -->
<html lang="en" class="">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="alternate" type="application/rss+xml"
	href="https://www.onetcenter.org/rss/whatsnew.xml">
<link rel="stylesheet" type="text/css"
	href="./resources/assets/emoticons/bubblepop-1.0.css">
<link rel="stylesheet" type="text/css"
	href="./resources/assets/emoticons/jquery.fancybox.css">
<link rel="stylesheet" type="text/css"
	href="./resources/assets/emoticons/base.css">
<link rel="stylesheet" type="text/css"
	href="./resources/assets/emoticons/header.css">
<link rel="stylesheet" type="text/css"
	href="./resources/assets/emoticons/css_main.css">
<link rel="stylesheet" type="text/css"
	href="./resources/assets/emoticons/main.css">
<script type="text/javascript"
	src="./resources/assets/emoticons/jquery-1.9.1.min.js.download"></script>
<script type="text/javascript"
	src="./resources/assets/emoticons/jquery-migrate-1.1.1.min.js.download"></script>
<script type="text/javascript"
	src="./resources/assets/emoticons/bubblepop-1.0.js.download"></script>
<script type="text/javascript"
	src="./resources/assets/emoticons/linktrack.js.download"></script>
<script type="text/javascript"
	src="./resources/assets/emoticons/jquery.fancybox.pack.js.download"></script>
<script type="text/javascript"
	src="./resources/assets/emoticons/base.js.download"></script>
<script type="text/javascript"
	src="./resources/assets/emoticons/js_main.js.download"></script>
<style type="text/css">
</style>
<script type="text/javascript">
function helpwin()
{
  var win = window.open("/explore/ip-help", "window_help",
                        "menubar=0,toolbar=0,location=0,directories=0," +
                        "status=0,scrollbars=1,resizable=1," +
                        "width=600,height=500");
  win.focus();
  return false;
}

function find(arr, item)
{
  var len = arr.length;
  var idx;
  for (idx = 0; idx < len; idx++)
  {
    if (arr[idx] == item)
      return idx;
  }
  return -1;
}

function hover(id, which)
{
  var item = document.getElementById(id);
  if (item)
  {
    var path = item.src;
    var path2;
    if (path)
    {
      path2 = path.replace("_ovr.gif", ".gif");     // turn off
      if (which)
        path2 = path.replace(".gif", "_ovr.gif");   // turn on
      item.src = path2;
    }
  }
}

function graphhover(start, which)
{
  var bar = document.getElementById("graph" + which);
  var legend = document.getElementById("legend" + which);
  var name = document.getElementById("cname" + which);
  var score = document.getElementById("cscore" + which);
  
  if (start)
  {
    if (bar)
      bar.className = "graph" + which + "_ovr";
    if (legend)
      legend.className = "legend" + which + "_ovr";
    if (name)
      name.className = "chart" + which + "_ovr";
    if (score)
      score.className = "chart" + which + "_ovr";
  }
  else
  {
    if (bar)
    {
      if (document.getElementById("graphsel"))
        bar.className = "graph" + which + "_dim";
      else
        bar.className = "graph" + which;
    }
    if (legend)
      legend.className = "legend" + which;
    if (name)
      name.className = "chart" + which;
    if (score)
      score.className = "chart" + which;
  }
}

function able(id, which)
{
  var item = document.forms['toolsform'].elements[id];
  if (item)
  {
    if (item.length)
    {
      for (i = item.length - 1; i >= 0; i--)
      {
        item[i].disabled = which;
        if (item[i].src)
          alert(item[i].src);
      }
    }
    else
    {
      item.disabled = which;
      if (item.src)
        alert(item.src);
    }
  }
}
function enable(id)
{
  able(id, false);
}
function disable(id)
{
  able(id, true);
}

var nextDisabled = '';
function set_next(msg)
{
  nextDisabled = msg;
  
  var btn = document.getElementById('nextbtn');
  if (msg.length > 0)
    btn.src = '/image/ip/next_dis.gif';
  else
    btn.src = '/image/ip/next.gif';
}
function check_next()
{
  if (nextDisabled.length > 0)
  {
    alert(nextDisabled);
    return false;
  }
  return true;
}

function checkscores(pg)
{
  for (var i = 0; i < 6; i++)
  {
    var val = document.forms['toolsform'].elements['score' + i].value;
    if (val == null)
    {
      set_next("Please enter your scores for all six interests. Each score should be an integer between 0 and 40.");
      return false;
    }
    var matched = val.search(/^\s*(?:40|[0123]?\d)\s*$/);
    if (matched < 0)
    {
      set_next("Please enter your scores for all six interests. Each score should be an integer between 0 and 40.");
      return false;
    }
  }
  set_next('');
  return true;
}

var progress = 60;
function setprogress(id)
{
  var sofar = parseInt(id);
  if (sofar > progress)
  {
    progress = sofar;
    var num = document.getElementById("answered");
    if (num)
      num.replaceChild(document.createTextNode(id), num.firstChild);
    var bar = document.getElementById("progressbar");
    if (bar)
      bar.style.width = (sofar * 3) + "px";
  }
}

function doClick(id)
{
  if (id == 'nextbtn')
  {
    if (!check_next())
      return true;
  }
    
  var btn = document.getElementById(id);
  if (btn)
  {
    btn.click();
    return true;
  }
  return false;
}

function inTextField(event)
{
  var elem = event.target || event.srcElement;
  if (elem.nodeType == 3)
    elem = elem.parentNode;
  
  if (elem.tagName == "TEXTAREA" ||
      (elem.tagName == "INPUT" && (elem.getAttribute("type") == "text")))
  {
      if (elem.className == "numonly")
      {
          var chrr = charFromCode(event.keyCode || event.which);
          if (chrr == "0" || chrr == "1" || chrr == "2" ||
              chrr == "3" || chrr == "4" || chrr == "5" ||
              chrr == "6" || chrr == "7" || chrr == "8" ||
              chrr == "9")
              return true;
          else
              return false;
      }
      return true;
  }
  
  return false;
}

var currentQuestion = 0;
var allQuestions = new Array();

function setCurrentQ(idx)
{
  // remove indicator on old current question
  var elem = document.getElementById("num" + allQuestions[currentQuestion]);
  if (elem)
    elem.style.textDecoration = "none";

  currentQuestion = idx;
  if (currentQuestion >= allQuestions.length)
  {
    // no more questions on this page; allow Next
    set_next('');
  }
  else
  {
    // activate next question if needed
    var qid = allQuestions[currentQuestion];
    enable(qid);
    
    // indicate new current question
    elem = document.getElementById("num" + qid);
    if (elem)
      elem.style.textDecoration = "underline";
  }
}

function answer(id)
{
  setprogress(id);
  setCurrentQ(find(allQuestions, "res" + id) + 1);
}

function chooseInt(id)
{
  window.location="profiler?param="+id;
}

function chooseInt2(id)
{
  document.forms['toolsform'].elements['submit_page_R3_' + id].click();
  cancelEvent(event);
  return false;
}

function charFromCode(code)
{
  if (code >= 96 && code <= 105)
    code = code - 48;
  return String.fromCharCode(code).toUpperCase();
}
 
</script>
<title>O*NET Interest Profiler at My Next Move</title>
<style type="text/css">
.fancybox-margin {
	margin-right: 17px;
}
</style>
</head>
<body>
	<!--[if lte IE 6]>
<script type="text/javascript" src="/shared/base_ie6.js"></script>
<![endif]-->
	<!--[if lte IE 7]>
<script type="text/javascript" src="/shared/base_ie7.js"></script>
<![endif]-->
	<a name="top"></a>
	<div id="allcontent">
		<a href="https://www.mynextmove.org/explore/ip#postnav" id="skipnav"
			class="screenreader">Skip navigation</a>
		<div id="headprint" style="display: none; width: 500px">
			<img src="./resources/assets/emoticons/onet_logo_print.png"
				alt="O*NET" width="100" height="74" style="width: 100px"><img
				src="./resources/assets/emoticons/header_mynextmove_print.png"
				width="400" height="74" alt="My Next Move" style="width: 400px">
		</div>
		<div id="head"
			style="position: relative; height: 54px; width: 938px; margin: 0 auto">
			<div
				style="position: absolute; left: 0; top: 36px; width: 755px; height: 2px; overflow: hidden; background: #ddd"></div>
			<a href="https://www.mynextmove.org/"
				style="position: absolute; left: 30px; top: 0; height: 74px; width: 323px; padding-left: 10px; background: white"><img
				src="./resources/assets/emoticons/mnm_white.png" alt="My Next Move"
				width="323" height="74"></a>
			<div
				style="position: absolute; left: 754px; top: 20px; height: 34px; width: 2px; background: #ddd; overflow: hidden"></div>
			<div
				style="position: absolute; left: 650px; top: 10px; height: 54px; width: 65px">
				<img src="./resources/assets/emoticons/header_init.png"
					alt="O*NET in-it" width="65" height="54">
			</div>

			<div
				style="position: absolute; right: 0; top: 10px; height: 54px; width: 176px">
				<div
					style="position: absolute; overflow: hidden; left: 0px; top: 0px; width: 44px; height: 54px">
					<a href="https://www.mynextmove.org/"><img
						src="./resources/assets/emoticons/buttons_header.png"
						style="position: relative; left: 0; top: 0"
						alt="Return to home page." title="Return to home page."
						onmouseover="this.style.left = &#39;0&#39;; this.style.top = &#39;-54px&#39;; return true"
						onmouseout="this.style.left = &#39;0&#39;; this.style.top = &#39;0&#39;; return true"></a>
				</div>
				<div
					style="position: absolute; overflow: hidden; left: 44px; top: 0px; width: 44px; height: 54px">
					<a href="https://www.mynextmove.org/find/search"><img
						src="./resources/assets/emoticons/buttons_header.png"
						style="position: relative; left: -44px; top: 0"
						alt="Search careers with key words."
						title="Search careers with key words."
						onmouseover="this.style.left = &#39;-44px&#39;; this.style.top = &#39;-54px&#39;; return true"
						onmouseout="this.style.left = &#39;-44px&#39;; this.style.top = &#39;0&#39;; return true"></a>
				</div>
				<div
					style="position: absolute; overflow: hidden; left: 88px; top: 0px; width: 44px; height: 54px">
					<a href="https://www.mynextmove.org/find/browse"><img
						src="./resources/assets/emoticons/buttons_header.png"
						style="position: relative; left: -88px; top: 0"
						alt="Browse careers by industry."
						title="Browse careers by industry."
						onmouseover="this.style.left = &#39;-88px&#39;; this.style.top = &#39;-54px&#39;; return true"
						onmouseout="this.style.left = &#39;-88px&#39;; this.style.top = &#39;0&#39;; return true"></a>
				</div>
				<div
					style="position: absolute; overflow: hidden; left: 132px; top: 0px; width: 44px; height: 54px">
					<a href="https://www.mynextmove.org/explore/ip"><img
						src="./resources/assets/emoticons/buttons_header.png"
						style="position: relative; left: -132px; top: 0"
						alt="Discover your interests." title="Discover your interests."
						onmouseover="this.style.left = &#39;-132px&#39;; this.style.top = &#39;-54px&#39;; return true"
						onmouseout="this.style.left = &#39;-132px&#39;; this.style.top = &#39;0&#39;; return true"></a>
				</div>
			</div>
		</div>

		<div id="realcontent">
			<div id="content">
				<a name="postnav" tabindex="1"></a>
				<!-- begin content -->
				<form action="https://www.mynextmove.org/explore/ip" method="POST"
					name="toolsform">
					<input type="hidden" name="page" value="S1"> <input
						type="hidden" name="subpage" value="R"> <input
						type="hidden" name="results"
						value="333333333333444444444444333333333333333333333333334444433333">
					<input type="hidden" name="scores" value="323434333232"> <input
						type="hidden" name="zone" value="0"> <input type="hidden"
						name="maxvisit" value="S1"> <input type="hidden"
						name="client" value=""> <input type="hidden" name="random"
						value="0"> <input type="hidden" name="accessible"
						value="0">
					<table cellspacing="0" cellpadding="0" border="0"
						style="width: 850px; margin: 32px auto 0; height: 67px">
						<tbody>
							<tr>
								<td
									style="width: 49px; height: 67px; background-image: url(https://www.mynextmove.org/image/ip/sub_topleft.gif)"></td>
								<td
									style="height: 67px; background-image: url(https://www.mynextmove.org/image/ip/sub_top.gif)"><div
										style="float: right">
										<a href="https://www.mynextmove.org/explore/ip-help"
											target="_new" onclick="return helpwin()"><img
											src="./resources/assets/emoticons/help.gif" width="19"
											height="39" alt="Help"></a>
									</div> <img src="./resources/assets/emoticons/main_title.gif"
									width="232" height="39" alt="O*NET Interest Profiler"></td>
								<td
									style="width: 49px; height: 67px; background-image: url(https://www.mynextmove.org/image/ip/sub_topright.gif)"></td>
							</tr>
						</tbody>
					</table>
					<table cellspacing="0" cellpadding="0" border="0"
						style="width: 850px; margin: 0 auto">
						<tbody>
							<tr>
								<td
									style="width: 20px; background-image: url(https://www.mynextmove.org/image/ip/sub_left.gif)">&nbsp;</td>
								<td style="background-color: #ddd">
									<div class="inner">
										<ul style="display: none">
											<li><input type="submit" name="submit_page_S1_R"
												value="Realistic" class="link"></li>
											<li><input type="submit" name="submit_page_S1_I"
												value="Investigative" class="link"></li>
											<li><input type="submit" name="submit_page_S1_A"
												value="Artistic" class="link"></li>
											<li><input type="submit" name="submit_page_S1_S"
												value="Social" class="link"></li>
											<li><input type="submit" name="submit_page_S1_E"
												value="Enterprising" class="link"></li>
											<li><input type="submit" name="submit_page_S1_C"
												value="Conventional" class="link"></li>
										</ul>
										<div>
											<table cellpadding="0" cellspacing="0" border="0"
												width="100%">
												<tbody>
													<tr>
														<td width="40%" style="margin: 0; padding: 0 16px 0 29px">
															<div style="margin: 0 0 32px">
																<table cellspacing="0" cellpadding="0">
																	<tbody>
																		<tr>
																			<c:forEach items="${rs}" var="rs">
																				<td
																					style="height: 96px; width: ${rs.score }px; vertical-align: bottom"
																					title="${rs.area }: ${rs.score }"><a
																					href="/AssesmentApp/profiler?param=${rs.area}">
																						<div id="graph${rs.area }"
																							class="graph${rs.area }"
																							style="margin: 0 4px; height: ${rs.score}px; cursor: pointer;"
																							onmouseover="graphhover(1, &#39;${rs.area }&#39;)"
																							onmouseout="graphhover(0, &#39;${rs.area }&#39;)">

																						</div>
																				</a></td>
																			</c:forEach>
																		</tr>
																		<tr>
																			<c:forEach items="${rs}" var="rs">
																				<c:set var="string1" value="${rs.area }" />
																				<c:set var="string2"
																					value="${fn:substring(string1, 0, 1)}" />

																				<td
																					style="width: 40px; text-align: center; border-top: solid 1px #555"
																					title="${rs.area }: ${rs.score }">
																					<div id="legend${rs.area }"
																						class="legend${rs.area }"
																						style="margin: 0 4px; padding: 4px 0; font-size: 13px; font-weight: bold; cursor: pointer;"
																						onmouseover="
																																												graphhover(1, &#39;${rs.area }&#39;)"
																						onmouseout="graphhover(0, &#39;${rs.area }&#39;)">

																						<a style="text-decoration: none; color: black;"
																							href="/AssesmentApp/profiler?param=${rs.area}">${string2}</a>
																					</div>
																				</td>
																			</c:forEach>
																		</tr>
																	</tbody>
																</table>

															</div>
															<div style="margin: 32px 0 0">
																<table cellpadding="0" cellspacing="0" border="0"
																	style="width: 240px">
																	<c:forEach items="${rs}" var="rs">
																		 
																		<tbody>
																			<tr>
																				<td id="cname${rs.area }" class="chart${rs.area }"
																					onclick="chooseInt('${rs.area}')"
																					style="width: 200px; font-weight: bold; cursor: pointer;"
																					onmouseover="graphhover(1, &#39;${rs.area }&#39;)"
																					onmouseout="graphhover(0, &#39;${rs.area }&#39;)"><a
																					style="text-decoration: none; color: black;"
																					href="/AssesmentApp/profiler?param=${rs.area}">${rs.area }</a></td>
																				<td id="cscore${rs.area }" class="chart${rs.area }"
																					style="text-align: right; font-weight: bold; cursor: pointer;"
																					onclick="chooseInt('${rs.area}')"
																					onmouseover="graphhover(1, &#39;${rs.area }&#39;)"
																					onmouseout="graphhover(0, &#39;${rs.area }&#39;)"><a
																					style="text-decoration: none; color: black;"
																					href="/AssesmentApp/profiler?param=${rs.area}">${rs.score }</a></td>
																			</tr>
																		</tbody>
																	</c:forEach>
																</table>

															</div>
														</td>
														<td width="60%"
															style="vertical-align: top; background-color: #fff; border-bottom: solid 1px #aaa; border-right: solid 1px #aaa; padding: 0 16px">
															<p
																style="font-size: 16px; color: #00802A; font-weight: bold">${area}</p>
															<p>
																People with <b style="color: #00802A">${area}</b>

																<c:set var="string" value="${param2}" />
																<c:set var="a" value="${area}" />
																<c:set var="re" value="${fn:substringAfter(string, a)}" />
																<c:set var="string2"
																	value="${fn:substringBefore(re, 'They like')}" />
																${string2}



															</p>
															<p>They like:</p>

															<ul>
																<li>${str1}</li>
																<li>${str2}</li>
															</ul>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
										<div style="text-align: right; padding-top: 8px">
											<a
												href="https://www.mynextmove.org/explore/ip-print?t=i&amp;z=0&amp;i=323434333232"
												id="printbtn" target="_ipprint"><img
												src="./resources/assets/emoticons/print_small.gif"
												alt="Print" width="64" height="22"></a>
										</div>
									</div>
								</td>
								<td
									style="width: 20px; background-image: url(https://www.mynextmove.org/image/ip/sub_right.gif)">&nbsp;</td>
							</tr>
						</tbody>
					</table>
					<table cellspacing="0" cellpadding="0" border="0"
						style="width: 850px; margin: 0 auto; height: 51px">
						<tbody>
							<tr>
								<td
									style="width: 49px; height: 51px; background-image: url(https://www.mynextmove.org/image/ip/sub_botleft.gif)"></td>
								<td
									style="height: 51px; background-image: url(https://www.mynextmove.org/image/ip/sub_bot.gif); text-align: center">
									<img src="./resources/assets/emoticons/close.gif" alt="Close"
									value="Close" onclick="myClose()" />
								</td>
								<td
									style="width: 49px; height: 51px; background-image: url(https://www.mynextmove.org/image/ip/sub_botright.gif)"></td>
							</tr>
						</tbody>
					</table>
				</form>

				<!-- end content -->
			</div>
		</div>
	</div>
	<script type="text/javascript">
function myClose() {
	window.location = "profiler2";
}
</script>

</body>
</html>