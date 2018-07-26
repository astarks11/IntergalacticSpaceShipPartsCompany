<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Add to Order</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />

	</head>
	
	<body>

	<div align="center" >

		<h1>Add to Order</h1>

		<form action="./editOrder.jsp" method="GET">
			<select name="contracts">
				<option>Choose your Contract</option>
	<%

		//This code block creates an options list of all ships in the database
		//for the user to choose from
	
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	
			
		//get contracts to make options table
		String query ="select ContractNum from emanuelb.Contract"; 

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		for(int i=1; i<table.get(0).size(); i++){
			String contract = table.get(0).get(i).toString();
			out.write("<option value=\"");
			out.write(contract);
			out.write("\">" + contract);
			out.write("</option>");
		}

		%>

			</select>
			<br><br>

			<select name="parts">
				<option>Choose a Part</option>
	<%

		//get part names to make options table
		query ="select PartName from emanuelb.Part where isLux=1"; 

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		for(int i=1; i<table.get(0).size(); i++){
			String partName = (String) table.get(0).get(i);
			out.write("<option value=\"");
			out.write(partName);
			out.write("\">" + partName);
			out.write("</option>");
		}

		%>

			</select>
			<br><br>

			<input type=submit value="Add Part to Order"> </input>
		</form>

	<%
		String partName = request.getParameter("parts");
		String contractNum = request.getParameter("contracts");

		if(partName!=null && !partName.equals("Choose a Part") && !contractNum.equals("Choose your Contract")){

			query = "select PartNum from emanuelb.Part where PartName='"+partName+"'";
			table = conn.getQueryAsLists(query);
			String partNum = table.get(0).get(1).toString();

			query = "insert into emanuelb.MissingPart values("+contractNum+" ,"+partNum+")";	

			conn.execute(query);

			query = "select PartCost from emanuelb.Part where PartNum="+partNum;

			table = conn.getQueryAsLists(query);

			String partCost = table.get(0).get(1).toString();

			query = "select Cost from emanuelb.Contract where ContractNum="+contractNum;

			table = conn.getQueryAsLists(query);

			String contractCost = table.get(0).get(1).toString();

			int newCost = Integer.parseInt(contractCost) + Integer.parseInt(partCost);

			query = "update emanuelb.Contract set cost="+newCost+" where ContractNum="+contractNum;
			
			conn.execute(query);

			out.write("<p>Thank you, "+partName+" has been added to contract: "+contractNum+"</p>");

		}

		conn.close();
	%>
		<br><br>
			<a href=./index.jsp> Go Home</a>

		</div>
	</body>
</html>
		
