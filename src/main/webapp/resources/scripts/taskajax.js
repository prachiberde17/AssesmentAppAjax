call = function() {
	alert("Hello");
}

function ajax1() {
	var selectedValue = $("#companyId").val();
	$.ajax({
		url : "ajax1",
		type : "POST",
		data : {
			companyId : selectedValue
		},
		success : function(response) {
			alert();
//			console.log(response.data);
//			("#testName").val(response.data);
			$('.option').remove();
			for (i = 0; i < response.data.length; i++) {
//				alert("hi");	
				console.log(response.data[i]);
					$("#select1").append("<option value="+response.data[i]+">"+response.data[i]+"</option>")
			}
		}
	});
}
