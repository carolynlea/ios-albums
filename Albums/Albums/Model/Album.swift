//
//  Album.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct Album: Codable
{
    var artist: String
    var coverArt: [URL]
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
//
//        enum GenresCodingKeys: String, CodingKey
//        {
//            case genres
//        }
    }
    
    init(from decoder: Decoder) throws
    {
        // container
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // artist
        
        let artist = try container.decode(String.self, forKey: .artist)
        
        // identifier
        
        let identifier = try container.decode(String.self, forKey: .identifier)
        
        // albumName
        
        let albumName = try container.decode(String.self, forKey: .albumName)
        
        // genres
        
        let genres = try container.decode([String].self, forKey: .genres)
        
        // coverArt
        
        var coversContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        var coverURLStrings: [String] = []
        
        while !coversContainer.isAtEnd
        {
            let coverContainer = try coversContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            let coverArtURL = try coverContainer.decode(String.self, forKey: .url)
            coverURLStrings.append(coverArtURL)
        }
        
        let coverArt = coverURLStrings.compactMap({ URL(string: $0 )})
        
        // songs
        
        var songsContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        var songArray: [[String]] = []
        
        while !songsContainer.isAtEnd
        {
            // song title
            
            let songContainer = try songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            
            let songNameContainer = try songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.SongNameCodingKeys.self, forKey: .name)
            let song = try songNameContainer.decode(String.self, forKey: .title)
            
            // duration
            
            let durationContainer = try songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.DurationCodingKeys.self, forKey: .duration)
            
            let duration = try durationContainer.decode(String.self, forKey: .duration)
            
            
            // identifier
            
            let identifier = try songContainer.decode(String.self, forKey: .identifier)
            
            let songElements = [song, duration, identifier]
            songArray.append(songElements)
        }
        
        self.artist = artist
        self.identifier = identifier
        self.albumName = albumName
        self.genres = genres
        self.coverArt = coverArt
        self.songs = Array(songArray)
        
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artist, forKey: .artist)
        
        try container.encode(identifier, forKey: .identifier)
        
        try container.encode(albumName, forKey: .albumName)
        
        try container.encode(genres, forKey: .genres)
        
        var albumCoversContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        
        for cover in coverArt
        {
            var coverContainer = albumCoversContainer.nestedContainer(keyedBy: CodingKeys.CoverArtCodingKeys.self)
            try coverContainer.encode(cover, forKey: .url)
        }
        
        var songsContainer = container.nestedUnkeyedContainer(forKey: .songs)
        
        for song in songs
        {
            var songContainer = songsContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.self)
            
            var songNameContainer = songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.SongNameCodingKeys.self, forKey: .name)
            
            try songNameContainer.encode(song, forKey: .title)
            
            var durationContainer = songContainer.nestedContainer(keyedBy: CodingKeys.SongsCodingKeys.DurationCodingKeys.self, forKey: .duration)
            
            try durationContainer.encode(song, forKey: .duration)
            
            try songContainer.encode(song, forKey: .identifier)
        }
        
        
    }
    
    
    
    
    
    
    
 //@end
}
