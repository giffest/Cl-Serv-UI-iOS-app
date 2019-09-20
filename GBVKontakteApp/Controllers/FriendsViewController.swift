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

    var searchController: UISearchController! = nil
//    fileprivate var searchController: UISearchController!
    
    let networkService = NetworkService()
    let loadIndicatorView = LoadIndicatorView()
    let realmService = RealmService()
    
    private var notificationToken: NotificationToken?
    private lazy var usersResults = try! Realm().objects(User.self).filter("firstName != 'DELETED'").sorted(byKeyPath: "lastName")
    var titleForSection = [String]()
    var itemsForSection = [[User]]()
    var itemsFiltered = [[User]]()
    var searchAction = false
    
    @IBOutlet weak var searchBarContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getFriends { [weak self] users in
            guard let self = self else { return }
            self.loadIndicatorView.animate()
            try? self.realmService.save(items: users, update: .modified)
            let users = self.usersResults
            (self.titleForSection, self.itemsForSection) = (self.sortedItemsForSection(users))
//            (self.titleForSection, self.itemsFiltered) = (self.sortedItemsForSection(users))
//            self.tabBarController?.tabBar.items?[0].badgeValue = String(self.usersResults.count)
        }
        refreshControl()
        setSearchController()
//        searchController = UISearchController(searchResultsController: nil)
//        self.searchBarContainer.addSubview(searchController.searchBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userNotificationObserves()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationToken?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        var frame = searchController.searchBar.bounds
//        frame.size.width = self.view.bounds.size.width
//        searchController.searchBar.frame = frame
        positionSearchController()
    }

    private func userNotificationObserves() {
        notificationToken = usersResults.observe({ [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.tableView.reloadData()
                self.tabBarController?.tabBar.items?[0].badgeValue = String(self.usersResults.count)
            case .update:
                self.tableView.reloadData()
                self.tabBarController?.tabBar.items?[0].badgeValue = String(self.usersResults.count)
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }
    
    // MARK: - Table view data source
    private func sortedItemsForSection(_ users: Results<User>) -> (titleForSection: [String], items: [[User]]) {
        var section = 0
        var titleForSection = [String]()
        var items = [[User]]()
        titleForSection.append(String(users[0].lastName.first ?? "!"))
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
        return (titleForSection, items)
    }
    
    //MARK:- Custom SearchBar
    fileprivate func setSearchController() {
        searchController = UISearchController(searchResultsController: nil)
//        self.searchBarContainer.addSubview(searchController.searchBar)
        searchController.delegate = self as? UISearchControllerDelegate
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 414, height: 56)
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.returnKeyType = .done
        searchController.dimsBackgroundDuringPresentation = false // затенение
        searchController.hidesNavigationBarDuringPresentation = true // скрыть бар навигации
        searchController.searchBar.endEditing(true)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = .lightGray
//        searchController.searchBar.barTintColor = UIColor(red: 93.0 / 255.0, green: 168.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
        searchController.searchBar.isHidden = false // ?
//        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.isTranslucent = false
//        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        
        // изменение цвета текста и курсора поиска
        let topView: UIView = searchController.searchBar.subviews[0] as UIView
        for subView: UIView in topView.subviews {
            if let searchField = subView as? UITextField {
                searchField.tintColor = UIColor.blue
                searchField.textColor = UIColor(red: 93.0 / 255.0, green: 168.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
            }
        }

//        searchFieldMove()
        
//        definesPresentationContext = true
//        navigationItem.hidesBackButton = true
        
        positionSearchController()
    }
    
    func searchFieldMove() {
        let topView: UIView = searchController.searchBar.subviews[0] as UIView
        var searchField: UITextField!
        for subView in topView.subviews {
            if subView is UITextField {
                searchField = (subView as! UITextField)
                break
            }
        }
        if ((searchField) != nil) {
            let leftview = searchField.leftView as! UIImageView
            let magnifyimage = leftview.image
            let imageView = UIImageView(frame: CGRect(x: searchController.searchBar.frame.width/3, y: (searchController.searchBar.frame.height)/3, width: 15, height: 15))
            imageView.image = magnifyimage
            searchField.leftView = UIView(frame: CGRect(x: 0 , y: 0, width: searchController.searchBar.frame.width/3, height: 20) )
            searchField.leftViewMode = .unlessEditing
            searchField.superview?.addSubview(imageView)
        }
    }
    
    fileprivate func positionSearchController() {
        searchBarContainer.addSubview(searchController.searchBar)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.leftAnchor.constraint(equalTo: searchBarContainer.leftAnchor).isActive = true
        searchController.searchBar.rightAnchor.constraint(equalTo: searchBarContainer.rightAnchor).isActive = true
        searchController.searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor).isActive = true
        searchController.searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor).isActive = true
//        var frame = searchController.searchBar.bounds
//        frame.size.width = self.view.bounds.size.width
//        searchController.searchBar.frame = frame
    }
    
    // MARK: Animation control
    private func refreshControl() {
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
    
    // MARK: TableView config
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titleForSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleForSection.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(titleForSection[section])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAction ? itemsFiltered[section].count : itemsForSection[section].count
//        return itemsForSection[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseIndentifier, for: indexPath) as? FriendCell else { return UITableViewCell() }
        let section = indexPath.section
        let row = indexPath.row
        let user = searchAction ? itemsFiltered[section][row] : itemsForSection[section][row]
//        let user = itemsForSection[section][row]
        cell.friendNameLabel.text = user.firstName + " " + user.lastName
        cell.friendImageView.kf.setImage(with: URL(string: user.avatarUrl))
        cell.avatarTappedHandler = { [weak self] in
            guard let self = self else { return }
            self.performSegue(withIdentifier: "toFriendsFotoViewController", sender: Any?.self)
        }
//        cell.friendImageView.kf.setImage(with: user.avatarUrl)
        
        //aнимация
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -100, 10, 0)
////        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//        cell.layer.transform = rotationTransform
//        cell.alpha = 0.5
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

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            items[indexPath.section].remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendsFotoViewController",
            let friendFotoController = segue.destination as? FriendsFotoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let section = indexPath.section
            let row = indexPath.row
            let user = searchAction ? itemsFiltered[section][row] : itemsForSection[section][row]
            friendFotoController.friendNameForTitle = user.firstName + " " + user.lastName
            friendFotoController.friendFotoForImage = user.avatarUrl
            Session.shared.ownerid = user.idFriend
            searchController.searchBar.text = ""
            searchController.dismiss(animated: false)
            setSearchController()
            }
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
    
    // MARK: SeachBar navigation
    var countBadge: Int = 0
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchAction = searchText.count == 0 ? false : true
        let searchPredicate = NSPredicate(format: "(lastName CONTAINS[cd] %@) OR (firstName CONTAINS[cd] %@)", searchText.lowercased(), searchText.lowercased())
        let searchResultsText = usersResults.filter(searchPredicate)
