//
//  TrackViewController.swift
//  MusicSearch
//
//  Created by Suba shri Kulandai Samy on 1/12/17.
//  Copyright © 2017 Suba shri Kulandai Samy. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblTrack: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblAlbum: UILabel!
    @IBOutlet weak var lblLyrics: UILabel!
    @IBOutlet weak var btnMoreDetails: UIButton!
    @IBOutlet weak var vwLoading: UIActivityIndicatorView!
    var track:MusicTrack?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Price units can be added based on the currency
        lblPrice.text =  String(format:"%.2f", (track?.trackPrice)!)
        lblTrack.text = track!.trackName
        lblArtist.text = track!.artistName
        lblAlbum.text = track!.collectionName

        //load the image from the url
        DispatchQueue.global(qos: .background).async {
            let url = NSURL.init(string: (self.track?.artworkUrl100)! as String)
            if let data = NSData.init(contentsOf: url as! URL){
                DispatchQueue.main.async {
                    self.imgVw.image = UIImage(data: data as Data)
                }
            }
        }
        
        //get the lyrics from wiki
        vwLoading.startAnimating()
        MusicHelper.getLyricsForTrack(track: track!) { (succeeded, lyrics) in
            DispatchQueue.main.async {
                self.vwLoading.stopAnimating()
                if succeeded{
                    print("Suceeded")
                    
                    //refresh teh view with lyrics
                    self.lblLyrics.text = lyrics
                }
                else{
                    print("Failed")
                }
            }

        }
    }

    /*
    called out when the more details button is tapped
    */
    @IBAction func moreDetailsTapped(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: (track?.trackViewUrl)!) as! URL, options: [:], completionHandler: nil)
    }

}
