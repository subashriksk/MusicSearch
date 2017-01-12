//
//  PLPListCollectionViewCell.swift
//  TheHomeDepot
//
//  Created by Suba shri Kulandai Samy on 8/2/16.
//  Copyright © 2016 Home Depot. All rights reserved.
//

import UIKit

class TracksListCollectionViewCell: TracksGridCollectionViewCell {

    let lblPrice = UILabel.init()
    
    //MARK: Initialisation methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        lblPrice.translatesAutoresizingMaskIntoConstraints = false
        lblPrice.font = UIFont.boldSystemFont(ofSize: 16)
        lblPrice.textColor = UIColor.init(colorLiteralRed: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        
        contentView.addSubview(lblPrice)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureCellWithTrack(_ track: MusicTrack,forListView:Bool) {
        super.configureCellWithTrack(track,forListView: forListView)
        
        //price label constraints
        let constraintPriceLeading:NSLayoutConstraint  = NSLayoutConstraint.init(item: imgVw, attribute: .right, relatedBy: .equal, toItem: lblPrice, attribute: .left, multiplier: 1, constant: -5)
        let constraintPriceHeight:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblPrice, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 20)
        let constraintPriceTrailing:NSLayoutConstraint  = NSLayoutConstraint.init(item: lblPrice, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier:1, constant: 5)
        let constraintPriceTop:NSLayoutConstraint  = NSLayoutConstraint.init(item: contentView, attribute: .top, relatedBy: .equal, toItem: lblPrice, attribute: .top, multiplier: 1, constant: 0)
        
        contentView.addConstraint(constraintPriceLeading)
        lblPrice.addConstraint(constraintPriceHeight)
        contentView.addConstraint(constraintPriceTrailing)
        contentView.addConstraint(constraintPriceTop)
        
        //apending $ for the price, need to change the unit based on teh currency in the track object
        lblPrice.text = "$" + String(format:"%.2f", track.trackPrice!)
    }
}
