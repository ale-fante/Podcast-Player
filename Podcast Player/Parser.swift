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
        
        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text ?? <#default value#>)
        
        return xml["rss"]["channel"]["title"].element?.text
    }
}
