//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate
{
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var coverURLTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var albumController: AlbumController?
    var album: Album?
    {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func save(_ sender: Any)
    {
        guard let title = albumNameTextField.text,
            let artist = artistTextField.text,
            let genre = genreTextField.text,
            let cover = coverURLTextField.text,
            let identifier = identifierTextField.text else {return}
        
        if let album = self.album
        {
//            albumController?.update(album: album, artist: artist, coverArt: [], genres: [genre], identifier: identifier, albumName: title, songs: [tempSongs], completion: { (error) in
//                if error != nil
//                {
//                    return
//                }
//            })
        }
        else
        {
//            albumController?.createAlbum(artist: artist, coverArt: cover, genres: genre, identifier: identifier, albumName: title, songs: tempSongs, completion: { (error) in
//                if error != nil
//                {
//
//                }
//            })
        }
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tempSongs.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell

        

        return cell
    }
    
    func addSong(with title: String, duration: String)
    {
        let song = albumController?.createSong(duration: duration, name: title)
        tempSongs.append(song!)
        tableView.reloadData()
        
        tableView.beginUpdates()
        
        let indexPath:IndexPath = IndexPath(row:(tempSongs.count - 1), section:0)
        
        tableView.insertRows(at: [indexPath], with: .left)
        
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)

    }
    
    func updateViews()
    {
        guard isViewLoaded else {return}
        
        if album != nil
        {
            title = album?.albumName
            album?.albumName = albumNameTextField.text!
            album?.artist = artistTextField.text!
            
            var joinedGenres = album?.genres.map{String($0)}.joined(separator: ",")
            joinedGenres = genreTextField.text
            
            if let urlArray = album?.coverArt
            {
                var joinedUrls = urlArray.map({String(describing: $0)}).joined(separator: ",")
                joinedUrls = coverURLTextField.text!
            }
            
            album?.identifier = identifierTextField.text!
            
        }
        else
        {
            title = "NewAlbum"
        }
        
        
    }
    

}
