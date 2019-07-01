<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ 	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
		// 		var company = ${param.companyId};
		var company = "IH";
		console.log(selectedValue);
		window.location = "changelist2?testName=" + selectedValue
				+ "&companyId=" + company;
	}
</script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
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
		<form:form id="form" action="/AssesmentApp/userTest1" method="get"
			modelAttribute="user">
			<select  name="companyId" id="companyId"
				onchange="change1()">
				<option>Company ID</option>
				<c:forEach items="${companyList}" var="items">
					<option value="${items}">${items}</option>
				</c:forEach>
			</select>
			
			<c:if test="${testList.size() > 0}">
<%-- 				<form:select path="" name="testName" id="testName" --%>
<%-- 					onchange="change2()"> --%>
					<select name="testName" id="testName"  onchange="change2()" >
					<option>Test Name</option>

					<c:forEach items="${testList}" var="items">
						<option value="${items}">${items}</option>
					</c:forEach>
				</select>
<%-- 				</form:select> --%>
			</c:if>
			
<%-- 			<c:if test="${userList.size() > 0}"> --%>
<%-- 				<form:select path="test.user" name="user" id="emailId"> --%>
					<select name="user" id="emailId" onchange="change2()">
					<option>Email id</option>
					<c:forEach items="${userList}" var="items">
						<option value="${items}">${items}</option>
					</c:forEach>
					</select>
<%-- 				</form:select> --%>
<%-- 			</c:if> --%>
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