//
//  PodcastViewController.swift
//  Podcast Player
//
//  Created by Ledesma, Alejandra on 5/14/19.
//  Copyright © 2019 Ledesma, Alejandra. All rights reserved.
//

import Cocoa

class PodcastViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var podcastURLTextField: NSTextField!
    
    var podcasts : [Podcast] = []
    var episodesVC : EpisodesViewController? = nil
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        podcastURLTextField.stringValue = "http://feeds.feedburner.com/Ologies"
        
        getPodcasts()
    }
    
    func getPodcasts() {
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let fetchy = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchy.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            do {
                podcasts = try context.fetch(fetchy)
                print(podcasts)
            } catch {}
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    @IBAction func addPodcastClicked(_ sender: Any) {
        
        if let url = URL(string: podcastURLTextField.stringValue){
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                if error != nil {
                    print("BIG FAIL")
                    
                } else {
                    if data != nil {
                        let parser = Parser()
                        let info = parser.getPodcastMataData(data: data!)
                        
                        if !self.podcastExists(rssURL: self.podcastURLTextField.stringValue) {
                            
                            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                                let podcast = Podcast(context: context)
                                DispatchQueue.main.async {
                                    podcast.rssURL = self.podcastURLTextField.stringValue
                                }
                                
                                podcast.imageURL = info.imageURL
                                podcast.title = info.title
                                
                                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                                
                                self.getPodcasts()
                                DispatchQueue.main.async {
                                    // Clear input text field
                                    self.podcastURLTextField.stringValue = ""
                                }
                            }
                        }
                    }
                    
                }
                }.resume()
        }
        
    }
    
    func podcastExists(rssURL:String) -> Bool {
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let fetchy = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchy.predicate = NSPredicate(format: "rssURL == %@", rssURL)
            
            do {
                let matchingPodcasts = try context.fetch(fetchy)
                if matchingPodcasts.count >= 1{
                    return true
                } else {
                    return false
                }
                
            } catch {}
            
        }
        return false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "podcastcell"), owner: self) as? NSTableCellView
        
        let podcast = podcasts[row]
        
        if podcast.title != nil {
            cell?.textField?.stringValue = podcast.title!
        } else {
            cell?.textField?.stringValue = "UNKNOWN TITLE"
        }
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow >= 0 {
            let podcast = podcasts[tableView.selectedRow]
            
            episodesVC?.podcast = podcast
            
            episodesVC?.updateView()
        }
    }
}
