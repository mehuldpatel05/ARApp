//
//  CustomTableViewCell.swift
//  ARApp
//
//  Created by FPrimeC on 2021-10-22.
//

import UIKit

protocol CustomTableViewCellDelegate {
    func passTheCurrent(tableIndex: Int, collectionViewIndex: Int)
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
   
    var delegate: CustomTableViewCellDelegate?

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
          return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.passTheCurrent(tableIndex: 0, collectionViewIndex: indexPath.item)
    }

}
