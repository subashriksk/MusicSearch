//
//  TracksCollectionViewCell.swift
//  MusicSearch
//
//  Created by Suba shri Kulandai Samy on 1/11/17.
//  Copyright © 2017 Suba shri Kulandai Samy. All rights reserved.
//

import UIKit

class TracksGridCollectionViewCell: UICollectionViewCell {
  
    let imgVw = UIImageView.init()
    let lblTrack = UILabel.init()
    let lblArtist = UILabel.init()
    let lblCollection = UILabel.init()
    weak var delegate:AnyObject?
    
    //MARK: Initialization methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        contentView.backgroundColor = UIColor.white
        
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = UIViewContentMode.scaleAspectFit

        lblTrack.translatesAutoresizingMaskIntoConstraints = false
        lblTrack.font = UIFont.boldSystemFont(ofSize: 14)
        lblTrack.textColor = UIColor.init(colorLiteralRed: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        lblTrack.numberOfLines = 2

        lblArtist.translatesAutoresizingMaskIntoConstraints = false
        lblArtist.font = UIFont.systemFont(ofSize: 14)
        lblArtist.textColor = UIColor.init(colorLiteralRed: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        
        lblCollection.translatesAutoresizingMaskIntoConstraints = false
        lblCollection.font = UIFont.systemFont(ofSize: 14)
        lblCollection.textColor = UIColor.init(colorLiteralRed: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        lblCollection.numberOfLines = 2

        contentView.addSubview(lblCollection)
        contentView.addSubview(lblArtist)
        contentView.addSubview(imgVw)
        contentView.addSubview(lblTrack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configuration methods
    
    /**
     configures the cell with the track details
     */
    func configureCellWithTrack(_ track:MusicTrack, forListView:Bool){
        
        //imageview constraints
        let constraintWidth:NSLayoutConstraint  = NSLayoutConstraint.init(item: imgVw, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100)
        let constraintHeight:NSLayoutConstraint  = NSLayoutConstraint.init(item: imgVw, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100)
        
        //track label constraints
        let constraintTrackHeight:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblTrack, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 35)
        let constraintTrackTrailing:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblTrack, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 5)

        //album label constraints
        let constraintAlbumHeight:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblCollection, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 35)
        let constraintAlbumTrailing:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblCollection, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier:1, constant: 5)
        let constraintAlbumTop:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblTrack, attribute: .bottom, relatedBy: .equal, toItem: lblCollection, attribute: .top, multiplier: 1, constant: 0)
        let constraintAlbumLeading:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblCollection, attribute: .left, relatedBy: .equal, toItem: lblTrack, attribute: .left, multiplier: 1, constant: 0)

        //artist label constraints
        let constraintArtistHeight:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblArtist, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 20)
        let constraintArtistTrailing:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblArtist, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier:1, constant: 5)
        let constraintArtistTop:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblCollection, attribute: .bottom, relatedBy: .equal, toItem: lblArtist, attribute: .top, multiplier: 1, constant: 0)
        let constraintArtistLeading:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblArtist, attribute: .left, relatedBy: .equal, toItem: lblTrack, attribute: .left, multiplier: 1, constant: 0)

        //customize the other constraints for list and grid view
        let constraintHorizontalCenter:NSLayoutConstraint
        let constraintTop:NSLayoutConstraint
        let constraintTrackLeading:NSLayoutConstraint
        let constraintTrackTop:NSLayoutConstraint
        
        if forListView{
            constraintHorizontalCenter = NSLayoutConstraint.init(item: imgVw, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
             constraintTop = NSLayoutConstraint.init(item: imgVw, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5)

              constraintTrackLeading = NSLayoutConstraint.init(item: imgVw, attribute: .right, relatedBy: .equal, toItem: lblTrack, attribute: .left, multiplier: 1, constant: -5)
              constraintTrackTop = NSLayoutConstraint.init(item: lblTrack, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20)
        }
        else{
             constraintHorizontalCenter  = NSLayoutConstraint.init(item: imgVw, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0)
             constraintTop = NSLayoutConstraint.init(item: imgVw, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 5)
            
             constraintTrackLeading  = NSLayoutConstraint.init(item: lblTrack, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5)
             constraintTrackTop  = NSLayoutConstraint.init(item: imgVw, attribute: .bottom, relatedBy: .equal, toItem: lblTrack, attribute: .top, multiplier: 1, constant: 0)
        }
        
        imgVw.addConstraint(constraintWidth)
        imgVw.addConstraint(constraintHeight)
        contentView.addConstraint(constraintHorizontalCenter)
        contentView.addConstraint(constraintTop)
        
        //load the image from the url
        DispatchQueue.global(qos: .background).async {
            let url = NSURL.init(string: track.artworkUrl100! as String)
            if let data = NSData.init(contentsOf: url as! URL){
                DispatchQueue.main.async {
                    self.imgVw.image = UIImage(data: data as Data)
                }
            }
        }
        
        //Adding all the constraints to the view
        contentView.addConstraint(constraintTrackLeading)
        lblTrack.addConstraint(constraintTrackHeight)
        contentView.addConstraint(constraintTrackTrailing)
        contentView.addConstraint(constraintTrackTop)
        
        contentView.addConstraint(constraintAlbumLeading)
        lblCollection.addConstraint(constraintAlbumHeight)
        contentView.addConstraint(constraintAlbumTrailing)
        contentView.addConstraint(constraintAlbumTop)
        
        contentView.addConstraint(constraintArtistLeading)
        lblArtist.addConstraint(constraintArtistHeight)
        contentView.addConstraint(constraintArtistTrailing)
        contentView.addConstraint(constraintArtistTop)
        
        //set the values for the label
        lblArtist.text = track.artistName
        lblTrack.text = track.trackName
        lblCollection.text = track.collectionName
        
    }
}
