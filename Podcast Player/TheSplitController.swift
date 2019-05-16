//
//  TheSplitController.swift
//  Podcast Player
//
//  Created by Ledesma, Alejandra on 5/16/19.
//  Copyright © 2019 Ledesma, Alejandra. All rights reserved.
//

import Cocoa

class TheSplitController: NSSplitViewController {

    @IBOutlet weak var episodesItem: NSSplitViewItem!
    @IBOutlet weak var podcastItem: NSSplitViewItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if let podcastsVC = podcastItem.viewController as? PodcastViewController {
            if let episodesVC = episodesItem.viewController as? EpisodesViewController {
                podcastsVC.episodesVC = episodesVC
                episodesVC.podcastsVC = podcastsVC
            }
        }
    }
    
}
