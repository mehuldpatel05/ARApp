//
//  CustomTableViewCell.swift
//  ARApp
//
//  Created by FPrimeC on 2021-10-22.
//

import UIKit
import Alamofire

protocol CustomTableViewCellDelegate {
    func passTheCurrent(tableIndex: Int, collectionViewIndex: Int)
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
   
    var delegate: CustomTableViewCellDelegate?
    var incrementer = 0
    var imagesArray = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension CustomTableViewCell : UICollectionViewDelegate {}

extension CustomTableViewCell : UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let collectionViewcell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
        collectionViewcell.tag = incrementer
        
        if collectionView.tag == 0 {
            
            let mainAPI = "http://13.233.31.228/thumbnail/"
            
            let imageName = imagesArray[indexPath.item]
            let eachImageURL = mainAPI + "\(imageName)"
                print("eachImageURL \(eachImageURL)")
            let url = URL(string: eachImageURL)
            let data = try? Data(contentsOf: url!)
            
            collectionViewcell.thumbnail.image = UIImage(data: data!)
            
            let filename = imageName as NSString
            let pathExtention = filename.pathExtension
            let titleName = filename.deletingPathExtension
            print("titleName \(titleName)")
            collectionViewcell.thumbnailTitle.text = titleName
        }
        
        if collectionView.tag == 1 {
            collectionViewcell.thumbnail.image = UIImage(named: "")
        }
        if collectionView.tag == 2 {
            collectionViewcell.thumbnail.image = UIImage(named: "")
        }
        
        incrementer = incrementer + 1
        return collectionViewcell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.passTheCurrent(tableIndex: 0, collectionViewIndex: indexPath.item)
    }

}
