<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="org.xml.sax.*"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>go! Music - Home</title>
<style type="text/css">
<!-- CSS styles for standard search box -->
	#header{
		background-color:#c3dfef;
	}
	#newsearch{
		float:center;
		padding:20px;
	}
	.searchtextinput{
		margin: 0;
		padding: 5px 15px;
		font-family: Arial, Helvetica, sans-serif;
		font-size:14px;
		border:1px solid #0076a3; border-right:0px;
		border-top-left-radius: 5px 5px;
		border-bottom-left-radius: 5px 5px;
	}
	.searchbutton {
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
	.searchbutton:hover {
		text-decoration: none;
		background: #007ead;
		background: -webkit-gradient(linear, left top, left bottom, from(#0095cc), to(#00678e));
		background: -moz-linear-gradient(top,  #0095cc,  #00678e);
	}
	/* Fixes submit button height problem in Firefox */
	.searchbutton::-moz-focus-inner {
	  border: 0;
	}
	.searchclear{
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

<%@ include file="Header.html"%>
<body>

<!-- HTML for SEARCH BAR -->
<div id="header">
<center>
	<form id="newsearch" method="post" action="search">
		<!-- hidden input tag to identify this form action as search -->
		<input type="hidden" name="action" value="search"></input>
		
		<input type="text" name="content" class="searchtextinput" size="80" maxlength="100" placeholder="Search Artist, Title, Albums or Songs..."></input>
		<input type="submit" value="search" class="searchbutton"></input>
		
		<div>&nbsp;</div>
		<div>Advanced Search:
		<select name="options">
  			<option value="Anything">Anything</option>
  			<option value="Album">Album</option>
  			<option value="Artist">Artist</option>
  			<option value="Songs">Songs</option>
		</select>
		</div>
			
	</form>
</center>
<div class="searchclear"></div>

</div>


<h1 style="font-family: verdana; color: #1B7FC3;" align="center">Top 10 Songs Right Now!</h1>
<div class="CSSTableGenerator">
	   <table>
	   <tr>
	   		<th>
	   			Song Title
	   		</th>
	   		<th>
	   			Song Artist
	   		</th>
	   		
	   		<th>
	   			Album Title
	   		</th>
	   		<th>
	   			Genre
	   		</th>
	   		<th>
	   			Publisher
	   		</th>
	   		<th>
	   			Year
	   		</th>
	   		<th>
	   			Price
	   		</th>
	   	</tr>
	   	
	   	<c:forEach var="song" items="${randomsongs}">
	   	<!-- Find the album with albumID that matches the random song's ID -->
	   	<c:forEach var="album" items="${randomalbums}">
	   		<c:if test="${song.albumID == album.ID}">
	   			<c:set var="randomsongalbum" value="${album}" />
	   		</c:if>
	   	</c:forEach>
	   	<tr>
	   		<td>
	   			${song.title}
	   		</td>
	   		<td>
	   			${song.artist}
	   		</td>
	   		<td>
	   		
	   			${randomsongalbum.title}
	   		
	   		</td>
	   		<td>
	   		
	   			${randomsongalbum.genre}
	   		
	   		</td>
	   		<td>
	   		
	   			${randomsongalbum.publisher}
	   		
	   		</td>
	   		<td>
	   		
	   			${randomsongalbum.year}
	   		
	   		</td>
	   		<td>
	   			${song.price}
	   		</td>
	   	</tr>			
	   	</c:forEach>
	
	   </table>
	   
	   
	</div>
<p></p>
<%@ include file="footer.jsp"%>

</body>
</html>