//
//  FriendsViewController.swift
//  
//
//  Created by Dmitry on 21/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController, UISearchBarDelegate, SomeProtocol {

    var users: [UserModel] = [
        UserModel(idUser: 1, nameUser: "Губка Боб", imageUser: "ГубкаБоб"),
        UserModel(idUser: 2, nameUser: "Мамонтенок", imageUser: "Мамонтенок"),
        UserModel(idUser: 3, nameUser: "Медведь Трям", imageUser: "МедведьТрям"),
        UserModel(idUser: 4, nameUser: "Львенок", imageUser: "Львенок"),
        UserModel(idUser: 5, nameUser: "Незнайка", imageUser: "Незнайка"),
        UserModel(idUser: 6, nameUser: "Карлсон", imageUser: "Карлсон2"),
        UserModel(idUser: 7, nameUser: "Губка Боб2", imageUser: "ГубкаБоб2"),
        UserModel(idUser: 8, nameUser: "Мамонтенок2", imageUser: "Мамонтенок2"),
        UserModel(idUser: 9, nameUser: "Медведь Трям2", imageUser: "МедведьТрям2"),
        UserModel(idUser: 10, nameUser: "Львенок2", imageUser: "Львенок2"),
        UserModel(idUser: 11, nameUser: "Незнайка2", imageUser: "Незнайка2"),
        UserModel(idUser: 12, nameUser: "Карлсон2", imageUser: "Карлсон2")
        ]
//        .sorted(by: {$0.nameUser < $1.nameUser} )

    var titleForSection = [String]()
    var items = [[UserModel]]()
    var itemsFiltered = [UserModel]()
    var searchAction = false
    
//    var someIndex = 0
    func toPhotoBoard() {
//        let selectIndexPath = IndexPath(item: someIndex, section: 0)
//        collectionView.selectItem(at: selectIndexPath, animated: false, scrollPosition: [])
        print("Успешный нажата иконка.")
//        let selectIndexPath = IndexPath(index: someIndex)
//        tableView.deselectRow(at: selectIndexPath, animated: false)
//        self.performSegue(withIdentifier: "FriendFotoSegue", sender: self)
        self.performSegue(withIdentifier: "FriendFotoSegue",sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        friendSectionData()
        refreshControl()
//        _ = users.sort {$0.nameUser < $1.nameUser}
    }

    // MARK: - Table view data source
    
    func friendSectionData() {
        var section = 0
        
        _ = users.sort {$0.nameUser < $1.nameUser}

        titleForSection.append(String(users[0].nameUser.first!))
        items.append([UserModel]())
        items[section].append(users[0])
        
        for row in 1..<users.count {
            let leftValue = users[row - 1].nameUser.first
            let rightValue = users[row].nameUser.first
            if leftValue == rightValue {
                items[section].append(users[row])
            } else {
                titleForSection.append(String(rightValue!))
                section += 1
                items.append([UserModel]())
                items[section].append(users[row])
            }
        }
    }

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
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchAction ? nil : titleForSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchAction ? 1 : titleForSection.count
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
        
        //cell.friendNameLabel.text = "Губка Боб"
        let section = indexPath.section
        let row = indexPath.row
//        let user = users[indexPath.row]
        let user = searchAction ? itemsFiltered[row] : items[section][row]
        cell.friendNameLabel.text = user.nameUser
        cell.friendImageView.image = UIImage(named: user.imageUser)
//        cell.friendNameLabel2.text = user.nameUser
//        cell.friendImageView2.image = UIImage(named: user.imageUser)
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
//            users.remove(at: indexPath.row)
            items[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendFotoSegue",
            let friendFotoController = segue.destination as? FriendsFotoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            
//            let nameUser = users[indexPath.row]
            let nameUser = items[indexPath.section][indexPath.row]
            friendFotoController.friendNameForTitle = nameUser.nameUser
            friendFotoController.friendFotoForImage = nameUser.imageUser
        }
     }
    
    // MARK: SeachBar navigation
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchAction = searchText.count == 0 ? false : true
        itemsFiltered = users.filter { $0.nameUser.lowercased().contains(searchText.lowercased())}

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
