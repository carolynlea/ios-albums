//
//  Album.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct Song: Codable, Equatable
{
    var duration: String
    var identifier: String
    var name: String
    
    
    enum CodingKeys: String, CodingKey
    {
        case duration
        case identifier = "id"
        case name
        
        enum DurationCodingKeys: String, CodingKey
        {
            case duration
        }
        
        enum SongNameCodingKeys: String, CodingKey
        {
            case title
        }
    }
}

struct Album: Codable, Equatable
{
    var artist: String
    var coverArt: [URL]
    var genres: [String]
    var identifier: String
    var albumName: String
    var songs: [[String]]
    
    init(artist: String, coverArt: [URL], genres: [String], identifier: String, albumName: String, songs: [[String]])
    {
        self.artist = artist
        self.coverArt = coverArt
        self.genres = genres
        self.identifier = identifier
        self.albumName = albumName
        self.songs = songs
    }
    
    enum CodingKeys: String, CodingKey
    {
        case artist
        case coverArt
        case genres
        case identifier = "id"
        case albumName = "name"
        case songs
        
        enum CoverArtCodingKeys: String, CodingKey
        {
            case url
        }
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
            let songContainer = try songsContainer.nestedContainer(keyedBy: Song.CodingKeys.self)

            // duration

            let durationContainer = try songContainer.nestedContainer(keyedBy: Song.CodingKeys.DurationCodingKeys.self, forKey: .duration)

            let duration = try durationContainer.decode([String].self, forKey: .duration)
            print(duration)

            // identifier

            let identifier = try songContainer.decode(String.self, forKey: .identifier)
            print(identifier)

            // song title

            let songNameContainer = try songContainer.nestedContainer(keyedBy: Song.CodingKeys.SongNameCodingKeys.self, forKey: .name)

            let title = try songNameContainer.decode(String.self, forKey: .title)
            print(title)
        }
        
        
        
        self.artist = artist
        self.identifier = identifier
        self.albumName = albumName
        self.genres = genres
        self.coverArt = coverArt
        self.songs = songArray
        
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
            var songContainer = songsContainer.nestedContainer(keyedBy: Song.CodingKeys.self)
            
            var durationContainer = songContainer.nestedContainer(keyedBy: Song.CodingKeys.DurationCodingKeys.self, forKey: .duration)

            try durationContainer.encode(song, forKey: .duration)
            
            try songContainer.encode(song, forKey: .identifier)
            
            var songNameContainer = songContainer.nestedContainer(keyedBy: Song.CodingKeys.SongNameCodingKeys.self, forKey: .name)
            
            try songNameContainer.encode(song, forKey: .title)
        }
        
        
    }
    
 //@end
}



