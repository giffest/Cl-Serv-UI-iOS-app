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
    
    private var notificationToken: NotificationToken?
    
    private let users = try! Realm().objects(User.self).sorted(byKeyPath: "lastName")

    var titleForSection = [String]()
    var items = [[User]]()
    var itemsFiltered = [User]()
    var searchAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getFriends()

        friendSectionData()
        
        refreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        userGetFriends()
//        friendSectionData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        notificationToken?.invalidate()
    }
  
    func userGetFriends() {
        notificationToken = users.observe({ [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.tableView.reloadData()
            case .update:
                self.tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }
    
    // MARK: - Table view data source
    private func friendSectionData() {
        var section = 0
        
        titleForSection.append(String(users[0].lastName.first ?? "я"))
        items.append([users[0]])
        
        for row in 1..<users.count {
            let leftValue = users[row - 1].lastName.first
            let rightValue = users[row].lastName.first
            if leftValue == rightValue {
                items[section].append(users[row])
            } else {
                titleForSection.append(String(rightValue!))
                section += 1
                items.append([users[row]])
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
        
        view.addSubview(loadIndicatorView)

        loadIndicatorView.animate()
        
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

        let user = searchAction ? itemsFiltered[row] : items[section][row]
        
        cell.friendNameLabel.text = user.firstName + " " + user.lastName
        cell.friendImageView.kf.setImage(with: URL(string: user.avatarUrl))
        
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

     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendsFotoViewController",
            let friendFotoController = segue.destination as? FriendsFotoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            let section = indexPath.section
            let row = indexPath.row

            let user = searchAction ? itemsFiltered[row] : items[section][row]
            friendFotoController.friendNameForTitle = user.firstName + " " + user.lastName
            friendFotoController.friendFotoForImage = user.avatarUrl
            friendFotoController.idOwner = user.idFriend
            }
     }
    
//    @IBAction func signOffButtonPressed(_ sender: Any) {
//        do {
//            try Auth.auth().signOut()
//            self.dismiss(animated: true)
//        } catch {
//            show(error)
//        }
//    }
    
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
    
}
