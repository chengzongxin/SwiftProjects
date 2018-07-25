//
//  BookTableViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/25.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import SCLAlertView

let bookCellId = "BookCell"

class BookTableViewController: UITableViewController {
    
    let urlString = "https://api.douban.com/v2/book/search"
    
    var tag = "Swift"
    
    var books = [Book?]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = tag
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(clickRightItem))
        
        tableView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: bookCellId)
        
        tableView.tableFooterView = UIView()
        
        loadDatas()
        
    }

    @objc private func clickRightItem() {
        print("click right item")
        // Add a text field
        let alert = SCLAlertView()
        let txt = alert.addTextField()
        alert.addButton("Show Name") {
            print("Text value: \(txt.text ?? "nil value")")
            guard let txtValue = txt.text else {
                return
            }
            
            self.tag = txtValue
            self.title = txtValue
            self.loadDatas()
        }
        alert.showEdit("Search Books", subTitle: "Input book what u want")
    }

    private func loadDatas() {
        NetworkManager.GET(URLString: urlString, parameters: ["tag" : tag, "start" : 0, "count" : 10], success: { (responseObject) in
            let dataDic = responseObject as? Dictionary<String, Any>
            let dataArr = dataDic?["books"] as? [Any]
            if let datas = [Book].deserialize(from: dataArr){
                print("resonponsedata = \(datas)")
                self.books = datas
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: bookCellId, for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        
        let book = books[indexPath.row]
        
        let url = URL(string: (book?.image)!)
        cell.iconImageView.setImageWith(url!)
        
        cell.bookTitle.text = book?.title
        
        cell.rating.text = "rating: \(book?.rating.average ?? "")"
        
        cell.subTitle.text = book?.summary
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
