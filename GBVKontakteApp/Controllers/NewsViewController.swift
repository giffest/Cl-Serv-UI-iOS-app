//
//  NewsViewController.swift
//  
//
//  Created by Dmitry on 07/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var news: [NewsModel] = [
        NewsModel(id: 1, nameFriend: "Губка Боб", nameFoto: "ГубкаБоб", dateNews: "31.12.2017", textNews: "Nickelodeon снимет приквел культового мультсериала «Губка Боб Квадратные Штаны». Об этом сообщает Deadline", imageNews: "ГубкаБобНовости"),
        NewsModel(id: 2, nameFriend: "Незнайка", nameFoto: "Незнайка", dateNews: "01.05.2019", textNews: "«Незнайка на Луне» пройдет лингвистическую экспертизу после обвинений в разжигании ненависти к полицейским", imageNews: "НезнайкаНовости"),
        NewsModel(id: 3, nameFriend: "Мамонтенок", nameFoto: "Мамонтенок", dateNews: "05.06.2019", textNews: "В Крыму обнаружили километровую пещеру с останками мамонта и мамонтёнка", imageNews: "МамонтенокНовости"),
        NewsModel(id: 4, nameFriend: "Карлсон", nameFoto: "Карлсон", dateNews: "03.04.2019", textNews: "Союзмультфильм» ожидает завершения переговоров с наследниками шведской писательницы Астрид Линдгрен о создании продолжения советского мультфильма «Малыш и Карлсон» весной, сообщает RNS. В ближайшее время партнеры планируют договориться о софинансировании нового проекта.", imageNews: "КарлсонНовости")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return news.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell else { return UICollectionViewCell() }
    
        let row = indexPath.row
        cell.imageFriendNews.image = UIImage(named: news[row].nameFoto)
        cell.imageNews.image = UIImage(named: news[row].imageNews)
        cell.textNews.text = news[row].textNews
        cell.nameFriend.text = news[row].nameFriend
        cell.dateNews.text = news[row].dateNews
    
        return cell
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
