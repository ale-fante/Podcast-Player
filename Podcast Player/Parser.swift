//
//  Parser.swift
//  Podcast Player
//
//  Created by Ledesma, Alejandra on 5/14/19.
//  Copyright © 2019 Ledesma, Alejandra. All rights reserved.
//

import Foundation


class Parser {
    func getPodcastMataData(data:Data) -> String? {
        print("WOHOOO")
        let xml = SWXMLHash.parse(data)

        return xml["rss"]["channel"]["title"].element?.text
    }
}
