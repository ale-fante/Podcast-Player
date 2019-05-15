//
//  PodcastViewController.swift
//  Podcast Player
//
//  Created by Ledesma, Alejandra on 5/14/19.
//  Copyright © 2019 Ledesma, Alejandra. All rights reserved.
//

import Cocoa

class PodcastViewController: NSViewController {
    
    @IBOutlet weak var podcastURLTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        podcastURLTextField.stringValue = "http://www.espn.com/espnradio/podcast.feeds/itunes/podCast?id=2406595"
    }
    
    @IBAction func addPodcastClicked(_ sender: Any) {
        
        if let url = URL(string: podcastURLTextField.stringValue){
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                if error != nil {
                    print("BIG FAIL")
                    
                } else{
                    if data != nil{
                        let parser = Parser()
                        if let title = parser.getPodcastMataData(data: data!) {
                            print(title)
                        }
                    }
                    
                }
                }.resume()
            
            // Clear input text field
            self.podcastURLTextField.stringValue = ""
        }
    }
}
