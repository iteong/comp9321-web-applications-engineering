package edu.unsw.comp9321;

public class SongBean {
	private String artist;
	private String title;
	private String albumID;
	private float price;
	private String songID;
	private String searchString;

	public SongBean(){}
	
	public SongBean(String artist, String title, String albumID,
			String songID, float price) {
		super();
		this.artist = artist;
		this.title = title;
		this.albumID = albumID;
		this.price = price;
		this.songID = songID;

	}
	
	public String getArtist() {
		return artist;
	}
	public void setArtist(String artist) {
		this.artist = artist;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getAlbumID() {
		return albumID;
	}
	public void setAlbumID(String albumID) {
		this.albumID = albumID;
	}
	
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	
	public String getSongID() {
		return songID;
	}
	public void setSongID(String songID) {
		this.songID = songID;
	}
	
	// search String is concatenation of all the fields to make it faster to search for something
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
}
