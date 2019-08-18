//
//  AnimateViewController.swift
//  
//
//  Created by Dmitry on 17/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class AmimateViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var cellIdentifier = "cell"
    
//    var friendNameForTitle: String = ""
//    var friendFotoForImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = friendNameForTitle
        collectionView?.dataSource = self
        collectionView?.register(AniamteCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.collectionViewLayout = AnimateFlowLayout()
    }
}

extension AmimateViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AniamteCollectionViewCell
        
        cell.imageView.image = UIImage(named: "image\(indexPath.row+1)")
        
        return cell
    }
}

