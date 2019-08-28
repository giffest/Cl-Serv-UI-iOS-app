//
//  AnimateViewController.swift
//  
//
//  Created by Dmitry on 17/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import Kingfisher

class AmimateViewController: UIViewController {
    
    let networkService = NetworkService()
    private var photosUI = [Photo]()
    var idOwner = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var cellIdentifier = "cellPhotoAmimate"
    
//    var friendNameForTitle: String = ""
//    var friendFotoForImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getPhotoUser(idOwner: idOwner) { [weak self] photos in
            self?.photosUI = photos
            self?.collectionView.reloadData()
            self?.collectionView.dataSource = self
        }
//        title = friendNameForTitle
//        collectionView?.dataSource = self
        collectionView?.register(AnimateCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.collectionViewLayout = AnimateFlowLayout()
    }
}

extension AmimateViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUI.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AnimateCollectionViewCell
        
        let photo = photosUI[indexPath.row]
//        cell.imageView.image = UIImage(named: "image\(indexPath.row+1)")
        cell.imageView.kf.setImage(with: photo.photoUrl)
        
        return cell
    }
}

