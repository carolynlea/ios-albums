//
//  AlbumController.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

class AlbumController
{
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


