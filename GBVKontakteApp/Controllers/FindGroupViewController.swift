//
//  FindGroupViewController.swift
//  
//
//  Created by Dmitry on 21/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import Kingfisher

class FindGroupViewController: UITableViewController, UISearchBarDelegate {
    
    let networkService = NetworkService()
    public var groupsVK = "xcode"
//    public var gpoupsVK = "MacOS"
    var groups = [Group]()
    var itemsFiltered = [Group]()
    var searchAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getSearchGroup(for: groupsVK) { [weak self] groups in
            guard let self = self else { return }
            self.groups = groups
            self.tableView.reloadData()
        }
    }

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
    
    // MARK: SeachBar navigation
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkService.getSearchGroup(for: searchText) { [weak self] groups in
            guard let self = self else { return }
            self.itemsFiltered = groups
            self.tableView.reloadData()
        }
        searchAction = searchText.count == 0 ? false : true
    }
    
    // функция приводит к ошибке при наличии секции
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchAction = true
    }
    
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
