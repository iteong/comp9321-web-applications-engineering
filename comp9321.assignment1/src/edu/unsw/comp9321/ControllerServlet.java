package edu.unsw.comp9321;

import java.io.IOException;

import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		
		System.out.println("Action: " + action);
		
		// get the songs and albums objects containing data needed from session
//		System.out.println(songs.size());
//		System.out.println(albums.size());
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
								if (song.getSearchString().contains(content) ) {
					                   resultsArraySongs.add(song);
					                   System.out.println(resultsArraySongs);
					               }
							}
							request.setAttribute("searchresultsSongs", resultsArraySongs);
							
							for (AlbumBean album : albums) {
								if (album.getSearchString().contains(content) ) {
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
								if (song.getArtist().contains(content) ) {
					                   resultsArraySongs.add(song);
					                   System.out.println(resultsArraySongs);
					               }
							}
							request.setAttribute("searchresultsSongs", resultsArraySongs);
							
							for (AlbumBean album : albums) {
								if (album.getArtist().contains(content) ) {
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
								if (song.getTitle().contains(content) || song.getsongID().contains(content)) {
					                   resultsArraySongs.add(song);
					                   System.out.println(resultsArraySongs);
					               }
								
								// assign string value of albumID for this random song to songAlbumID
			       				String songAlbumID = song.getAlbumID();
			       				for (AlbumBean album : albums) {
									if (album.getID().contains(songAlbumID)) {
						                   resultsArrayAlbums.add(album);
						                   System.out.println(resultsArrayAlbums);
						                   break;
						               }
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
								if (album.getTitle().contains(content) || album.getID().contains(content) ) {
					                   resultsArray.add(album);
					                   System.out.println(resultsArray);
					               }
							}
							request.setAttribute("searchresults", resultsArray);
						}
						
					}
					// end of else loop for search content that is not empty
				}
		
		RequestDispatcher requestdispatcher = request.getRequestDispatcher("/results.jsp");   
		requestdispatcher.forward(request, response);
	}
	
	protected void getParameter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
