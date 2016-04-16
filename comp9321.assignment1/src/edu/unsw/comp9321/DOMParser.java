package edu.unsw.comp9321;

import java.util.ArrayList;

import java.util.logging.Logger;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class DOMParser {
//	Logger logger = Logger.getLogger(this.getClass().getName());
	
	
	public DOMParser(){}
	
	public ArrayList<AlbumBean> translateToAlbums(Document doc) {
		
		// Here comes the root node
	    Element root = doc.getDocumentElement();
	    System.out.println(root.getNodeName());
		
	    // Get all albumList elements by tag
		NodeList albumNodes = doc.getElementsByTagName("albumList");
		System.out.println(albumNodes.getLength() + " albums in total");
		
		ArrayList<AlbumBean> albumList = new ArrayList<AlbumBean>();
		
		for (int i = 0; i < albumNodes.getLength(); i++) {
			AlbumBean b = new AlbumBean();
			
			Node n = albumNodes.item(i);
			NodeList albumElements = n.getChildNodes();
			
			for (int j = 0; j < albumElements.getLength(); j++ ) {
				
				Node e = albumElements.item(j);
//				logger.info(e.getNodeName()+":"+e.getTextContent());
				
				if(e.getNodeName().equalsIgnoreCase("artist"))
					b.setArtist(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("title"))
					b.setTitle(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("ID"))
					b.setID(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("genre"))
					b.setGenre(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("publisher"))
					b.setPublisher(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("year"))
					b.setYear(Integer.parseInt(e.getTextContent()));
				if(e.getNodeName().equalsIgnoreCase("price"))
					b.setPrice(Float.parseFloat(e.getTextContent()));
			}
			// concatenate all the fields into 1 array list string for searching, put into bean together with other fields' array lists
			b.setSearchString(b.getArtist() + b.getTitle() + b.getID() + b.getGenre() + b.getPublisher() + b.getYear() + b.getPrice() );
			albumList.add(b);
		}
		return albumList;		
	}
	
	public ArrayList<SongBean> translateToSongs(Document doc) {
		
		// Here comes the root node
	    Element root = doc.getDocumentElement();
	    System.out.println(root.getNodeName());
		
	    // Get all songList elements by tag
		NodeList songNodes = doc.getElementsByTagName("songList");
		System.out.println(songNodes.getLength() + " songs in total");
		
		ArrayList<SongBean> songList = new ArrayList<SongBean>();
		
		for (int i = 0; i < songNodes.getLength(); i++) {
			SongBean b = new SongBean();
			
			Node n = songNodes.item(i);
			NodeList songElements = n.getChildNodes();
			
			for (int j = 0; j < songElements.getLength(); j++ ) {
				
				Node e = songElements.item(j);
//				logger.info(e.getNodeName()+":"+e.getTextContent());
				
				if(e.getNodeName().equalsIgnoreCase("artist"))
					b.setArtist(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("title"))
					b.setTitle(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("albumID"))
					b.setAlbumID(e.getTextContent());
				if(e.getNodeName().equalsIgnoreCase("price"))
					b.setPrice(Float.parseFloat(e.getTextContent()));
				if(e.getNodeName().equalsIgnoreCase("songID"))
					b.setSongID(e.getTextContent());
			}
			
			// concatenate all the fields into 1 array list string for searching, put into bean together with other fields' array lists
			b.setSearchString(b.getArtist() + b.getTitle() + b.getAlbumID() + b.getPrice() + b.getSongID() );
			songList.add(b);
		}
		return songList;		
	}

}