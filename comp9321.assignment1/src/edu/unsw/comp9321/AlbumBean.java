package edu.unsw.comp9321;

import java.util.ArrayList;

public class AlbumBean {
	private String artist;
	private String title;
	private String ID;
	private String genre;
	private String publisher;
	private int year;
	private ArrayList<SongBean> songList;
	private float price;
	private String searchString;
	
	public AlbumBean(){}
	
	public AlbumBean(String artist, String title, String ID,
			String genre, String publisher, int year, float price) {
		super();
		this.artist = artist;
		this.title = title;
		this.ID = ID;
		this.genre = genre;
		this.publisher = publisher;
		this.year = year;
		this.price = price;
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
	
	public String getID() {
		return ID;
	}
	public void setID(String ID) {
		this.ID = ID;
	}
	
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	
	public ArrayList<SongBean> getSongList() {
		return songList;
	}
	public void setSongList(SongBean song) {
		if (this.songList == null) {
			this.songList = new ArrayList<SongBean>();
		} 
		
		this.songList.add(song);
	}
	
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}

	// search String is concatenation of all the fields to make it faster to search for something
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
}
