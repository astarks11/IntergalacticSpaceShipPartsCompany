<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>View your Contract</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />

	</head>
	
	<body>


	<div align="center" >

		<h1>View your Contract</h1>

		<form action="./contractPage.jsp" method="GET">
			<select name="contracts">
				<option>Choose Your Contract</option>
	<%

		//This code block creates an options list of all ships in the database
		//for the user to choose from
	
		ArrayList<ArrayList<Object>> contractTable = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	
			
		//get ship names to make options table
		String query ="select ContractNum from emanuelb.Contract"; 

		contractTable = conn.getQueryAsLists(query);

		for(int i=1; i<contractTable.get(0).size(); i++){
			String contract = contractTable.get(0).get(i).toString();
			out.write("<option value=\"");
			out.write(contract);
			out.write("\">" + contract);
			out.write("</option>");
		}

		%>

			</select>
			<br><br>
			<input type=submit value="See Contract"> </input>
		</form>

	<%
		String chosenContract = request.getParameter("contracts");


		//only continue if the user has chosen a ship from the list. 
		if(chosenContract!=null && !chosenContract.equals("Choose your Contract")){	

			out.write("<p> Displaying Contract "+chosenContract+"</p>");

			query = "select * from emanuelb.Contract where ContractNum="+chosenContract;

			contractTable = conn.getQueryAsLists(query);

			out.write(DBConnect.toTable(contractTable));

			out.write("<p>Parts missing from your build</p>");

			query = "select PartName, PartCost from emanuelb.MissingPart, emanuelb.Part where "+
			"contractNum="+chosenContract+" AND emanuelb.MissingPart.PartNum=emanuelb.Part.PartNum";

			contractTable = conn.getQueryAsLists(query);

			out.write(DBConnect.toTable(contractTable));


		}
		conn.close();

	%>

	<br>
	<a href=./index.jsp> Go Home</a>


	</div>

	</body>
</html>
