package edu.unsw.comp9321;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;

import org.xml.sax.InputSource;


/**
 * Servlet implementation class ControllerServlet
 */
@WebServlet(urlPatterns="/search", displayName="ControllerServlet")
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger(this.getClass().getName());
	
	// make the SongBean and AlbumBean global variables so the parsed data is available
	// to whole class (not just doGet) as long as class exists
	public ArrayList<SongBean> songs = new ArrayList<SongBean>();
	public ArrayList<AlbumBean> albums = new ArrayList<AlbumBean>();
	public CartBean cart = new CartBean();
	
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() {
    	// run this once only at initialization
    	ServletContext context = getServletContext();
    	InputSource xmlFile = new InputSource(context.getResourceAsStream("/WEB-INF/musicDb.xml"));
    	try {
    		// create the DocumentBuilder object
    		DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
    		DocumentBuilder builder = builderFactory.newDocumentBuilder();
    		
    		// create a Document from a XML file
    		Document doc = builder.parse(xmlFile);
    		
    		DOMParser parser = new DOMParser();
    		
    		albums = parser.translateToAlbums(doc);
    		songs = parser.translateToSongs(doc);
    	}
    	catch (Exception e) {
    		logger.severe(e.getMessage());
    	}
    	System.out.println("album size: " + albums.size());
    	System.out.println("songs size: " + songs.size());
    }
    
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<SongBean> arrayRandomSongs = new ArrayList<SongBean>();
		ArrayList<AlbumBean> arrayRandomSongsAlbums = new ArrayList<AlbumBean>();
		
		// random number generation for the 10 random songs on home page
		Random rand = new Random();
		for (int i = 0; i < 10; i++) {
			Integer r = rand.nextInt(songs.size() + 1);
			
			// add random song to arrayRandomSongs
			arrayRandomSongs.add(songs.get(r));
			System.out.println("Random Song Title: " + songs.get(r).getTitle());
			
			// assign string value of albumID for this random song to songAlbumID
			String songAlbumID = songs.get(r).getAlbumID();
			// iterate through albums to look for AlbumBean with same ID as songAlbumID
			for (AlbumBean album : albums) {
				if (album.getID().contains(songAlbumID)) {
					arrayRandomSongsAlbums.add(album);
					System.out.println("Random Song's Album Title: " + album.getTitle());
					// break out of for loop iteration through albums when found album to go to next random song
					break;
				}
			}
			
		}
		
    	System.out.println("number of random songs: " + arrayRandomSongs.size());
    	
		request.setAttribute("randomsongs", arrayRandomSongs);
		request.setAttribute("randomalbums", arrayRandomSongsAlbums);
		
		RequestDispatcher requestdispatcher = request.getRequestDispatcher("/search.jsp");

		requestdispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// use action parameter for form post to know what to do and which JSP to dispatch request to
		String action = request.getParameter("action");

		System.out.println("Action: " + action);

		// get the songs and albums objects containing data needed from session

		// initialize nextPage empty String
		String nextPage = "";

		
		if (action.equals("search")) {
			String content = request.getParameter("content");
			String options = request.getParameter("options");
			System.out.println("You searched for: " + content);
			System.out.println("You filtered by " + options);

			// when nothing entered in search box
			if (content.length() == 0) {
				request.setAttribute("content", "nothing");
				nextPage = "search.jsp";
				System.out.println("User did not key in anything");

				// when something entered in search box
			} else {
				// check which Advanced Search option is selected, by default = Anything

				if (options.equals("Anything")) {
					// create 2 separate array lists of SongBeans and AlbumBeans to store searched results
					ArrayList<SongBean> resultsArraySongs = new ArrayList<SongBean>();
					ArrayList<AlbumBean> resultsArrayAlbums = new ArrayList<AlbumBean>();
					// iterate through all the SongBeans and AlbumBeans in the songList and albumList saved in "songs" and "albums" objects
					for (SongBean song : songs) {
						if (song.getSearchString().contains(content)) {
							resultsArraySongs.add(song);
							System.out.println(resultsArraySongs);
						}
					}
					request.setAttribute("searchresultsSongs", resultsArraySongs);

					for (AlbumBean album : albums) {
						if (album.getSearchString().contains(content)) {
							resultsArrayAlbums.add(album);
							System.out.println(resultsArrayAlbums);
						}
					}
					request.setAttribute("searchresultsAlbums", resultsArrayAlbums);

				} else if (options.equals("Artist")) {
					// create 2 separate array lists of SongBeans and AlbumBeans to store searched results
					ArrayList<SongBean> resultsArraySongs = new ArrayList<SongBean>();
					ArrayList<AlbumBean> resultsArrayAlbums = new ArrayList<AlbumBean>();
					// iterate through all the SongBeans and AlbumBeans in the songList and albumList saved in "songs" and "albums" objects
					for (SongBean song : songs) {
						if (song.getArtist().contains(content)) {
							resultsArraySongs.add(song);
							System.out.println(resultsArraySongs);
						}
					}
					request.setAttribute("searchresultsSongs", resultsArraySongs);

					for (AlbumBean album : albums) {
						if (album.getArtist().contains(content)) {
							resultsArrayAlbums.add(album);
							System.out.println(resultsArrayAlbums);
						}
					}
					request.setAttribute("searchresultsAlbums", resultsArrayAlbums);

				} else if (options.equals("Songs")) {
					// create 2 separate array lists of SongBeans and AlbumBeans to store searched results
					ArrayList<SongBean> resultsArraySongs = new ArrayList<SongBean>();
					ArrayList<AlbumBean> resultsArrayAlbums = new ArrayList<AlbumBean>();

					// iterate through all the SongBeans and AlbumBeans in the songList and albumList saved in "songs" and "albums" objects
					for (SongBean song : songs) {
						if (song.getTitle().contains(content) || song.getSongID().contains(content)) {
							resultsArraySongs.add(song);
							// assign string value of albumID for this random song to songAlbumID
							String songAlbumID = song.getAlbumID();
							for (AlbumBean album : albums) {
								if (album.getID().contains(songAlbumID)) {
									resultsArrayAlbums.add(album);
									System.out.println(resultsArrayAlbums);
									break;
								}
							}
							System.out.println(resultsArraySongs);
						}


					}
					request.setAttribute("searchresultsAlbums", resultsArrayAlbums);
					request.setAttribute("searchresultsSongs", resultsArraySongs);

				} else if (options.equals("Album")) {
					// create a separate array list of AlbumBeans to store searched results
					ArrayList<AlbumBean> resultsArray = new ArrayList<AlbumBean>();

					// iterate through all the AlbumBeans in the albumList saved in "albums" object
					for (AlbumBean album : albums) {
						// searching for albums by title or ID only
						if (album.getTitle().contains(content) || album.getID().contains(content)) {
							resultsArray.add(album);
							System.out.println(resultsArray);
						}
					}
					request.setAttribute("searchresults", resultsArray);
				}

			}
			// end of else loop for search content that is not empty
			HttpSession session = request.getSession(true);
			session.setAttribute("optionsforadd", options);
			
			RequestDispatcher requestdispatcher = request.getRequestDispatcher("/results.jsp");
			requestdispatcher.forward(request, response);

		} else if (action.equals("cart")) {

			RequestDispatcher requestdispatcher = request.getRequestDispatcher("/cart.jsp");
			requestdispatcher.forward(request, response);
			
		} else if (action.equals("confirmcheckout")) {
			
			// As long as action is not null, we proceed to delete data from cart and invalidate session
			String actioncheckout = request.getParameter("action");
			if (actioncheckout != null) {
				try {
					// Delete data from database
					cart = null;
				} catch (Exception e) { 
					e.printStackTrace();
				}
				
				// Invalidate session
				request.getSession().invalidate();
				
				// Redirect to home page
				RequestDispatcher rd = request.getRequestDispatcher("/search.jsp"); 
				rd.forward(request, response);
				
			} 

		} else if (action.equals("checkout")) {

			RequestDispatcher requestdispatcher = request.getRequestDispatcher("/checkout.jsp");
			requestdispatcher.forward(request, response);

		} else if (action.equals("add")) {

			HttpSession session = request.getSession(true);
			String options = (String) session.getAttribute("optionsforadd");
			System.out.println(options);
			// get check box values for songs and albums on results.jsp based on option selected
			if (options.equals("Anything")) {
				String selectedsongs[] = request.getParameterValues("checkbox-anything-songs");
				String selectedalbums[] = request.getParameterValues("checkbox-anything-albums");
				float total = 0;
				// selected songs' album details
				ArrayList<AlbumBean> cartAlbumDetailsForSongs = new ArrayList<AlbumBean>();
				
				boolean executedsongs = false;
				if (!executedsongs && selectedsongs != null) {
					executedsongs  = true;
				// iterate through the songs selected in results.jsp for matching songs in order to add to cart
				for (int i = 0; i < selectedsongs.length; i++) {
					System.out.println("You selected song with songID: " + selectedsongs[i]);

					// iterate through SongBeans in global variable, songs
					for (SongBean song : songs) {
						// selected song is added to cart using songID to match with SongBean's songID & break out of for loop
						if (song.getSongID().matches(selectedsongs[i])) {
							cart.addSong(song);
							total += song.getPrice();
							System.out.println("Added the following song to cart: " + song.getTitle());
							// assign string value of albumID for this selected song to songAlbumID
							String songAlbumID = song.getAlbumID();
							for (AlbumBean album : albums) {
								if (album.getID().matches(songAlbumID)) {
									cartAlbumDetailsForSongs.add(album);
									System.out.println("This song is from the album: " + album.getTitle());
									break;
								}
							}
							break;
						}
						
					} // end of for loop to find selected song in global variable, songs

				}
				System.out.println("Finished iterating through the selected songs.");
				System.out.println("You added " + selectedsongs.length + " song(s) to your cart and have a total of " + cart.getSongs().size() + " song(s) in your cart now!");
				
				}
				
				boolean executedalbums = false;
				if (!executedalbums && selectedalbums != null) {
					executedalbums = true;
				// iterate through the albums selected in results.jsp for matching albums in order to add to cart
				for (int i = 0; i < selectedalbums.length; i++) {
					System.out.println("You selected album with ID: " + selectedalbums[i]);

					// iterate through AlbumsBeans in global variable, albums
					for (AlbumBean album : albums) {
						// selected album is added to cart using album's ID to match with AlbumBean's ID & break out of for loop
						if (album.getID().matches(selectedalbums[i])) {
							cart.addAlbum(album);
							total += album.getPrice();
							System.out.println("Added the following album to cart: " + album.getTitle());
							System.out.println("Number of albums in cart now: " + cart.getAlbumsSize());
							break;
						}
						
					} // end of for loop to find selected album in global variable, albums

				}
				System.out.println("Finished iterating through the selected albums.");
				System.out.println("You added " + selectedalbums.length + " album(s) to your cart and have a total of " + cart.getAlbums().size() + " albums(s) in your cart now!");
				
				}

				session.setAttribute("shopping", cart);
				session.setAttribute("albumBeanBean", cart.getAlbums());
				session.setAttribute("songBeanBean", cart.getSongs());
				session.setAttribute("songAlbumBean", cartAlbumDetailsForSongs);
				session.setAttribute("total", total);
				System.out.println("Total price is: " + total);
				RequestDispatcher requestdispatcher = request.getRequestDispatcher("/cart.jsp");
				requestdispatcher.forward(request, response);
				
				
				
				
				
			} else if (options.equals("Artist")) {
				String selectedsongs[] = request.getParameterValues("checkbox-artist-songs");
				String selectedalbums[] = request.getParameterValues("checkbox-artist-albums");
				float total = 0;
				// selected songs' album details
				ArrayList<AlbumBean> cartAlbumDetailsForSongs = new ArrayList<AlbumBean>();
				
				boolean executedsongs = false;
				if (!executedsongs && selectedsongs != null) {
					executedsongs = true;
				// iterate through the songs selected in results.jsp for matching songs in order to add to cart
				for (int i = 0; i < selectedsongs.length; i++) {
					System.out.println("You selected song with songID: " + selectedsongs[i]);

					// iterate through SongBeans in global variable, songs
					for (SongBean song : songs) {
						// selected song is added to cart using songID to match with SongBean's songID & break out of for loop
						if (song.getSongID().matches(selectedsongs[i])) {
							cart.addSong(song);
							total += song.getPrice();
							System.out.println("Added the following song to cart: " + song.getTitle());
							// assign string value of albumID for this selected song to songAlbumID
							String songAlbumID = song.getAlbumID();
							for (AlbumBean album : albums) {
								if (album.getID().matches(songAlbumID)) {
									cartAlbumDetailsForSongs.add(album);
									System.out.println("This song is from the album: " + album.getTitle());
									break;
								}
							}
							break;
						}
						
					} // end of for loop to find selected song in global variable, songs

				}
				System.out.println("Finished iterating through the selected songs.");
				System.out.println("You added " + selectedsongs.length + " song(s) to your cart and have a total of " + cart.getSongs().size() + " song(s) in your cart now!");

				}
				
				boolean executedalbums = false;
				if (!executedalbums && selectedalbums != null) {
					executedalbums = true;
				// iterate through the albums selected in results.jsp for matching albums in order to add to cart
				for (int i = 0; i < selectedalbums.length; i++) {
					System.out.println("You selected album with ID: " + selectedalbums[i]);

					// iterate through AlbumsBeans in global variable, albums
					for (AlbumBean album : albums) {
						// selected album is added to cart using album's ID to match with AlbumBean's ID & break out of for loop
						if (album.getID().matches(selectedalbums[i])) {
							cart.addAlbum(album);
							total += album.getPrice();
							System.out.println("Added the following album to cart: " + album.getTitle());
							break;
						}
						
					} // end of for loop to find selected album in global variable, albums

				}
				System.out.println("Finished iterating through the selected albums.");
				System.out.println("You added " + selectedalbums.length + " album(s) to your cart and have a total of " + cart.getAlbums().size() + " albums(s) in your cart now!");

				}
				

				session.setAttribute("shopping", cart);
				session.setAttribute("total", total);
				session.setAttribute("albumBeanBean", cart.getAlbums());
				session.setAttribute("songBeanBean", cart.getSongs());
				session.setAttribute("songAlbumBean", cartAlbumDetailsForSongs);

				RequestDispatcher requestdispatcher = request.getRequestDispatcher("/cart.jsp");
				requestdispatcher.forward(request, response);
				
				
				
				
			} else if (options.equals("Album")) {
				String selectedalbums[] = request.getParameterValues("checkbox-album-albums");
				float total = 0;
				boolean executedalbums = false;
				if (!executedalbums && selectedalbums != null) {
					executedalbums = true;
				// iterate through the albums selected in results.jsp for matching albums in order to add to cart
				for (int i = 0; i < selectedalbums.length; i++) {
					System.out.println("You selected album with ID: " + selectedalbums[i]);

					// iterate through AlbumsBeans in global variable, albums
					for (AlbumBean album : albums) {
						// selected album is added to cart using album's ID to match with AlbumBean's ID & break out of for loop
						if (album.getID().matches(selectedalbums[i])) {
							cart.addAlbum(album);
							total += album.getPrice();
							System.out.println("Added the following album to cart: " + album.getTitle());
							break;
						}
						
					} // end of for loop to find selected album in global variable, albums

				}
				System.out.println("Finished iterating through the selected albums.");
				System.out.println("You added " + selectedalbums.length + " album(s) to your cart and have a total of " + cart.getAlbums().size() + " albums(s) in your cart now!");
		
				}

				session.setAttribute("shopping", cart);
				session.setAttribute("albumBeanBean", cart.getAlbums());
				session.setAttribute("songBeanBean", cart.getSongs());
				session.setAttribute("total", total);


				RequestDispatcher requestdispatcher = request.getRequestDispatcher("/cart.jsp");
				requestdispatcher.forward(request, response);
				
				
				

			} else if (options.equals("Songs")) {
				String selectedsongs[] = request.getParameterValues("checkbox-songs-songs");
				float total = 0;
				// selected songs' album details
				ArrayList<AlbumBean> cartAlbumDetailsForSongs = new ArrayList<AlbumBean>();
				
				boolean executedsongs = false;
				if (!executedsongs && selectedsongs != null) {
					executedsongs = true;
				// iterate through the songs selected in results.jsp for matching songs in order to add to cart
				for (int i = 0; i < selectedsongs.length; i++) {
					System.out.println("You selected song with songID: " + selectedsongs[i]);

					// iterate through SongBeans in global variable, songs
					for (SongBean song : songs) {
						// selected song is added to cart using songID to match with SongBean's songID & break out of for loop
						if (song.getSongID().matches(selectedsongs[i])) {
							cart.addSong(song);
							total += song.getPrice();
							System.out.println("Added the following song to cart: " + song.getTitle());
							// assign string value of albumID for this selected song to songAlbumID
							String songAlbumID = song.getAlbumID();
							for (AlbumBean album : albums) {
								if (album.getID().matches(songAlbumID)) {
									cartAlbumDetailsForSongs.add(album);
									System.out.println("This song is from the album: " + album.getTitle());
									break;
								}
							}
							break;
						}
						
					} // end of for loop to find selected song in global variable, songs

				}
				System.out.println("Finished iterating through the selected songs.");
				System.out.println("You added " + selectedsongs.length + " song(s) to your cart and have a total of " + cart.getSongs().size() + " song(s) in your cart now!");
				
				}
				
				session.setAttribute("shopping", cart);
				session.setAttribute("albumBeanBean", cart.getAlbums());
				session.setAttribute("songBeanBean", cart.getSongs());
				session.setAttribute("songAlbumBean", cartAlbumDetailsForSongs);
				session.setAttribute("total", total);

				RequestDispatcher requestdispatcher = request.getRequestDispatcher("/cart.jsp");
				requestdispatcher.forward(request, response);
			}

		}

	}
	
	protected void getParameter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
