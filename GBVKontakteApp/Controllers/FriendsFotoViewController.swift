//
//  FriendsFotoViewController.swift
//  
//
//  Created by Dmitry on 21/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class FriendsFotoViewController: UICollectionViewController {
    
    let networkService = NetworkService()
    
    var friendNameForTitle: String = ""
    var friendFotoForImage: String = ""
//    var friendFotoForImage: URL?
    var idOwner = 0
    var idPhotoOwner = 0
//    var idPhotoOwner: (Int) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friendNameForTitle
        
//        networkService.getPhotoId(idOwner: idOwner) { [weak self] photoId in
//            self?.idPhotoOwner = photoId
//        }
//        Session.shared.ownerid = idOwner
//        Session.shared.photoid = idPhotoOwner

    }
    
    let loadIndicatorView = LoadIndicatorView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkService.getPhotoUser(idOwner: idOwner)

        Session.shared.ownerid = idOwner
//        Session.shared.photoid = idPhotoOwner
        
        view.addSubview(loadIndicatorView)
        
        loadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        loadIndicatorView.centerXAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 300).isActive = true
//        loadIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        loadIndicatorView.animate()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        
        cell.imageFriendView.kf.setImage(with: URL(string: friendFotoForImage))
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //aнимация
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 500, 10, 0)
//        //        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//        cell.layer.transform = rotationTransform
//        cell.alpha = 0
//
//        UIView.animate(withDuration: 0.75) {
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1.0
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnimateViewController",
            let amimateViewController = segue.destination as? AnimateViewController {
            amimateViewController.idOwner = idOwner
        }
    }

}
