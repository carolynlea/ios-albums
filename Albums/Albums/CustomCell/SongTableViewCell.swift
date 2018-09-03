//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class
{
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell
{
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    weak var delegate: SongTableViewCellDelegate?
    var song: Song?
    
    
    func updateViews()
    {
        if song == song
        {
            songTitleTextField.text = song?.name
            durationTextField.text = song?.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        songTitleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    @IBAction func addSong(_ sender: Any)
    {
        guard let songText = songTitleTextField.text,
            let durationText = durationTextField.text else {return}
        
        delegate?.addSong(with: songText, duration: durationText)
    }
}
