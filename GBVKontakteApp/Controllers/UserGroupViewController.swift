//
//  UserGroupViewController.swift
//  
//
//  Created by Dmitry on 21/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class UserGroupViewController: UITableViewController, UISearchBarDelegate {
    
    let networkService = NetworkService()
    
    private var notificationToken: NotificationToken?
//    private var groups: Results<Group>?
    private lazy var groups = try! Realm().objects(Group.self)
    var itemsFiltered = [Group]()
    var searchAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getGroupsUser()
//        networkService.getGroupsUser() { [weak self] in
//            self?.tableView.reloadData()
//        }
//        groupsSectionData()
//        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userGetGroups()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationToken?.invalidate()
    }
    
    func userGetGroups() {
        guard let realm = try? Realm() else { return }
        groups = realm.objects(Group.self).sorted(byKeyPath: "name")
        notificationToken = groups.observe({ [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
            case .update:
//                self.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
                self.tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        })
    }
    
    // MARK: - Table view data source
//    func groupsSectionData() {
//        var section = 0
//        _ = groups.sort {$0.nameGroup < $1.nameGroup}
//        titleForSection.append(String(groups[0].nameGroup.first!))
//        items.append([GroupModel]())
//        items[section].append(groups[0])
//        for row in 1..<groups.count {
//            let leftValue = groups[row - 1].nameGroup.first
//            let rightValue = groups[row].nameGroup.first
//            if leftValue == rightValue {
//                items[section].append(groups[row])
//            } else {
//                titleForSection.append(String(rightValue!))
//                section += 1
//                items.append([GroupModel]())
//                items[section].append(groups[row])
//            }
//        }
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAction ? itemsFiltered.count : groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseIndentifier, for: indexPath) as? GroupCell else { return UITableViewCell() }
        let group = searchAction ? itemsFiltered[indexPath.row] : groups[indexPath.row]
        cell.groupNameLabel.text = group.name
        cell.groupImageView.kf.setImage(with: URL(string: group.avatarUrl))
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groupDel = groups[indexPath.row]
            try? RealmService().deleteItem(item: groupDel)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }

    // MARK: - Navigation
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        let alertVC = UIAlertController(title: "Add group", message: "Do you want add selected group?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "No", style: .cancel)
        let okAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            if let controller = segue.source as? FindGroupViewController,
                let indexPath = controller.tableView.indexPathForSelectedRow {
                let groupAdd = controller.groups[indexPath.row]
                guard !self.groups.contains(where: { $0.name == groupAdd.name }) else { return }
                try? RealmService().saveItem(item: groupAdd, update: .modified)
//                let newIndexPath = IndexPath(item: self.groups.count - 1, section: 0)
//                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        alertVC.addAction(okAction)
        alertVC.addAction(cancleAction)
        present(alertVC, animated: true)
    }
    
    // MARK: SeachBar navigation
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchAction = searchText.count == 0 ? false : true
        itemsFiltered = groups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
    // функция приводит к ошибке при наличии секции
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchAction = true
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchAction = false
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchAction = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchAction = false
    }
}
