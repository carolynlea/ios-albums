//
//  Album.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct Album: Decodable
{
    var artist: String
    var coverArt: [String]
    var genres: [String]
    var identifier: String
    var albumName: String
    var songs: [[String]]
    
    enum CodingKeys: String, CodingKey
    {
        case artist
        case coverArt
        case genres
        case identifier = "id"
        case albumName = "name"
        case songs
        
        enum SongsCodingKeys: String, CodingKey
        {
            case name
            case identifier = "id"
            case duration
            
            enum SongNameCodingKeys: String, CodingKey
            {
                case title
            }
            
            enum DurationCodingKeys: String, CodingKey
            {
                case duration
            }
        }
        
        enum CoverArtCodingKeys: String, CodingKey
        {
            case url
        }
    }
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let artist = try container.decode(String.self, forKey: .artist)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let albumName = try container.decode(String.self, forKey: .albumName)
        let genres = try container.decode(String.self, forKey: .genres)
        
        let coverArtContainer = try container.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self, forKey: .coverArt)
        let coverArt = try coverArtContainer.decode(String.self, forKey: .url)
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        var songArray: [[String]] = []
        
        while !songsContainer.isAtEnd
        {
            let songContainer = try songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            
            let songNameContainer = try songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.SongNameCodingKeys.self)
            let song = try songNameContainer.decode(String.self, forKey: .title)
            
            let durationContainer = try songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.DurationCodingKeys.self)
            let duration = try durationContainer.decode(String.self, forKey: .duration)
            
            let identifier = try songContainer.decode(String.self, forKey: .identifier)
            
            let songElements = [song, duration, identifier]
            songArray.append(songElements)
        }
        
        self.artist = artist
        self.identifier = identifier
        self.albumName = albumName
        self.genres = [genres]
        self.coverArt = [coverArt]
        self.songs = Array(songArray)
        
    }
    
}
