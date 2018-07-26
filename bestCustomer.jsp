<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, dbController.DBConnect" %>
<html>
	<head>
		<title> I4 Best Customer</title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>

	
		<div id="searchresult" align="center" >
	
			<h1>Top Customer(s)</h1>	

		<%
		
			ArrayList<ArrayList<Object>> table = null;

			DBConnect conn = new DBConnect ("dsantana","silence");	

			String query =  "create global temporary table myTable "+
						"on commit preserve rows as select customer.custnum, customer.custname, sum(Contract.cost) as total_cost "+
						"from emanuelb.Contract join emanuelb.Customer on Contract.custnum=Customer.custnum " +
						"GROUP BY customer.custnum, customer.custname ORDER BY total_cost DESC ";

			conn.execute(query);

			System.out.println("FIRST QUERY ");

			query="select * from myTable where total_cost=(select max(total_cost) from myTable) ";

			table=conn.getQueryAsLists(query);		

			System.out.println("SECOND QUERY ");

			//get query from DB as an array of arrays. 
			table = conn.getQueryAsLists(query);

			conn.execute("truncate table myTable");
	
			conn.execute("drop table myTable");
	
			conn.close();

			out.write(DBConnect.toTable(table));

		%>
	
			<br><br>
			<a href=./index.jsp> Go Home</a>

		</div>
	</body>
</html>
		
