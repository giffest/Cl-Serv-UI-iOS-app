//
//  AnimateViewController.swift
//  
//
//  Created by Dmitry on 17/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class AnimateViewController: UIViewController {
    
    private var cellIdentifier = "cellPhotoAmimate"
    let networkService = NetworkService()
    var idOwner = 0
//    var friendNameForTitle: String = ""
//    var friendFotoForImage: String = ""
    lazy var photos = try? Realm().objects(Photo.self).filter("id BEGINSWITH %@", String(Session.shared.ownerid))
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       networkService.getPhotoUser(idOwner: idOwner)
//        networkService.getPhotoUser(idOwner: idOwner) { [weak self] in
//            self?.photosUI = photos
//            self?.collectionView.reloadData()
//            self?.collectionView.dataSource = self
//        }
//        title = friendNameForTitle
        collectionView?.dataSource = self
        collectionView?.register(AnimateCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.collectionViewLayout = AnimateFlowLayout()
    }
}

extension AnimateViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AnimateCollectionViewCell
        let photo = photos?[indexPath.row]
        cell.imageView.kf.setImage(with: URL(string: photo?.photoUrl ?? ""))
        return cell
    }
}

