//
//  Episode.swift
//  Podcast Player
//
//  Created by Ledesma, Alejandra on 5/16/19.
//  Copyright © 2019 Ledesma, Alejandra. All rights reserved.
//

import Foundation
import Cocoa

class Episode {
    var title = ""
    var pubDate = Date()
    var htmlDescription = ""
    var audioURL = ""
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return formatter
    }()
}
