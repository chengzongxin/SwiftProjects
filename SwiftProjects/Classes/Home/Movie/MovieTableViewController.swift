//
//  MovieTableViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/7.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
let movieCellID = "MovieCell"

class MovieTableViewController: UITableViewController {
    
    var movies: Movie?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "豆瓣Top250"
        
        self.tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: movieCellID)
        
        loadDatas()
    }
    
    private func loadDatas() {
        MovieViewModel.getMovies(success: { (responseData) in
            print(responseData ?? "not value")
            self.movies = responseData as? Movie
            self.tableView.reloadData()
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
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
