<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, java.math.BigDecimal, dbController.DBConnect" %>

<html>
	<head>
		<title> Database Access </title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div align="center" >

				<h1>Order a Ship</h1>


			<form id="orderForm" action="./orderPage.jsp" method="POST">
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

				<input type=submit value="Choose Ship"> </input>

			</form>

			<form id="orderform" action="confirmOrder.jsp">

				<fieldset align="left">
					<legend>Choose Your Parts:</legend> 
						<br><br>
	
			<%

			String shipName = request.getParameter("ships");			
	
			out.write("<p>");		
			
			if(shipName!=null && !shipName.equals("Choose a Ship")){

					if(shipName.contains("'")){
						int index=shipName.indexOf('\'');
						shipName = shipName.substring(0,index)+"'"+shipName.substring(index);
					}
		
					out.write("<input type='hidden' name='custShip' value='"+shipName+"'></>");
					out.write("<br><br>");
					//get shipNumber that user chose
					query = "select ShipNum from emanuelb.Ship where ShipName='"+shipName+"'";

					table = conn.getQueryAsLists(query);
					BigDecimal shipNumBig = (BigDecimal) table.get(0).get(1); 
					int shipNum = shipNumBig.intValue();

					//get part names to make options
					query ="select PartName, PartCost from emanuelb.Part where isLux=1 AND PartNum IN "+
					"(select PartNum from emanuelb.ShipPart where ShipNum="+shipNum+")"; 

					//get query from DB as an array of arrays. 
					table = conn.getQueryAsLists(query);

					for(int i=1; i<table.get(0).size();i++){
						String name = (String) table.get(0).get(i);
						String cost = table.get(1).get(i).toString();
						out.write("<input type=checkbox name=\"parts[]\" id=\""+name+"\" value=\""+name+"\"/>");
						out.write("<label for=\""+name+"\">"+name+" ($"+cost+")</label><br>");
					}

					out.write("<p>These parts are required:</p>");

					//get part names to make options
					query ="select PartName, PartCost from emanuelb.Part where isLux=0";

					//get query from DB as an array of arrays. 
					table = conn.getQueryAsLists(query);

					for(int i=1; i<table.get(0).size();i++){
						String name = (String) table.get(0).get(i);
						String cost = table.get(1).get(i).toString();
						out.write("<input type=checkbox checked=true name=\"parts[]\" id=\""+name+"\" value=\""+name+"\"/>");
						out.write("<label for=\""+name+"\">"+name+" ($"+cost+")</label><br>");
					}


			}

					conn.close();

				%>


			</fieldSet>

				<br><br>

				<input type=text name="custName" required=true placeholder="Name"/>

				<br><br>

				<input type=submit value="See Cost"> </input>

			</form>

					<br><br>
			<a href=./index.jsp> Go Home</a>

		</div>


	</body>
</html>
