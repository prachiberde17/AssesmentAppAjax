<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ 	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<spring:url value="/resources/scripts/taskajax.js" var="mainJs1" />
<script src="${mainJs1}"></script>
 <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<meta charset="ISO-8859-1">
<title>Insert title here</title>

<script>
	function change1() {
		var selectedValue = $("#companyId").val();
		console.log(selectedValue);

		window.location = "changelist1?companyId=" + selectedValue;
	}
</script>
<script>
	function change2() {
		var selectedValue = $("#testName").val();
		// 				var company;
		//company = ${param.companyId};
		//console.log(company);
		// 			var company = ${cid};
		var company = $("#companyId").val();
		console.log(company);
// 				var company = "ih";
		console.log(selectedValue);
		window.location = "changelist2?testName=" + selectedValue
				+ "&companyId=" + company;
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
						$('#form')
								.submit(
										function(event) {
											var data = {}
											data["user"] = $("#emailId").val();
											data["testName"] = $('#testName')
													.val();
											data["companyId"] = $('#companyId')
													.val();
											console.log("msg", data);
											$
													.ajax({
														data : JSON
																.stringify(data),
														type : "POST",
														url : "userTest2",
														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			"Accept",
																			"application/json");
															xhr
																	.setRequestHeader(
																			"Content-Type",
																			"application/json");
														},
														success : function(
																response) {
															//					alert(response.msg);
															console
																	.log(response.data);
															console
																	.log(response.msg);
															data = response.data;
															//			            $('.tr').remove();
															//			            for (i = 0; i < response.data.length; i++) {
															//			                console.log(data[i].firstName);
															//		                $("#table1").append("<tr class='tr'> <td> " + response.data[i].skill_name + " </td>  <td> <a href='#' onclick= edit(" + i + ");> Edit </a>  </td> </td> <td> <a href='#' onclick='delete_(" + response.data[i].skill_Id + ");'> Delete </a>  </td> </tr>");
															$('.tr').remove();
															$("#table1")
																	.append(
																			"<tr class='tr'> <td> "
																					+ response.data.user
																					+ " </td><td> "
																					+ response.data.testName
																					+ " </td><td>"
																					+ response.data.companyId
																					+ "</td><td>"
																					+ response.data.test.passPercent
																					+ "</td><td>"
																					+ response.data.percentageMarksRecieved
																					+ "</td></tr>");

															//			            }
															// 					load();
															// 					refresh();
														},

													});
											event.preventDefault();
										});
					});
</script>



</head>
<body>
	<div align="center">
		<form:form modelAttribute="userTest" id="form"
			action="/AssesmentApp/userTest1" method="get">

			
			<form:select path="companyId" name="companyId" id="companyId"
				onchange="change1()">
				<option>Company ID</option>
				<form:options items="${companyList}" />
			</form:select>

			<%-- <form:select path="companyId" id="companyId" onchange="change1()">
				<form:options items="${companyList}" />
			</form:select> --%>

			<c:if test ="${testList.size() >0}">
			<form:select path="testName" name="testName" id="testName"
				onchange="change2()">
			
				<form:option value = "NONE" label = " TESTS "></form:option>
				<form:options items="${testList}" id="testName" />
			</form:select>
			</c:if>
			<%-- <c:if test="${testList.size() > 0}">  
				<select id="select1"></select>
 				<form:select path="testName" onchange="change2()">  
 					<form:options items="${testList}" id="testName" />  
 				</form:select> 
  			</c:if>   --%>
  			
			<c:if test ="${userList.size() >0}">
			<form:select path="user" name="user" id="emailId">
			<option value = "-1">Email ID</option>     
				<form:options items="${userList}" id="emailId" />
			</form:select>
			</c:if>
			<%-- <select id="select2"></select>
			<c:if test="${userList.size() > 0}">
				<form:select path="user" id="emailId">
					<form:options items="${userList}" />
				</form:select>
			</c:if> --%>
			<input type="submit" class="btn btn-dark">
		</form:form>

		<%-- ${userlist.test} --%>
		<hr>
		<table border="1" class="table table-dark" id="table1">
			<thead>
				<tr>
					<td>User Name</td>
					<td>Test Name</td>
					<td>Company Id</td>
					<td>Passing %</td>
					<td>Percentage</td>
				</tr>
			</thead>
			<%-- <tr>
				<td>${userlist.user}</td>
				<td>${userlist.testName}</td>
				<td>${param.companyId}</td>
				<td>${userlist.test.passPercent}</td>
				<td>${userlist.percentageMarksRecieved}</td>
			</tr> --%>
		</table>
	</div>


</body>
</html>