<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="edu.unsw.comp9321.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	// initialize session
	
	// get the beans from importing edu.unsw.comp9321.*
	CartBean cartBean;
	SongBean songBean;
	AlbumBean albumBean;
	
	// check the session status to see if session has been initialized and shopping cart activated
	if (session.getAttribute("shopping") == null) {
		cartBean = new CartBean();
		songBean = new SongBean();
		albumBean = new AlbumBean();
		session.setAttribute("shopping", cartBean);
		session.setAttribute("songBean", songBean);
		session.setAttribute("albumBean", albumBean);
		System.out.println("cart.jsp: Creating New Session.");
	} else {
		System.out.println("cart.jsp: Already In Session.");
	}

	cartBean = (CartBean) session.getAttribute("shopping");
	
	// get SongBeans and AlbumBeans so can fetch CartBean attributes from them
	//ArrayList<SongBean> songbean = (ArrayList<SongBean>) session.getAttribute("songsCart");
	ArrayList<SongBean> songbean = cartBean.getSongs();
	ArrayList<AlbumBean> albumbean = cartBean.getAlbums();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>go! Music - Checkout</title>
<style type="text/css">
<!-- CSS styles for standard search box -->
	.backtosearchbutton {
		margin: 0;
		padding: 5px 15px;
		font-family: Arial, Helvetica, sans-serif;
		font-size:14px;
		outline: none;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		color: #ffffff;
		border: solid 1px #0076a3; border-right:0px;
		background: #0095cd;
		background: -webkit-gradient(linear, left top, left bottom, from(#00adee), to(#0078a5));
		background: -moz-linear-gradient(top,  #00adee,  #0078a5);
		border-top-right-radius: 5px 5px;
		border-bottom-right-radius: 5px 5px;
	}
	.backtosearchbutton:hover {
		text-decoration: none;
		background: #007ead;
		background: -webkit-gradient(linear, left top, left bottom, from(#0095cc), to(#00678e));
		background: -moz-linear-gradient(top,  #0095cc,  #00678e);
	}
	/* Fixes submit button height problem in Firefox */
	.backtosearchbutton::-moz-focus-inner {
	  border: 0;
	}
	.backtosearchclear{
		clear:both;
	}
	
<!-- CSS styles for Table -->
.CSSTableGenerator {
	margin:0px;padding:0px;
	width:100%;
	box-shadow: 10px 10px 5px #888888;
	border:1px solid #000000;
	
	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;
	
	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;
	
	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;
	
	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}
.CSSTableGenerator table{
    border-collapse: collapse;
        border-spacing: 0;
	width:100%;
	height:100%;
	margin:0px;padding:0px;
}
.CSSTableGenerator tr:last-child td:last-child {
	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;
}
.CSSTableGenerator table tr:first-child td:first-child {
	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}
.CSSTableGenerator table tr:first-child td:last-child {
	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;
}.CSSTableGenerator tr:last-child td:first-child{
	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;
}.CSSTableGenerator tr:hover td{
	
}
.CSSTableGenerator tr:nth-child(odd){ background-color:#e3eef9; }
.CSSTableGenerator tr:nth-child(even)    { background-color:#ffffff; }.CSSTableGenerator td{
	vertical-align:middle;
	
	
	border:1px solid #000000;
	border-width:0px 1px 1px 0px;
	text-align:left;
	padding:7px;
	font-size:10px;
	font-family:Arial;
	font-weight:normal;
	color:#000000;
}
.CSSTableGenerator tr:last-child td{
	border-width:0px 1px 0px 0px;
}
.CSSTableGenerator tr td:last-child{
	border-width:0px 0px 1px 0px;
}
.CSSTableGenerator tr:last-child td:last-child{
	border-width:0px 0px 0px 0px;
}
.CSSTableGenerator tr:first-child td{
		background:-o-linear-gradient(bottom, #00bfbf 5%, #005fbf 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #00bfbf), color-stop(1, #005fbf) );
	background:-moz-linear-gradient( center top, #00bfbf 5%, #005fbf 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#00bfbf", endColorstr="#005fbf");	background: -o-linear-gradient(top,#00bfbf,005fbf);

	background-color:#00bfbf;
	border:0px solid #000000;
	text-align:center;
	border-width:0px 0px 1px 1px;
	font-size:14px;
	font-family:Arial;
	font-weight:bold;
	color:#ffffff;
}
.CSSTableGenerator tr:first-child:hover td{
	background:-o-linear-gradient(bottom, #00bfbf 5%, #005fbf 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #00bfbf), color-stop(1, #005fbf) );
	background:-moz-linear-gradient( center top, #00bfbf 5%, #005fbf 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#00bfbf", endColorstr="#005fbf");	background: -o-linear-gradient(top,#00bfbf,005fbf);

	background-color:#00bfbf;
}
.CSSTableGenerator tr:first-child td:first-child{
	border-width:0px 0px 1px 0px;
}
.CSSTableGenerator tr:first-child td:last-child{
	border-width:0px 0px 1px 1px;
}
</style>
</head>

<body>

<H2 style="font-family: verdana; color: #1B7FC3;" align="center">Checkout</H2>
	
	<!-- Message about whether the shopping cart is empty or not -->
	<c:choose>
		<c:when test="<%= songbean.size() == 0 && albumbean.size() == 0 %>">
			<h2><small>Your shopping cart is empty.</small></h2>
		</c:when>
		<c:when test="<%= songbean.size() >= 1 || albumbean.size() >= 1 %>">
			<h2><small>Your shopping cart has <%= songbean.size() %> song(s) and <%= albumbean.size() %> album(s).</small></h2>
			<tr>
                <th colspan="5"><h2><b>Total Price : $<fmt:formatNumber type="number" maxIntegerDigits="3" value="${total}"></fmt:formatNumber></b></h2></th>
		   </tr>
		</c:when>
	</c:choose>
	

<c:if test="<%= songbean.size() >= 1 %>">

	<div class="CSSTableGenerator">
	<h4>List of Song(s) in Cart:</h4>
	   <table>
	   <tr>
	   		<th>
	   			Title
	   		</th>
	   		<th>
	   			Artist
	   		</th>
	   		
	   		<th>
	   			Type
	   		</th>
	   		<th>
	   			Publisher
	   		</th>
	   		<th>
	   			Price
	   		</th>
	   	</tr>
	   	
	   	<c:forEach var="song" items="${songBeanBean}">
	   	<c:forEach var="album" items="${songAlbumBean}">
	   	<tr>
	   		<td>
	   			${song.title}
	   		</td>
	   		<td>
	   			${song.artist}
	   		</td>
	   		<td>
		   		Song
	   		</td>
	   		<td>
	   			${album.publisher}
	   		</td>
	   		<td>
	   			${song.price}
	   		</td>
	   	</tr>			
	   	</c:forEach></c:forEach>
	
	   </table>
	</div>
</c:if>

	<p></p>

<c:if test="<%= albumbean.size() >= 1 %>">

	<div class="CSSTableGenerator">
	<h4>List of Album(s) in Cart:</h4>
	   <table>
	   <tr>
	   		<th>
	   			Title
	   		</th>
	   		<th>
	   			Artist
	   		</th>
	   		<th>
	   			Type
	   		</th>
	   		<th>
	   			Publisher
	   		</th>
	   		<th>
	   			Price
	   		</th>
	   	</tr>
	   	
	   	<c:forEach var="album" items="${albumBeanBean}">
	   	<tr>
	   		<td>
	   			${album.title}
	   		</td>
	   		<td>
	   			${album.artist}
	   		</td>
	   		<td>
	   			Album
	   		</td>
	   		<td>
	   			${album.publisher}
	   		</td>
	   		<td>
	   			${album.price}
	   		</td>
	   	</tr>			
	   	</c:forEach>
	
	   </table>
	</div>
</c:if>

<h2>Do you want to checkout?</h2>
<tr>
	<th colspan="3">			              	
		<input type="submit" name ="actioncheckout" value="YES" onclick="alert('Thank you for purchasing!')" />
		<input type="hidden" name="confirmcheckout" value="yes"></input>								 									  			                	
	</th>
	<th colspan="3">			              		
		<input type="submit" name ="actioncheckout" value="NO" onclick="alert('Thank you for window shopping!')" />
		<input type="hidden" name="confirmcheckout" value="no"></input>										 									  			                	
	</th>
</tr>

<p></p>


	
		          		
	

	<!-- Show BACK TO SEARCH button when shopping cart is empty, or REMOVE ITEM FROM CART & CHECKOUT buttons otherwise -->
	<c:choose>
		<c:when test="<%= songbean.size() == 0 && albumbean.size() == 0 %>">
			<button id="backSearchButton" class="float-left backtosearchbutton" >Back to Search</button>
			<script type="text/javascript">
    			document.getElementById("backSearchButton").onclick = function () {
        			location.href = "search";
    			};
			</script>
		</c:when>
	</c:choose>

</body>
</html>