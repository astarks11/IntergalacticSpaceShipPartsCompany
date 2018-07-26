<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title>Monthly Payment Calculator</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div align="center" >
	
		<h1>Monthly Payment Calculator</h1>	

		<p>Enter the amount you would like to pay monthly for your contract.</p>
		<p>You will be shown how many months it will take to complete your contract.</p>

		<form action="./payments.jsp" method="GET">
			<select name="contractNum">
				<option>Choose a Contract</option>
	<%

		//This code block creates an options list of all contracts in the database
		//for the user to choose from
	
		ArrayList<ArrayList<Object>> table = null;

		DBConnect conn = new DBConnect ("dsantana","silence");	
			
		//get contracts to make options table
		String query ="select ContractNum from emanuelb.Contract order by ContractNum"; 

		//get query from DB as an array of arrays. 
		table = conn.getQueryAsLists(query);

		for(int i=1; i<table.get(0).size(); i++){
			String contractNum = table.get(0).get(i).toString();
			out.write("<option value=\"");
			out.write(contractNum);
			out.write("\">" + contractNum);
			out.write("</option>");
		}

		%>

			</select>
			<br><br>

			<input type=number name="cost" placeholder="Desired Payment" required=true></>
	
			<br><br>

			<input type=submit value="See Payments"> </input>
		</form>

	<%
			String contractNum = request.getParameter("contractNum");
			String givenCost   = request.getParameter("cost");

			if(contractNum!=null && !contractNum.equals("Choose a Contract")){

				query = "select ceil(Contract.cost/"+givenCost+") as Months "+
				"from emanuelb.Contract where contract.contractNum="+contractNum;

				System.out.println(query);

				table=conn.getQueryAsLists(query);
	
				out.write(DBConnect.toTable(table));

				conn.close();
			}



	%>

		<br>
	
		<a href=./index.jsp> Go Home</a>

	</div>
	</body>
</html>
