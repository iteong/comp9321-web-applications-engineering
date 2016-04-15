# comp9321-web-applications-engineering

Assignment 1: Music Store Web Application

Aims and Background

This project aims to give students hands-on experience in designing and implementing a Web application on their own using XML, Servlets and JSP.

Recently, new business models have revolutionised the music industry. Songs nowadays are sold as singles or together as albums from many music stores such as ITunes Music Store, Rhapsody and eMusic.

The objective of this assignment is to design and implement a web-based music store application using XML, Servlets and JSP at the minimum.

For the scope of this assignment, an XML dataset and schema will be provided. In this data, each song has the following minimum attributes: Artist, Title, Album (linked by the album identifier) and Price. Songs are grouped into albums. An album has the following minimum attributes: Title, Album Artist, Genre, Publisher, Year, and Price. The Album Artist may differ from the Song Artist. Please examine this XML Schema Description (XSD) file for full details of the music data structure.

An XML dataset of nearly 320 songs conforming to the above schema has been provided here. The application might be tested with any data extract, which could also be larger that the one provided. However, during testing, the filename will remain the same as the one provided. Given this XML database, you have to develop an online music store with the following functional requirements.

Functional Requirements

1. The Home Page

The Welcome page is the main entry point to the application and it should have the following:

A main header that displays store name, logo image and Welcome message
A search bar that allows users to search for any information such as Artist, Title, Albums and Songs
Advanced search options that allow users to search for specific inofrmtion based on more search filters (e.g., search authors only)
The welcome page should also display a list of songs (10 items) chosen at random.
2. Search

The user starts at the search page (i.e., the Welcome URL of the application is /search). This forwards to "search.jsp" which has a form with the following elements:

A text input field to allow users to enter their search strings;
Search options (advanced search) as a dropdown box with options "Anything", "Album", "Artist", and "Songs" options;
A button called "Search"
A link to the Shopping Cart page;
Users select to search for any information and the search should be restricted to one of the options they select. If "Anything" is selected then the search should be carried out on all major elements of the XML database. User searche for Album, Artist or Song should be implemented as substring function.
3. Search Results

The search function forwards the users to the results page ("results.jsp"), which has a list of entries that match their search criteria (e.g., in a table format). For Songs, the columns to display are (Song Title, Song Artist, Album Title, Genre, Publisher, Year, Price). For Albums, the columns to display are (Album Title, Album Artist, Genre, Publisher, Year, Price)
The search results should be displayed with checkboxes with an "Add to Cart" and a "Back to Search" buttons; and a link to the user's Shopping Cart.
The user must be alerted if they try to duplicate any entry in the cart. For example, if the user selects an album or song that was already added, or if they added a song whose album was already added
The user may select (via checkbox) the albums/songs they want to buy. They then click "Add to Cart" and is taken to the shopping cart page
If the search does not turn up any result, the results page must display "Sorry, no matching datasets found! Try different search string".
Alternatively, the user may select to go back to Search via "Back to Search".
4. Shopping Cart

Similar to the search results, the Shopping Cart is shown (e.g., in a table format) with the columns (Title, Artist, Type (i.e. Album or Song), Publisher, Price, Select). The last column is a checkbox. At the bottom, the total price of the current cart is shown.
If the cart is empty, then "Cart is empty!" message is displayed.
There are three buttons at the bottom of the page: "Remove from Cart"," Checkout", and "Back to Search". Only the last button is shown if the cart is empty.
The user checks the boxes and clicks "Remove from Cart". The cart page is reloaded with the items removed and the total price should be recalculated
The user clicks "Checkout" and is transferred to checkout page
"Back to Search" takes the user to the search page.
5. Checkout

The checkout page shows the current cart without checkboxes and asks for confirmation (Yes/No)
If yes is selected by the user, display the message "Thank you for purchasing"
If no is selected by the user, display the message "Thank you for shopping"
In both cases, the session must be invalidated (closed)
It is recommended that you use Servlets to mediate the control flow between the different JSP files (views).
