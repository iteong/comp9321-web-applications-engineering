package edu.unsw.comp9321;

import java.util.ArrayList;

public class CartBean {

	public CartBean(){}
	
	private ArrayList<SongBean> SongsCart = new ArrayList<SongBean>();
	private ArrayList<AlbumBean> AlbumsCart = new ArrayList<AlbumBean>();
	
	// functions to add song and album to respective SongsCart and AlbumsCart ArrayLists
	public void addSong(SongBean song) {
		SongsCart.add(song);
	}
	public void addAlbum(AlbumBean album) {
		SongsCart.remove(album);
	}
	
	// function to remove item (be it song or album) by its ID
	public void remove(int itemID) {
		SongsCart.remove(itemID);
	}

	// function to get ArrayList for SongsCart or AlbumsCart containing respective beans
	public ArrayList<SongBean> getSongs() {
		return SongsCart;
	}
	public ArrayList<AlbumBean> getAlbums() {
		return AlbumsCart;
	}
	
	// function to check the number of songs inside SongsCart or AlbumsCart
	public int getSongsSize() {
		return SongsCart.size();
	}
	public int getAlbumsSize() {
		return AlbumsCart.size();
	}

}