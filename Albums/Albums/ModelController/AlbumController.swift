//
//  AlbumController.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://mymovies-dee4d.firebaseio.com/")!

class AlbumController
{
    var albums: [Album] = []
    
    func getAlbums(completion: @escaping (Error?) -> Void)
    {
        let url = baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("error \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do
            {
                let jsonDecoder = JSONDecoder()
                let albumArray = Array(try jsonDecoder.decode([String: Album].self, from: data))
                
                let albumList = albumArray.map({ $0.value })
                self.albums = albumList
            }
            catch
            {
                NSLog("error \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        .resume()
    }
    
    func putAlbum(album: Album, completion: @escaping (Error?) -> Void)
    {
        let requestURL = baseURL.appendingPathComponent(album.identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do
        {
            request.httpBody = try JSONEncoder().encode(album)
        }
        catch
        {
            NSLog("Error encoding album \(album): \(album)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("Error saving album on server: \(error)")
                completion(error)
                return
            }
            
            DispatchQueue.main.async {
                self.albums.append(album)
                completion(nil)
            }
        }
        .resume()
    }
    
    func createAlbum(artist: String, coverArt: [URL], genres: [String], identifier: String, albumName: String, songs: [[String]], completion: @escaping (Error?) -> Void)
    {
        let album = Album(artist: artist, coverArt: coverArt, genres: genres, identifier: identifier, albumName: albumName, songs: songs)
        albums.append(album)
        putAlbum(album: album, completion: completion)
    }
    
    func createSong(name: String, identifier: String, duration: String, completion: @escaping (Error?) -> Void) -> Song
    {
        let song = Song(name: name, identifier: identifier, duration: duration)
        
        return song
    }
    
    func update(album: Album, artist: String, coverArt: [URL], genres: [String], identifier: String, albumName: String, songs: [[String]], completion: @escaping (Error?) -> Void)
    {
        if let index = albums.index(of: album)
        {
            var tempAlbum = album
            tempAlbum.artist = artist
            tempAlbum.coverArt = coverArt
            tempAlbum.genres = genres
            tempAlbum.identifier = identifier
            tempAlbum.albumName = albumName
            tempAlbum.songs = songs
            
            albums.remove(at: index)
            albums.insert(tempAlbum, at: index)
            putAlbum(album: album, completion: completion)
        }
    }
    
    func testDecodingExampleAlbum()
    {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("unable to find file")
            return
        }
        
        do
        {
            let exampleData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: exampleData)
            print(album)
        }
        catch
        {
            print("Error getting data or decoding data: \(error)")
        }
    }
    
    func testEncodingExampleAlbum()
    {
        guard let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else {
            print("unable to find file")
            return
        }
        
        do
        {
            let exampleData = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: exampleData)
            _ = try JSONEncoder().encode(album)
            print(album)
        }
        catch
        {
            print("Error getting data or decoding data: \(error)")
        }
    }
    
    
    
    
    
    
 //@end
}


