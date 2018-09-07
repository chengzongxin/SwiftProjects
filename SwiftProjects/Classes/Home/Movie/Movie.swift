//
//  Movie.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/7.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import HandyJSON
//电影信息
//struct Movie {
//    var poster:String //海报
//    var title:String  //标题
//    var introduction:String //简介
//}

class Movie: HandyJSON{
    var count : Int!
    var start : Int!
    var subjects : [Subject]!
    var title : String!
    var total : Int!
    
    required init() {}
}


class Subject: HandyJSON{
    var alt : String!
    var casts : [Cast]!
    var collectCount : Int!
    var directors : [Cast]!
    var genres : [String]!
    var id : String!
    var images : Avatar!
    var originalTitle : String!
    var rating : MovieRating!
    var subtype : String!
    var title : String!
    var year : String!
    
    required init() {}
}

class MovieRating: HandyJSON{
    var average : Int!
    var max : Int!
    var min : Int!
    var stars : String!
    
    required init() {}
}

class Cast: HandyJSON{
    var alt : String!
    var avatars : Avatar!
    var id : String!
    var name : String!
    
    required init() {}
}

class Avatar: HandyJSON{
    var large : String!
    var medium : String!
    var small : String!
    
    required init() {}
}
