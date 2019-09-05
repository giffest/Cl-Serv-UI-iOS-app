//
//  FriendsViewController.swift
//  
//
//  Created by Dmitry on 21/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendsViewController: UITableViewController, UISearchBarDelegate, SomeProtocol {

    let networkService = NetworkService()
    private let users = try! Realm().objects(User.self).sorted(byKeyPath: "lastName")
//    var firstCharacter = [Character]()
//    var sortedUsers = [Character: users] = [:]
    var titleForSection = [String]()
    var items = [[User]]()
    var itemsFiltered = [User]()
    var searchAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getFriends() { [weak self] in
            self?.tableView.reloadData()
        }
//        (firstCharacter, sortedUsers) = sort(users)
        friendSectionData()
        refreshControl()
    }

    // MARK: - Table view data source
    private func friendSectionData() {
        var section = 0
        
        titleForSection.append(String(users[0].lastName.first!))
        items.append([User]())
        items[section].append(users[0])
        
        for row in 1..<users.count {
            let leftValue = users[row - 1].lastName.first
            let rightValue = users[row].lastName.first
            if leftValue == rightValue {
                items[section].append(users[row])
            } else {
                titleForSection.append(String(rightValue!))
                section += 1
                items.append([User]())
                items[section].append(users[row])
            }
        }
    }
//    private func sort(_ items: [User]) -> (characters: [Character], sortedItems: [Character: [User]]) {
//        var characters = [Character]()
//        var sortedItems = [Character: [User]]()
//
//        items.forEach { item in
//            guard let character = item.lastName.first else { return }
////            guard let character = item.firstName.first else { return }
//            if var thisCharItems = sortedItems[character] {
//                thisCharItems.append(item)
//                sortedItems[character] = thisCharItems
//            } else {
//                sortedItems[character] = [item]
//                characters.append(character)
//            }
//        }
//        characters.sort()
//
//        return (characters, sortedItems)
//    }

    let loadIndicatorView = LoadIndicatorView()
    
    func refreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = .clear
        refreshControl?.tintColor = .clear
        
//        let rect = refreshControl!.bounds
//        loadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
//        view.centerXAnchor.constraint(equalTo: CGPoint(rect.width/2))
//        view.centerYAnchor.constraint(equalTo: CGPoint(rect.height/2))
        view.addSubview(loadIndicatorView)
//        loadIndicatorView.centerXAnchor.constraint(equalTo: refreshControl!.centerXAnchor).isActive = true
//        loadIndicatorView.centerYAnchor.constraint(equalTo: refreshControl!.centerYAnchor).isActive = true
        loadIndicatorView.animate()
        
//        let shape = CAShapeLayer()
//        let replicatorLayer = CAReplicatorLayer()
//        let instanceCount = 3
//
//        shape.frame.size = CGSize(width: 20, height: 20)
//        let rect = refreshControl!.bounds
//        shape.anchorPoint = CGPoint(x: rect.width/2, y: rect.height/2)
//
//        shape.path = CGPath(ellipseIn: shape.frame, transform: nil)
//        shape.fillColor = UIColor.lightGray.cgColor
//
//        replicatorLayer.instanceCount = instanceCount
//
//        let xpoint = CGFloat(shape.frame.width) * CGFloat(replicatorLayer.instanceCount) / 2
//        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(xpoint, 0, 0)
//        replicatorLayer.bounds.size = CGSize(width: shape.frame.height * .pi, height: shape.frame.height)
//        replicatorLayer.addSublayer(shape)
//        refreshControl?.layer.addSublayer(replicatorLayer)
        
//        replicatorLayer.animation(forKey: <#T##String#>)
    }
    
    //    var someIndex = 0
    func toPhotoBoard() {
        //        let selectIndexPath = IndexPath(item: someIndex, section: 0)
        //        collectionView.selectItem(at: selectIndexPath, animated: false, scrollPosition: [])
        print("Нажата иконка.")
        //        let selectIndexPath = IndexPath(index: someIndex)
        //        tableView.deselectRow(at: selectIndexPath, animated: false)
        self.performSegue(withIdentifier: "toFriendsFotoViewController", sender: self)
    }
    
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchAction ? nil : titleForSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchAction ? 1 : titleForSection.count
//        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchAction ? nil : String(titleForSection[section])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return 10  // для проверки и настройки
//        return users.count
        return searchAction ? itemsFiltered.count : items[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseIndentifier, for: indexPath) as? FriendCell else { return UITableViewCell() }
        
        let section = indexPath.section
        let row = indexPath.row
//        let user = users[indexPath.row]
        let user = searchAction ? itemsFiltered[row] : items[section][row]
        
        cell.friendNameLabel.text = user.firstName + " " + user.lastName
        cell.friendImageView.kf.setImage(with: URL(string: user.avatarUrl))
//        cell.friendImageView.kf.setImage(with: user.avatarUrl)
        
        //aнимация
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -100, 10, 0)
////        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//        cell.layer.transform = rotationTransform
//        cell.alpha = 0.5
//
//        UIView.animate(withDuration: 0.3) {
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1.0
//        }
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //aнимация
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -100, 10, 0) // 1 вариант
        let rotationTransform = CATransform3DMakeTranslation(-100, 10, 0) // 2 вариант
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
////            users.remove(at: indexPath.row)
//            items[indexPath.section].remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendsFotoViewController",
            let friendFotoController = segue.destination as? FriendsFotoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
//            let nameUser = users[indexPath.row]
//            let nameUser = items[indexPath.section][indexPath.row]
//            friendFotoController.friendNameForTitle = nameUser.nameUser
//            friendFotoController.friendFotoForImage = nameUser.imageUser
            
//            let user = users[indexPath.row]
            let user = items[indexPath.section][indexPath.row]
            friendFotoController.friendNameForTitle = user.firstName + " " + user.lastName
            friendFotoController.friendFotoForImage = user.avatarUrl
            friendFotoController.idOwner = user.idFriend
            }
     }
    
    // MARK: SeachBar navigation
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchAction = searchText.count == 0 ? false : true
//        itemsFiltered = users.filter { $0.nameUser.lowercased().contains(searchText.lowercased())}
        itemsFiltered = users.filter { ($0.firstName + $0.lastName).lowercased().contains(searchText.lowercased())}
        self.tableView.reloadData()
     }
    
    // функция приводит к ошибке при наличии секции
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchAction = true
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchAction = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchAction = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchAction = false
    }
    
    
     // эксперимент 1
//    override func viewWillAppear(_ animated: Bool) {
//        animateTable()
//    }
//
//    func animateTable() {
//        tableView.reloadData()
//
//        let cells = tableView.visibleCells
//        let tableHeight: CGFloat = tableView.bounds.size.height
//
//        for i in cells {
//            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
//        }
//
//        var index = 0
//
//        for a in cells {
//            let cell: UITableViewCell = a as UITableViewCell
//            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0) }, completion: nil)
////            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
////                cell.transform = CGAffineTransformMakeTranslation(0, 0);
////            }, completion: nil)
//
//            index += 1
//        }
//    }
    
}
