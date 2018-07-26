<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Partially Complete Ships</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div  align="center" >
	
		<h1>Partially Complete Ships</h1>	

	<%
		
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	

		String query = "select distinct emanuelb.Contract.ShipNum, emanuelb.Contract.ContractNum, COUNT(emanuelb.MissingPart.ContractNum) as Missing "+
						"from emanuelb.Contract, emanuelb.MissingPart where "+
						"emanuelb.Contract.ContractNum = emanuelb.MissingPart.ContractNum "+
						"group by emanuelb.Contract.ShipNum, emanuelb.Contract.ContractNum, emanuelb.MissingPart.ContractNum";
	
		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		out.write(DBConnect.toTable(table));

		conn.close();

	%>
		<br>

		<a href=./index.jsp> Go Home</a>

	</div>
	</body>
</html>
