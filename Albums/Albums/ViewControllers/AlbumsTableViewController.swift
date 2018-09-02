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

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)

        

        return cell
    }

    
    // MARK: - Navigation
    // ToAddSongView, ToAlbumDetailView
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
    

}
