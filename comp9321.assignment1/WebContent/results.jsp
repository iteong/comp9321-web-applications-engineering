<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="edu.unsw.comp9321.*, java.util.*" %>
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
		System.out.println("results.jsp: Creating New Session.");
	} else {
		System.out.println("results.jsp: Already In Session.");
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>go! Music - Search Results</title>
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
<%   String content = request.getParameter("content"); %>
<%   String options = request.getParameter("options"); %>

</head>
<body>

<button id="backSearchButton" class="float-left backtosearchbutton" >Back to Search</button>
<script type="text/javascript">
    document.getElementById("backSearchButton").onclick = function () {
        location.href = "search";
    };
</script>


<!-- If user did not enter anything in search bar -->
<c:if test="${empty param.content}">
	<p align="center" />
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">
			You did not enter anything to search! Please go back and search again!
		</H2>
</c:if>


<!-- If user entered something in search bar but nothing was found -->
<c:if test="${not empty param.content && empty searchresultsSongs && empty searchresultsAlbums && empty searchresults}">
	<p align="center" />
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">
			Sorry, no matching datasets found! Try different search string!
		</H2>
</c:if>


<!-- Add to Shopping Cart (entire tables containing parsed data inside this doPost form for data to sent to servlet for processing -->
<div align="center">
	<!-- post action to go to doPost method of ControllerServlet -->		
	<form method="post" action="search">

		<!-- If user entered something in search bar and a substring of that is found in both song and album lists -->
		<!-- Since a song is part of an album, we do not need to account for situations where an album is found but not a song
		and vice versa -->
		<c:if test="${param.options == 'Anything' && not empty searchresultsSongs && not empty searchresultsAlbums}">
		
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You searched for: "<%=content%>"</H2>
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You filtered by "<%=options%>"</H2>
		
			<div class="CSSTableGenerator">
			<h4>List of Song(s) Found:</h4>
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
			   		<th>
			   			Select
			   		</th>
			   	</tr>
			   	
			   	<c:forEach var="song" items="${searchresultsSongs}">
			   	<c:forEach var="album" items="${searchresultsAlbums}">
			   	<tr>
			   		<td>
			   			${song.title}
			   		</td>
			   		<td>
			   			${song.artist}
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.title}
			   		</c:if>
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.genre}
			   		</c:if>
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.publisher}
			   		</c:if>
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.year}
			   		</c:if>
			   		</td>
			   		<td>
			   			${song.price}
			   		</td>
			   		<td>
			   			<input type="checkbox" name="checkbox-anything-songs" value="${song.songID}" />&nbsp;
			   		</td>
			   	</tr>			
			   	</c:forEach></c:forEach>
			
			   </table>
		
			<p></p>
			
			<h4>List of Album(s) Found:</h4>
			   <table>
			   <tr>
			   		<th>
			   			Album Title
			   		</th>
			   		<th>
			   			Album Artist
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
			   		<th>
			   			Select
			   		</th>
			   	</tr>
			   	
			   	<c:forEach var="album" items="${searchresultsAlbums}">
			   	<tr>
			   		<td>
			   			${album.title}
			   		</td>
			   		<td>
			   			${album.artist}
			   		</td>
			   		<td>
			   			${album.genre}
			   		</td>
			   		<td>
			   			${album.publisher}
			   		</td>
			   		<td>
			   			${album.year}
			   		</td>
			   		<td>
			   			${album.price}
			   		</td>
			   		<td>
			   			<input type="checkbox" name="checkbox-anything-albums" value="${album.ID}"/>&nbsp;
			   		</td>
			   	</tr>			
			   	</c:forEach>
			
			   </table>
			     
			</div>
		<p></p>
		</c:if>
		
		
		
		<!-- If user entered something in search bar and a substring of that is found in both song and album lists -->
		<!-- Since a song is part of an album, we do not need to account for situations where an album is found but not a song
		and vice versa -->
		<c:if test="${param.options == 'Artist' && not empty searchresultsSongs && not empty searchresultsAlbums}">
		
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You searched for: "<%=content%>"</H2>
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You filtered by "<%=options%>"</H2>
		
			<div class="CSSTableGenerator">
			<h4>List of Song(s) Found:</h4>
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
			   		<th>
			   			Select
			   		</th>
			   	</tr>
			   	
			   	<c:forEach var="song" items="${searchresultsSongs}">
			   	<c:forEach var="album" items="${searchresultsAlbums}">
			   	<tr>
			   		<td>
			   			${song.title}
			   		</td>
			   		<td>
			   			${song.artist}
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.title}
			   		</c:if>
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.genre}
			   		</c:if>
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.publisher}
			   		</c:if>
			   		</td>
			   		<td>
			   		<c:if test="${song.albumID == album.ID}">
			   			${album.year}
			   		</c:if>
			   		</td>
			   		<td>
			   			${song.price}
			   		</td>
			   		<td>
			   			<input type="checkbox" name="checkbox-artist-songs" value="${song.songID}"/>&nbsp;
			   		</td>
			   	</tr>			
			   	</c:forEach></c:forEach>
			
			   </table>
		
			<p></p>
			
			<h4>List of Album(s) Found:</h4>
			   <table>
			   <tr>
			   		<th>
			   			Album Title
			   		</th>
			   		<th>
			   			Album Artist
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
			   		<th>
			   			Select
			   		</th>
			   	</tr>
			   	
			   	<c:forEach var="album" items="${searchresultsAlbums}">
			   	<tr>
			   		<td>
			   			${album.title}
			   		</td>
			   		<td>
			   			${album.artist}
			   		</td>
			   		<td>
			   			${album.genre}
			   		</td>
			   		<td>
			   			${album.publisher}
			   		</td>
			   		<td>
			   			${album.year}
			   		</td>
			   		<td>
			   			${album.price}
			   		</td>
			   		<td>
			   			<input type="checkbox" name="checkbox-artist-albums" value="${album.ID}"/>&nbsp;
			   		</td>
			   	</tr>			
			   	</c:forEach>
			
			   </table>
			     
			</div>
		<p></p>
		</c:if>
		
		
		
		<c:if test="${param.options == 'Songs' && not empty searchresultsSongs && not empty searchresultsAlbums}">
		
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You searched for: "<%=content%>"</H2>
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You filtered by "<%=options%>"</H2>
		
			<div class="CSSTableGenerator">
			<h4>List of Song(s) Found:</h4>
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
			   		<th>
			   			Select
			   		</th>
			   	</tr>
			   	
			   	<c:forEach var="song" items="${searchresultsSongs}">
			   	<!-- Find the album with albumID that matches the random song's ID -->
			   	<c:forEach var="album" items="${searchresultsAlbums}">
			   		<c:if test="${song.albumID == album.ID}">
			   			<c:set var="searchedsongalbum" value="${album}" />
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
			   		
			   			${searchedsongalbum.title}
			   		
			   		</td>
			   		<td>
			   		
			   			${searchedsongalbum.genre}
			   		
			   		</td>
			   		<td>
			   		
			   			${searchedsongalbum.publisher}
			   		
			   		</td>
			   		<td>
			   		
			   			${searchedsongalbum.year}
			   		
			   		</td>
			   		<td>
			   			${song.price}
			   		</td>
			   		<td>
			   			<input type="checkbox" name="checkbox-songs-songs" value="${song.songID}"/>&nbsp;
			   		</td>
			   	</tr>			
			   	</c:forEach>
			
			   </table>
			   
			   
			</div>
		</c:if>
		
		<c:if test="${param.options == 'Album' && not empty searchresults}">
		
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You searched for: "<%=content%>"</H2>
		<H2 style="font-family: verdana; color: #1B7FC3;" align="center">You filtered by "<%=options%>"</H2>
		
			<div class="CSSTableGenerator">
			<h4>List of Album(s) Found:</h4>
			   <table>
			   <tr>
			   		<th>
			   			Album Title
			   		</th>
			   		<th>
			   			Album Artist
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
			   		<th>
			   			Select
			   		</th>
			   	</tr>
			   	
			   	<c:forEach var="album" items="${searchresults}">
			   	<tr>
			   		<td>
			   			${album.title}
			   		</td>
			   		<td>
			   			${album.artist}
			   		</td>
			   		<td>
			   			${album.genre}
			   		</td>
			   		<td>
			   			${album.publisher}
			   		</td>
			   		<td>
			   			${album.year}
			   		</td>
			   		<td>
			   			${album.price}
			   		</td>
			   		<td>
			   			<input type="checkbox" name="checkbox-album-albums" value="${album.ID}"/>&nbsp;
			   		</td>
			   	</tr>			
			   	</c:forEach>
			
			   </table>
			   
			</div>
		</c:if>

		<input type="image" name="addbutton" src="./add-cart.png"></input>
		<!-- hidden input tag to identify this form action as add to cart -->
		<input type="hidden" name="action" value="add"></input>
	</form>
</div>
<!-- End of doPost form for adding to cart, button is located at the bottom before view cart button -->

<!-- View Shopping Cart -->
<div align="center">
	<!-- post action to go to doPost method of ControllerServlet -->
	<form method="post" action="search">
		<input type="image" name="cartbutton" src="./view-cart.png"></input>
		<!-- hidden input tag to identify this form action as cart -->
		<input type="hidden" name="action" value="cart"></input>
	</form>
</div>




</body>
</html>