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
<script type="text/javascript">
	function validate() {

		var companyId = document.getElementById("companyId");

		if (companyId.value == "V2") {
			alert("V2");
			return false;
		} else if (companyId.value == "IH") {
			alert("IH");
			return false;
		} else {
			alert(" nothing is selected");
			return false;
		}

	}
	$(document)
			.ready(
					function() {
						$('#form')
								.submit(
										function(event) {
											var data = {}

											data["companyId"] = $('#companyId')
													.val();
											console.log("msg", data);
											$
													.ajax({
														data : JSON
																.stringify(data),
														type : "POST",
														url : "allData2",
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
															$('.tr').remove();
															for (i = 0; i < response.data.length; i++) {
																console
																		.log(data[i].testName);
																$("#table1")
																		.append(
																				"<tr class='tr'> <td> "
																						+ response.data[i].user
																						+ " </td><td>"
																						+ response.data[i].testName
																						+ "</td><td>"
																						+ response.data[i].companyId
																						+ "</td><td>"
																						+ response.data[i].percentageMarksRecieved
																						+ "</td></tr>");
																/* $("#table1")
																		.append(
																				"<tr class='tr'> <td> "
																						+ response.data.noOfAttempts
																						+ " </td><td> "
																						+ response.data.testName
																						+ " </td><td>"
																						+ response.data.companyId
																						+ "</td><td>"

																						+ response.data.percentageMarksRecieved
																						+ "</td></tr>"); */

															}
															// 					load();
															// 					refresh();
														}

													})
											event.preventDefault();
										});
					});
</script>

</head>
<body>
	<!-- 	onsubmit= return validate() -->
	<form id="form" method="get">
		<select name="companyId" id="companyId">
			<option>Company ID</option>
			<c:forEach items="${companyIdList}" var="items">
				<option value="${items}">${items}</option>
			</c:forEach>
		</select> <input type="submit">
	</form>
	${companyIdList}
	<hr>
	<table border="1" class="table table-dark" id="table1">
		<thead>
			<tr>
				<td>User Name</td>
				<td>Test Name</td>
				<td>Company Id</td>

				<td>Percentage</td>
			</tr>
		</thead>

	</table>




</body>
</html>