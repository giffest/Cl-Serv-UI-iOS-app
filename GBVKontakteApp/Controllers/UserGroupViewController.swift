//
//  UserGroupViewController.swift
//  
//
//  Created by Dmitry on 21/05/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class UserGroupViewController: UITableViewController, UISearchBarDelegate {
    
    var groups: [GroupModel] = [
        GroupModel(idGroup: 1, nameGroup: "Пингвины Мадагаскара", imageGroup: "madagascar_penguins"),
        GroupModel(idGroup: 2, nameGroup: "Собор", imageGroup: "Собор"),
        GroupModel(idGroup: 3, nameGroup: "Том и Джерри", imageGroup: "TomAndJerry2"),
        GroupModel(idGroup: 4, nameGroup: "Охотники за привидениями", imageGroup: "ghostbuster"),
        GroupModel(idGroup: 5, nameGroup: "Пингвины Мадагаскара2", imageGroup: "madagascar_penguins"),
        GroupModel(idGroup: 6, nameGroup: "Собор2", imageGroup: "Собор"),
        GroupModel(idGroup: 7, nameGroup: "Том и Джерри2", imageGroup: "TomAndJerry2"),
        GroupModel(idGroup: 8, nameGroup: "Охотники за привидениями2", imageGroup: "ghostbuster")
    ]
     .sorted(by: {$0.nameGroup < $1.nameGroup} )
    
    var itemsFiltered = [GroupModel]()
    var searchAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    

    // MARK: - Table view data source

/*    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    //    return 10  // для проверки и настройки
        return searchAction ? itemsFiltered.count : groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseIndentifier, for: indexPath) as? GroupCell else { return UITableViewCell() }
        
        //cell.groupNameLabel.text = "Пингвины Мадагаскара"
        let group = searchAction ? itemsFiltered[indexPath.row] : groups[indexPath.row]
        cell.groupNameLabel.text = group.nameGroup
        cell.groupImageView.image = UIImage(named: group.imageGroup)

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
            
            groups.remove(at: indexPath.row)
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
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let controller = segue.source as? FindGroupViewController,
            let indexPath = controller.tableView.indexPathForSelectedRow {
            let group = controller.groups[indexPath.row]
            
            guard !groups.contains(where: { $0.nameGroup == group.nameGroup } ) else {return}
            
            groups.append(group)
            
            //tableView.reloadData()
            let newIndexPath = IndexPath(item: groups.count - 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: SeachBar navigation
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchAction = searchText.count == 0 ? false : true
        itemsFiltered = groups.filter { $0.nameGroup.lowercased().contains(searchText.lowercased())}
        
        tableView.reloadData()
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
