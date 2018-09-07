//
//  MovieViewModel.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/7.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class MovieViewModel: NSObject {
    // load movie
    static func getMovies(start:(Int), count:(Int), success:((AnyObject?) -> Void)?, failure: ((NSError) -> Void)?) {
        let url = "http://api.douban.com/v2/movie/top250?start=\(start)&count=\(count)"
        NetworkManager.GET(URLString: url, parameters: nil, success: { (responseObject) in
            let movie = Movie.deserialize(from: responseObject as? [String : Any])
            success?(movie)
        }) { (error) in
            failure?(error)
        }
    }
}
