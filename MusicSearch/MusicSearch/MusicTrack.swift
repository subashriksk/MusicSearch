//
//  MusicTrack.swift
//  MusicSearch
//
//  Created by Suba shri Kulandai Samy on 1/11/17.
//  Copyright © 2017 Suba shri Kulandai Samy. All rights reserved.
//

import UIKit

class MusicTrack: NSObject {

    var wrapperType:String?
    var kind:String?
    var artistId:String?
    var collectionId:String?
    var trackId:String?
    var artistName:String?
    var collectionName:String?
    var trackName:String?
    var collectionViewUrl:String?
    var collectionCensoredName:String?
    var trackCensoredName:String?
    var artistViewUrl:String?
    var trackViewUrl:String?
    var previewUrl:String?
    var artworkUrl30:String?
    var artworkUrl60:String?
    var artworkUrl100:String?
    var collectionPrice:Float?
    var trackPrice:Float?
    var releaseDate:NSDate?
    var collectionExplicitness:String?
    var trackExplicitness:String?
    var discCount:NSInteger?
    var discNumber:NSInteger?
    var trackCount:NSInteger?
    var trackNumber:NSInteger?
    var trackTimeMillis:NSInteger?
    var country:String?
    var currency:String?
    var primaryGenreName:String?
    var isStreamable:Bool?

    /**
     initilaises the object with the values from the dictionary
     */
     init(dict:NSDictionary){
        
        wrapperType = dict.value(forKey: "wrapperType") as? String
        kind = dict.value(forKey: "kind") as? String
        artistId = dict.value(forKey: "artistId") as? String
        collectionId = dict.value(forKey: "collectionId") as? String
        trackId = dict.value(forKey: "trackId") as? String
        artistName = dict.value(forKey: "artistName") as? String
        collectionName = dict.value(forKey: "collectionName") as? String
        trackName = dict.value(forKey: "trackName") as? String
        collectionViewUrl = dict.value(forKey: "collectionViewUrl") as? String
        collectionCensoredName = dict.value(forKey: "collectionCensoredName") as? String
        trackCensoredName = dict.value(forKey: "trackCensoredName") as? String
        artistViewUrl = dict.value(forKey: "artistViewUrl") as? String
        trackViewUrl = dict.value(forKey: "trackViewUrl") as? String
        previewUrl = dict.value(forKey: "previewUrl") as? String
        artworkUrl30 = dict.value(forKey: "artworkUrl30") as? String
        artworkUrl60 = dict.value(forKey: "artworkUrl60") as? String
        artworkUrl100 = dict.value(forKey: "artworkUrl100") as? String
        collectionPrice = dict.value(forKey: "collectionPrice") as? Float
        trackPrice = dict.value(forKey: "trackPrice") as? Float
        collectionExplicitness = dict.value(forKey: "collectionExplicitness") as? String
        trackExplicitness = dict.value(forKey: "trackExplicitness") as? String
        country = dict.value(forKey: "country") as? String
        currency = dict.value(forKey: "currency") as? String
        primaryGenreName = dict.value(forKey: "primaryGenreName") as? String
        discCount = dict.value(forKey: "discCount") as? NSInteger
        discNumber = dict.value(forKey: "discNumber") as? NSInteger
        trackCount = dict.value(forKey: "trackCount") as? NSInteger
        trackNumber = dict.value(forKey: "trackNumber") as? NSInteger
        trackTimeMillis = dict.value(forKey: "trackTimeMillis") as? NSInteger
        isStreamable = dict.value(forKey: "isStreamable") as? Bool

        if let date = dict.value(forKey: "releaseDate") as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            releaseDate = formatter.date(from:date) as NSDate?
        }
    }
}
