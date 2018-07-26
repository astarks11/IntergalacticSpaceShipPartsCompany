<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Average Cost of Missing Parts</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div align="center" >
	
		<h1>Average Cost of Missing Parts</h1>	

	<%
		
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	

		//round the average to 2 decimal places
		String query ="SELECT ROUND(AVG(PartCost),2) as Average FROM emanuelb.Part WHERE Part.partnum IN "+
						"( select distinct MissingPart.partnum from "+
						"emanuelb.Missingpart join emanuelb.contract on "+
						"missingpart.contractnum=contract.contractnum)";

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
