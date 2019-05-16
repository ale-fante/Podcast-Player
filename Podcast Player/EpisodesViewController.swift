//
//  EpisodesViewController.swift
//  Podcast Player
//
//  Created by Ledesma, Alejandra on 5/15/19.
//  Copyright © 2019 Ledesma, Alejandra. All rights reserved.
//

import Cocoa

class EpisodesViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var pausePlayButton: NSButton!
    
    @IBOutlet weak var tableView: NSTableView!
    
    var podcast : Podcast? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        if podcast != nil {
            titleLabel.stringValue = podcast!.title!
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
    }
    
    
    @IBAction func pausePlayClicked(_ sender: Any) {
    }
    
}
