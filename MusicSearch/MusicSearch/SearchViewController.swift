//
//  ViewController.swift
//  MusicSearch
//
//  Created by Suba shri Kulandai Samy on 1/11/17.
//  Copyright © 2017 Suba shri Kulandai Samy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource {
   
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var vwLoading: UIActivityIndicatorView!
    @IBOutlet weak var vwCollTracks: UICollectionView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var segVwType: UISegmentedControl!
    @IBOutlet weak var btnSortFilter: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var imgPlacehOlder: UIImageView!
    @IBOutlet weak var vwPicker: UIView!
    @IBOutlet weak var pickerSort: UIPickerView!
    
    var layout = UICollectionViewFlowLayout.init()
    var dataSource:NSMutableArray = []
    var arrResults:NSMutableArray = []
    var arrSortOptions:NSMutableArray = ["Relevance","Kind", "Artist Name","Track Name"]
    var arrSortCode:NSMutableArray = ["","kind", "artistName", "trackName"]

    var isInListView:Bool = false
    var selectedTrack:MusicTrack?
    var selectedSortIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the keypad visible during the startup
        txfSearch.becomeFirstResponder()
        btnSearch.isEnabled = false

        initializeCollectionView()
    }
    
    //MARK: Helper methods
    
    /*
    called out when the serach button is tapped
     */
    @IBAction func searchTapped(_ sender: Any) {
        performSearch()
    }
    
    /*
     called out when the view type segment button is tapped
     */
    @IBAction func typeChanged(_ sender: UISegmentedControl) {
        isInListView = sender.selectedSegmentIndex == 1
        vwCollTracks.reloadData()
        vwCollTracks.performBatchUpdates({
            self.vwCollTracks.collectionViewLayout.invalidateLayout()
        }){ (completed) in
            self.vwCollTracks.setCollectionViewLayout(self.layout, animated:true)
        }
    }
    
    @IBAction func sortAndFilterTapped(_ sender: Any) {
        
        vwPicker.isHidden = false
        view.bringSubview(toFront: vwPicker)
        pickerSort.reloadAllComponents()

    }
    
    @IBAction func homeTapped(_ sender: Any) {
        clearAndGoHome()
    }
    
    @IBAction func pickerDoneTapped(_ sender: Any) {
        vwPicker.isHidden = true
        dataSource.removeAllObjects()

        if selectedSortIndex == 0{
            dataSource = arrResults
        }
        else{
             let arrSorted = (arrResults as NSArray).sortedArray(using: [
                NSSortDescriptor(key: arrSortCode.object(at: selectedSortIndex) as? String, ascending: true)])
            dataSource.addObjects(from: arrSorted)
        }
        vwCollTracks.reloadData()
    }
    
    func performSearch(){
        txfSearch.resignFirstResponder()
        vwLoading.startAnimating()
        view.bringSubview(toFront: vwLoading)
        
        btnSortFilter.layer.cornerRadius = 3.0
        btnSortFilter.layer.borderWidth = 1.0
        btnSortFilter.layer.borderColor = UIColor.init(colorLiteralRed: 70/255, green: 114/255, blue: 197/255, alpha: 1).cgColor
        MusicHelper.getTracksForKeyword(strKeyword: txfSearch.text!) { (succeeded, result) in
            DispatchQueue.main.async {
                self.vwLoading.stopAnimating()
                if succeeded{
                    print("Suceeded")
                    //refresh teh view with new tracks
                    self.dataSource.removeAllObjects()
                    self.arrResults.removeAllObjects()
                    self.dataSource.addObjects(from: (result as! MusicResults).results)
                    self.arrResults.addObjects(from: (result as! MusicResults).results)
                    
                    //display the collection view only if has the track results
                    if self.dataSource.count > 0{
                        self.vwCollTracks.isHidden = false
                        self.vwHeader.isHidden = false
                        self.imgPlacehOlder.isHidden = true
                        self.vwCollTracks.reloadData()
                    }
                    else{
                        let alert = UIAlertController.init(title: "No Tracks", message: "Try searching with different keywords.", preferredStyle: UIAlertControllerStyle.alert)
                        let actionOk = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                        alert.addAction(actionOk)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
                    print("Failed")
                }
            }
        }
    }
    
    /*
    clear the view and make it as initial view
     */
    func clearAndGoHome(){
        vwCollTracks.isHidden = true
        vwHeader.isHidden = true
        imgPlacehOlder.isHidden = false
        txfSearch.text = ""
        btnSearch.isEnabled = false
        txfSearch.becomeFirstResponder()
    }
    
    /*
     initialises the collection view
     */
    func initializeCollectionView(){
        
        //layout setup
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets.zero
        
        //collecrtion view
        vwCollTracks.backgroundColor = UIColor.init(colorLiteralRed: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        vwCollTracks.collectionViewLayout = layout
        vwCollTracks.register(TracksGridCollectionViewCell.self, forCellWithReuseIdentifier:"trackGridCell")
        vwCollTracks.register(TracksListCollectionViewCell.self, forCellWithReuseIdentifier:"trackListCell")
        vwCollTracks.layer.cornerRadius = 3.0
        vwCollTracks.isHidden = true
    }
    
    //MARK: Collection view methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let track:MusicTrack = dataSource.object(at: (indexPath as NSIndexPath).row) as! MusicTrack
        let cell:UICollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: isInListView ? "trackListCell" : "trackGridCell", for: indexPath)
        (cell as! TracksGridCollectionViewCell).delegate = self
        (cell as! TracksGridCollectionViewCell).configureCellWithTrack(track, forListView: isInListView)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTrack = dataSource.object(at: (indexPath as NSIndexPath).row) as? MusicTrack
        performSegue(withIdentifier: "ResultsToTrack", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //can be enahaced to hold different sizes based on teh string length
        if isInListView {
            return CGSize(width: screenWidth, height: 110)
        }
        else{
            
            let isDeviceiPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
            let width = isDeviceiPad ?(screenWidth - 10)/4 : (screenWidth - 2)/2
            return CGSize(width: width, height: 200)
        }
    }
    
    
    //MARK: Textfield delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let strExisting = textField.text as NSString?
        let strReplacement = strExisting?.replacingCharacters(in: range, with: string)
        if (strReplacement?.characters.count)! == 0{
            clearAndGoHome()
        }
        else{
            btnSearch.isEnabled = true
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        clearAndGoHome()
        return true
    }
    
    //MARK: Seque Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trackVc:TrackViewController = segue.destination as! TrackViewController
        trackVc.track = selectedTrack
    }
    
    //MARK: Picker view methods
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrSortOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrSortOptions.object(at: row) as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSortIndex = row
    }
    
}

