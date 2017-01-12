//
//  SearchHelper.swift
//  MusicSearch
//
//  Created by Suba shri Kulandai Samy on 1/11/17.
//  Copyright © 2017 Suba shri Kulandai Samy. All rights reserved.
//

import UIKit

class MusicHelper: NSObject {
    
    class func getTracksForKeyword(strKeyword:String, completion:@escaping (_ succeeded:Bool, _ results:AnyObject)->()){
        let strUrl: String = "https://itunes.apple.com/search?term=" + strKeyword.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: strUrl) else {
            print("Url cannot be formed")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // creating new session
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            //checking for failure scenarios
            guard let responseData = data else {
                print("Data is nil")
                completion(false,"" as AnyObject)
                return
            }
            guard error == nil else {
                print(error ?? "Error")
                completion(false,"" as AnyObject)
                return
            }
            // parse the json and create objects
            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("Json cannot be formed")
                    completion(false,"" as AnyObject)
                    return
                }
                let musicResults = MusicResults.init(dict: json as NSDictionary)
                completion(true,musicResults)

            } catch  {
                print("Json cannot be formed")
                completion(false,"" as AnyObject)
                return
            }
        }
        task.resume()
    }
    
    //Can be made to have a common class for the networking instead of creating session for each helper class
    class func getLyricsForTrack(track:MusicTrack, completion:@escaping (_ succeeded:Bool, _ lyrics:String)->()){
        
        let strUrl = String(format: "http://lyrics.wikia.com/api.php?func=getSong&artist=%@&song=%@&fmt=json", track.artistName!.replacingOccurrences(of: " ", with: "+"), track.trackName!.replacingOccurrences(of: " ", with: "+"))
        guard let url = URL(string: strUrl) else {
            print("Url cannot be formed")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // creating new session
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            //checking for failure scenarios
            guard let responseData = data else {
                print("Data is nil")
                completion(false,"")
                return
            }
            guard error == nil else {
                print(error ?? "Error")
                completion(false,"")
                return
            }
            // parse the json and create objects
            do {
                
                //adjusting the format to pass to json serialization
                var strJson = String(data: responseData, encoding: String.Encoding.utf8)
                strJson = strJson?.replacingOccurrences(of: "song = ", with: "")
                strJson = strJson?.replacingOccurrences(of: "'", with: "\"")
                let data =  strJson?.data(using: String.Encoding.utf8)
                
                guard let json = try JSONSerialization.jsonObject(with:data!, options: .allowFragments) as? [String: AnyObject] else {
                    print("Json cannot be formed")
                    completion(false,"")
                    return
                }
                let songDetails = TrackLyrics.init(dict: json as NSDictionary)
                completion(true,songDetails.lyrics!)
                
            } catch  {
                print("Json cannot be formed")
                completion(false,"")
                return
            }
        }
        task.resume()
    }

    
    
}
