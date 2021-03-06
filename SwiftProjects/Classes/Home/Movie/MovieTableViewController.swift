//
//  MovieTableViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/7.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import ESPullToRefresh

let movieCellID = "MovieCell"

class MovieTableViewController: UITableViewController {
    
    var start = 0
    
    var count = 20
    
    
    var movies: Movie?
    
    deinit {
        print(String(NSStringFromClass(self.classForCoder)) + " had deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self)
        
        self.navigationItem.title = "豆瓣Top250"
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        edgesForExtendedLayout = .init(rawValue: 0) // Set content view following the navbar
        
        initTableView()
        
        self.tableView.es.startPullToRefresh()
        
//        let index: String.Index = "".startIndex
        
    }
    // MARK: Initial TableView
    private func initTableView() {
        self.tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: movieCellID)
        
        // Add Refresh
        self.tableView.addPullToRefresh {
            [unowned self] in
            
            self.loadDatas()
        }
        
        
        self.tableView.addInfiniteScrolling {
            [unowned self] in
            
            self.loadMoreData()
        }
    }
    
    private func loadDatas() {
        start = 0
        MovieViewModel.getMovies(start: start, count: count, success: { (responseData) in
            self.movies = responseData as? Movie
            print(self.movies ?? "not a value")
            self.tableView.reloadData()
            self.tableView.es.stopPullToRefresh()
            self.start += self.count
        }) { (error) in
            print(error)
        }
    }
    
    /// load network data
    private func loadMoreData() {
        MovieViewModel.getMovies(start: start, count: count, success: { (responseData) in
            print(responseData ?? "not value")
            
            guard let newData = responseData as? Movie else {
                print("no more data")
                self.tableView.es.noticeNoMoreData()
                return
            }
            
            self.movies?.subjects = self.movies!.subjects + newData.subjects
            self.tableView.reloadData()
            self.tableView.es.stopPullToRefresh()
            
            self.start += self.count
            
            if self.movies!.subjects.count >= self.movies!.total {
                self.tableView.es.noticeNoMoreData()
            }else{
                self.tableView.es.stopLoadingMore()
            }
            
           
        }) { (error) in
            print(error)
        }
    }
}

// MARK: - Table view data source
extension MovieTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return movies?.subjects.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellID, for: indexPath) as! MovieCell
        cell.model = movies?.subjects[indexPath.section]
        cell.rankLabel.text = String(indexPath.section)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
