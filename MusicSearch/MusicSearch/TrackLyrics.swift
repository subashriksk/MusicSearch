//
//  TrackLyrics.swift
//  MusicSearch
//
//  Created by Suba shri Kulandai Samy on 1/12/17.
//  Copyright © 2017 Suba shri Kulandai Samy. All rights reserved.
//

import UIKit

class TrackLyrics: NSObject {
    var artist:String?
    var song:String?
    var lyrics:String?
    var url:String?
    
    /**
     initilaises the object with the values from the dictionary
     */
    init(dict:NSDictionary){
            artist = (dict as AnyObject).value(forKey: "artist") as? String
            song = (dict as AnyObject).value(forKey: "song") as? String
            lyrics = (dict as AnyObject).value(forKey: "lyrics") as? String
            url = (dict as AnyObject).value(forKey: "url") as? String
        }
}
