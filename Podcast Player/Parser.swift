//
//  Parser.swift
//  Podcast Player
//
//  Created by Ledesma, Alejandra on 5/14/19.
//  Copyright © 2019 Ledesma, Alejandra. All rights reserved.
//

import Foundation


class Parser {
    func getPodcastMataData(data:Data) -> (title:String?, imageURL:String?) {

        let xml = SWXMLHash.parse(data)
        
        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text as Any)
        
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
    }
    
    func getEpisodes(data: Data) -> [Episode] {
        
        let xml = SWXMLHash.parse(data)
        
        var episodes : [Episode] = []
        
        for item in xml["rss"]["channel"]["item"].all {
            print(item["title"])
            
            let episode = Episode()
            if let title = item["title"].element?.text {
                episode.title = title
            }
            

            if let htmlDescription = item["description"].element?.text {
                episode.htmlDescription = htmlDescription
            }
            
            if let audioURL = item["link"].element?.text {
                episode.audioURL = audioURL
            }
            
            if let pubDate = item["pubDate"].element?.text {
                if let date = Episode.formatter.date(from: pubDate) {
                    episode.pubDate = date
                }
            }
            episodes.append(episode)
            print(episode.pubDate)
        }
        
        return episodes
    }
}
