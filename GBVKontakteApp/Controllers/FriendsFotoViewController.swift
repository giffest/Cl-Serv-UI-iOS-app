//
//  FriendsFotoViewController.swift
//  
//
//  Created by Dmitry on 21/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class FriendsFotoViewController: UICollectionViewController {
    
    let networkService = NetworkService()
//    private let photos = try! Realm().objects(Photo.self)
//    private let photos = try! Realm().object(ofType: Photo.self, forPrimaryKey: "idPhoto")
    
    var friendNameForTitle: String = ""
    var friendFotoForImage: String = ""
//    var friendFotoForImage: URL?
    var idOwner = 0
    var idPhotoOwner = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friendNameForTitle
    }
    
    let loadIndicatorView = LoadIndicatorView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkService.getPhotoUser(idOwner: idOwner)
//        let realm = try! Realm()
//        try? realm.write {
//            let owner = User()
//            owner.idFriend = idOwner
//            owner.photos.append(objectsIn: photos)
//        }
        
//        networkService.getPhotoId(idOwner: idOwner) { [weak self] photoId in
//            self?.idPhoto = photo
//        }
//        networkService.getPhotoUser(idOwner: idOwner) { [weak self] photos in
//            self?.idPhotoOwner = photos[0].idPhoto
//        }
        
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

/*    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        
//        let fotoImage = friendFotoForImage
//        cell.imageFriendView.image = UIImage(named: friendFotoForImage)
//        cell.imageFriendView.kf.setImage(with: friendFotoForImage)
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
        if segue.identifier == "FotoAnimateSegue",
            let amimateViewController = segue.destination as? AmimateViewController {
            amimateViewController.idOwner = idOwner
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
