//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController
{
    var albumController: AlbumController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        albumController?.getAlbums(completion: { (error) in
            if error != nil
            {
                
            }
            else
            {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albumController?.albums.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        let album = albumController?.albums[indexPath.row]
        cell.textLabel?.text = album?.albumName
        cell.detailTextLabel?.text = album?.artist

        return cell
    }

    
    // MARK: - Navigation
    // ToAddSongView, ToAlbumDetailView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let destinationVC = segue.destination as? AlbumDetailTableViewController else {return}
        
        if segue.identifier == "ToAddSongView"
        {
            destinationVC.albumController = albumController
        }
        else if segue.identifier == "ToAlbumDetailView"
        {
            destinationVC.albumController = albumController
            if let indexPath = tableView.indexPathForSelectedRow
            {
                destinationVC.album = albumController?.albums[indexPath.row]
            }
            
        }
        
    }
    

}
