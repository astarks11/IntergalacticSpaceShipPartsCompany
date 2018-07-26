<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Cost of Ship</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />

	</head>
	
	<body>


	<div align="center" >

		<h1>Cost of Ships</h1>

		<form action="./costOfShip.jsp" method="GET">
			<select name="ships">
				<option>Choose a Ship</option>
	<%

		//This code block creates an options list of all ships in the database
		//for the user to choose from
	
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	
			
		//get ship names to make options table
		String query ="select SHIPNAME from emanuelb.Ship"; 

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		for(int i=1; i<table.get(0).size(); i++){
			String shipName = (String) table.get(0).get(i);
			out.write("<option value=\"");
			out.write(shipName);
			out.write("\">" + shipName);
			out.write("</option>");
		}

		%>

			</select>
			<br><br>
			<input type=submit value="See Cost"> </input>
		</form>

	<%
		String chosenShip = request.getParameter("ships");

		//only continue if the user has chosen a ship from the list. 
		if(chosenShip!=null && !chosenShip.equals("Choose a Ship")){	

			out.write("<p>Cost of "+chosenShip+"</p>");

			if(chosenShip.contains("'")){
				int index=chosenShip.indexOf('\'');
				chosenShip = chosenShip.substring(0,index)+"'"+chosenShip.substring(index);
			}

			//list of parts and their cost for chosen ship 
			query = "select PartName as Part, PartCost as Cost from emanuelb.Part,emanuelb.Ship,emanuelb.ShipPart where +"+
					"ShipPart.ShipNum=Ship.ShipNum AND ShipPart.PartNum=Part.PartNum AND ShipName='"+chosenShip+"'";

			table = conn.getQueryAsLists(query);

			//write parts list
			out.write(DBConnect.toTable(table));

			//Parts Cost for the chosen ship
			query = "SELECT SUM(PartCost) as Total FROM emanuelb.Part WHERE PartNum IN "+
					"(SELECT PartNum from emanuelb.ShipPart WHERE ShipNum IN "+
					"(SELECT ShipNum FROM emanuelb.Ship WHERE ShipName='"+chosenShip+"'))";

			table = conn.getQueryAsLists(query);

			out.write("<br>");

			//write part cost. 
			out.write(DBConnect.toTable(table));

		}
		conn.close();

	%>

	<br>
	<a href=./index.jsp> Go Home</a>


	</div>

	</body>
</html>