//        self.tabBarController?.tabBar.items?[0].badgeValue = String(searchResultsText.count)
        if (searchAction && searchResultsText.count > 0) {
            (self.titleForSection, self.itemsFiltered) = (self.sortedItemsForSection(searchResultsText))
            countBadge = searchResultsText.count
            self.tabBarController?.tabBar.items?[0].badgeValue = String(countBadge)
            self.tableView.reloadData()
        } else if searchText.count == 0 {
            (self.titleForSection, self.itemsFiltered) = (self.sortedItemsForSection(usersResults))
            self.tabBarController?.tabBar.items?[0].badgeValue = String(usersResults.count)
            self.tableView.reloadData()
        } else if (searchText.count != 0 && searchResultsText.count == 0) {
            self.tabBarController?.tabBar.items?[0].badgeValue = String(countBadge)
            return
        }
     }
    
    // функция приводит к ошибке при наличии секции
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchAction = true
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchAction = false
        (self.titleForSection, self.itemsForSection) = (self.sortedItemsForSection(usersResults))
//        (self.titleForSection, self.itemsFiltered) = (self.sortedItemsForSection(usersResults))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchAction = false
        searchBar.text = ""
        (self.titleForSection, self.itemsForSection) = (self.sortedItemsForSection(usersResults))
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchAction = false
    }
    
     // эксперимент 1
//    override func viewWillAppear(_ animated: Bool) {
//        animateTable()
//    }
//    func animateTable() {
//        tableView.reloadData()
//        let cells = tableView.visibleCells
//        let tableHeight: CGFloat = tableView.bounds.size.height
//        for i in cells {
//            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
//        }
//        var index = 0
//        for a in cells {
//            let cell: UITableViewCell = a as UITableViewCell
//            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0) }, completion: nil)
////            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
////                cell.transform = CGAffineTransformMakeTranslation(0, 0);
////            }, completion: nil)
//            index += 1
//        }
//    }
}
