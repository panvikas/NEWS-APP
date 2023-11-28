//
//  NewsFeed.swift
//  FetchApi
//
//  Created by Vikas Pandey on 04/07/22.
//

import Foundation

struct NewsFeed: Codable {
    
    var status:String = ""
    var totalResults:Int = 0
    var articles:[Article]?
}
