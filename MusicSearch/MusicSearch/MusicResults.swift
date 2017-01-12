//
//  MusicResults.swift
//  MusicSearch
//
//  Created by Suba shri Kulandai Samy on 1/11/17.
//  Copyright © 2017 Suba shri Kulandai Samy. All rights reserved.
//

import UIKit

class MusicResults: NSObject {
    
    var resultCount:NSInteger?
    var results = [Any]()
    
    /**
     initilaises the object with the values from the dictionary
     */
     init(dict:NSDictionary){
        
        resultCount = dict.value(forKey: "resultCount") as? NSInteger
        if let arrResults = dict.value(forKey: "results"){
            for result in arrResults as! NSArray{
                let track = MusicTrack.init(dict: result as! NSDictionary)
                results.append(track)
            }
        }
    }
    
}
