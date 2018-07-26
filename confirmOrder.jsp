<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*, java.math.BigDecimal, dbController.DBConnect" %>

<html>
	<head>
		<title> Confirmation </title>
		<link rel="stylesheet" type="text/css" href="./spacegroup.css" />	
	</head>
	
	<body>


	<div align="center" >

				<h1>Order Confirmation</h1>

<%
					ArrayList<ArrayList<Object>> table = null;

					DBConnect conn = new DBConnect ("dsantana","silence");	
			
					String query="";
					String customerName = request.getParameter("custName");
					String shipName = request.getParameter("custShip");		
	
					out.write("<p>");		
			
					int cost = 0;

				if(customerName!=null && !shipName.equals("Choose a Ship")){

					if(shipName.contains("'")){
						int index=shipName.indexOf('\'');
						shipName = shipName.substring(0,index)+"'"+shipName.substring(index);
					}

					String[] partArray=request.getParameterValues("parts[]");		
		
						for (int i=0; i<partArray.length; i++){
							query = "select PartCost from emanuelb.Part where PartName='"+partArray[i]+"'";	
							table = conn.getQueryAsLists(query);
							BigDecimal costBig = (BigDecimal) table.get(0).get(1); 
							int newCost = costBig.intValue();
							cost += newCost;
						}

						out.write("<p>Your order cost is "+cost+"</p>");


						query = "select MAX(CustNum) from emanuelb.Customer";
						table = conn.getQueryAsLists(query);
			
						//custNum of new customer is one more than the current max cust value. 
						BigDecimal custNumBig = (BigDecimal)table.get(0).get(1); 
						int custNum = custNumBig.intValue()+1; 
						query = "select MAX(ContractNum) from emanuelb.Contract";
						table = conn.getQueryAsLists(query);
			
						//contractNum of new contract is one more than the current max value. 
						BigDecimal contractNumBig = (BigDecimal)table.get(0).get(1); 
						int contractNum = contractNumBig.intValue()+1; 

						//get shipNumber that user chose
						query = "select ShipNum from emanuelb.Ship where ShipName='"+shipName+"'";
						table = conn.getQueryAsLists(query);
						BigDecimal shipNumBig = (BigDecimal) table.get(0).get(1); 
						int shipNum = shipNumBig.intValue();

						//select a department to build the ship
						query = "select DeptName from emanuelb.Department where ShipNum="+shipNum;
						table = conn.getQueryAsLists(query);
				
						Random rand = new Random();
						int deptIndex = rand.nextInt(table.get(0).size()-1)+1;
	
						String deptName = (String) table.get(0).get(deptIndex);

						query = "insert into emanuelb.Customer values ("+custNum+", '"+customerName+"')";
						conn.execute(query);

						query = "insert into emanuelb.Contract values ("+contractNum+", "+custNum+", '"+deptName+"', "+shipNum+", "+cost+")";
						conn.execute(query);

						for(int i=0; i<partArray.length;i++){
							query = "select PartNum from emanuelb.Part where PartName='"+partArray[i]+"'";
							table = conn.getQueryAsLists(query);
							BigDecimal partNumBig = (BigDecimal) table.get(0).get(1);
							int partNum = partNumBig.intValue();
							query = "Insert into emanuelb.MissingPart values ("+contractNum+", "+partNum+")";
							conn.execute(query);
						}
						out.write("<p>Your order has been placed, Thanks "+customerName+"</p>");
				}
						conn.close();
%>


					<br><br>
			<a href=./index.jsp> Cancel</a>

		</div>


	</body>
</html>
