//
//  NewsCollectionViewLayout.swift
//  
//
//  Created by Dmitry on 10/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class NewsCollectionViewLayout: UICollectionViewLayout {
    
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
//    let columnsCount: CGFloat = 2
    let columnsCount = 2
    let cellHeight: CGFloat = 128
    private var totalCellHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        
        cacheAttributes = [:]
        guard let collectionView = self.collectionView else { return }
        
        let itemCount = collectionView.numberOfItems(inSection: 0)
        guard itemCount > 0 else { return }
        
//        let bigCellWidth = collectionView.bounds.width
//        let smallCellWidth = collectionView.bounds.width / columnsCount
        let bigCellWidth = collectionView.frame.width
        let smallCellWidth = collectionView.frame.width / CGFloat(self.columnsCount)
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
        
        for index in 0..<itemCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
//            let isBigCell = (((index + 1) % (Int(columnsCount) + 1)) == 0)
            let isBigCell = (index + 1) % (self.columnsCount + 1) == 0
            
            if isBigCell {
                attributes.frame = CGRect(x: 0, y: lastY, width: bigCellWidth, height: cellHeight)
//                lastY += cellHeight
                lastY += self.cellHeight
            } else {
                attributes.frame = CGRect(x: lastX, y: lastY, width: smallCellWidth, height: cellHeight)
                
//                let isLastColumn = (index + 2) % (Int(columnsCount) + 1) == 0 || index == (itemCount - 1)
                let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemCount - 1
                
                if isLastColumn {
                    lastX = 0
//                    lastY += cellHeight
                    lastY += self.cellHeight
                } else {
                    lastX += smallCellWidth
                }
            }
            cacheAttributes[indexPath] = attributes
        }
//        totalCellHeight = lastY
        self.totalCellHeight = lastY
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        return cacheAttributes.values.filter { rect.intersects($0.frame) }
        return cacheAttributes.values.filter { attributes in return rect.intersects(attributes.frame) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
//        return CGSize(width: collectionView?.bounds.width ?? 0, height: totalCellHeight)
        return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totalCellHeight)
    }
}
