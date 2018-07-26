<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,  java.math.BigDecimal,dbController.DBConnect" %>
<html>
	<head>
		<title> Database Access </title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>

	<div id="searchresult" align="center" >

	<h1> Welcome Engineers</h1>	

		<form action="./engineerPage.jsp" method="POST">
			<select name="parts">
				<option>Choose a Part</option>
		<%

		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	
			
		//get part names to make options table
		String query ="select PartName from emanuelb.Part"; 

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
				<input type=number name="newCost" placeholder="Enter new cost" required=true></input>
			<br><br>
			<input type=submit value="Update Cost"> </input>
		<%
			String partName = request.getParameter("parts");
			String newCost = request.getParameter("newCost");
	
			if(partName!=null && newCost!=null && !partName.equals("Choose a Part")){

				query = "update emanuelb.Part set PartCost="+newCost+" where PartName='"+partName+"'";
				conn.execute(query);
				//place query for cost update here
				out.write("<p>The cost of "+partName+" has been changed to "+newCost+"</P>");	
			}

		%>

		</form>




		<!-- BEGIN DELETE CONTRACT FORM -->



		<form action="./engineerPage.jsp" method="POST">
			<select name="contracts">
				<option>Choose a Contract</option>

		<%

		//get part names to make options table
		query ="select ContractNum from emanuelb.Contract"; 

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		for(int i=1; i<table.get(0).size(); i++){
			//contract = ContractNum + CustName
			String contract = table.get(0).get(i).toString();
			out.write("<option value=\"");
			out.write(contract);
			out.write("\">" + contract);
			out.write("</option>");
		}

		%>

			</select>
			<br><br>
			<input type=submit value="Delete Contract"> </input>
		<%
			String contractNum = request.getParameter("contracts");
	
			if(contractNum!=null && !contractNum.equals("Choose a Contract")){

				query = "delete from emanuelb.Contract where ContractNum="+contractNum;
				conn.execute(query);
				query = "delete from emanuelb.MissingPart where ContractNum="+contractNum;
				conn.execute(query);
	
				//place query for cost update here
				out.write("<p>Contract Number "+contractNum+" has been deleted</P>");	
			}

		%>

		</form>


		<form action="./engineerPage.jsp" method="POST">

			<input type=text name="dept" required=true placeholder="Department"/><br><br>

			<select name="deptShipNum">
				<option>Choose Ship Number</option>

				<%

				//get part names to make options table
				query ="select ShipNum from emanuelb.Ship"; 

				//get query from DB as an array of arrays. 
				table = conn.getQueryAsLists(query);

				for(int i=1; i<table.get(0).size(); i++){
					//shipNums as options
					String shipNum = table.get(0).get(i).toString();
					out.write("<option value=\"");
					out.write(shipNum);
					out.write("\">" + shipNum);
					out.write("</option>");
				}

				%>

			</select>
			<br><br>


			<input type=submit value="Add Department"/>

		<%
			String addDept        = request.getParameter("dept");
			String deptShipNum = request.getParameter("deptShipNum");

			if(addDept!=null && !deptShipNum.equals("Choose Ship Number")){

				//add ship to chosen department
				query = "insert into emanuelb.Department values('"+addDept+"', "+deptShipNum+")";

				conn.execute(query);
	
				//place query for cost update here
				out.write("<p>Department "+addDept+" has been added</P>");	
			}

		%>

		</form>


		<form action="./engineerPage.jsp" method="POST">

			<input type=text name="newPartName" required=true placeholder="Part Name"/><br><br>
			<input type=number name="cost" min=1 max=9999 step= required=true placeholder="Cost"/><br><br>

			<input type=submit value="Add Part"/>

		<%
			String newPartName = request.getParameter("newPartName");
			String cost        = request.getParameter("cost");
	
			if(newPartName!=null && cost!=null){

				query = "select MAX(PartNum) from emanuelb.Part";

				table = conn.getQueryAsLists(query);
			
				//shipNum of new ship is one more than the current max value. 
				BigDecimal partNumBig = (BigDecimal)table.get(0).get(1); 
				int partNum = partNumBig.intValue()+1; 

				//add ship to Ship relation
				query = "insert into emanuelb.Part values ("+partNum+", '"+newPartName+"', "+cost+", "+"1"+")";	

				conn.execute(query);
	
				out.write("<p>Part "+newPartName+" has been added </P>");	
			}

		%>

		</form>



		<form action="./engineerPage.jsp" method="POST">

			<input type=text name="newShipName" required=true placeholder="Ship Name"/><br><br>
			<input type=number name="markup" min=1 max=999 step=.1 required=true placeholder="Markup"/><br><br>
			<input type=text name="newShipDept" required=true placeholder="Department"/><br><br>

			<input type=submit value="Add Ship"/>

		<%
			String newShipName = request.getParameter("newShipName");
			String markup      = request.getParameter("markup");
			String dept        = request.getParameter("newShipDept");
	
			if(newShipName!=null && markup!=null && dept!=null){

				query = "select MAX(ShipNum) from emanuelb.Ship";

				table = conn.getQueryAsLists(query);
			
				//shipNum of new ship is one more than the current max value. 
				BigDecimal shipNumBig = (BigDecimal)table.get(0).get(1); 
				int shipNum = shipNumBig.intValue()+1; 

				//add ship to Ship relation
				query = "insert into emanuelb.Ship values ("+shipNum+", '"+newShipName+"', "+markup+")";	
				conn.execute(query);
			
				//add ship to chosen department
				query = "insert into emanuelb.Department values('"+dept+"', "+shipNum+")";

				conn.execute(query);
	
				out.write("<p>Ship "+newShipName+" has been added to "+dept+"</P>");	
			}

		%>

		</form>

		<form action="./engineerPage.jsp" method="POST">


			<select name="shipPartShip">
				<option>Choose Ship Number</option>

				<%

				//get part names to make options table
				query ="select ShipNum from emanuelb.Ship"; 

				//get query from DB as an array of arrays. 
				table = conn.getQueryAsLists(query);

				for(int i=1; i<table.get(0).size(); i++){
					//shipNums as options
					String shipNum = table.get(0).get(i).toString();
					out.write("<option value=\"");
					out.write(shipNum);
					out.write("\">" + shipNum);
					out.write("</option>");
				}

				%>

			</select>
			<br><br>

			<select name="shipPartPart">
				<option>Choose a Part</option>
			
				<%

				//get part names to make options table
				query ="select PartNum from emanuelb.Part"; 

				//get query from DB as an array of arrays. 
				table = conn.getQueryAsLists(query);

				for(int i=1; i<table.get(0).size(); i++){
					String partNum = table.get(0).get(i).toString();
					out.write("<option value=\"");
					out.write(partNum);
					out.write("\">" + partNum);
					out.write("</option>");
				}

				%>

			</select>
			<br><br>

			<input type=submit value="Add ShipPart"/>

		<%

			String shipPartShip = request.getParameter("shipPartShip");
			String shipPartPart = request.getParameter("shipPartPart");
	
			if(shipPartShip!=null && shipPartPart!=null && !shipPartShip.equals("Choose a Part") && !shipPartShip.equals("Choose Ship Number")){
	
				query = "insert into emanuelb.ShipPart values("+shipPartShip+", "+shipPartPart+")";

				conn.execute(query);

				out.write("<p>"+shipPartShip+", "+shipPartPart+" has been added to ShipPart</p>");
			}

			conn.close();
		%>

		</form>



		<a href=./index.jsp> Go Home</a>


	</div>
	</body>
</html>
