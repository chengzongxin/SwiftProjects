//
//  Book.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/25.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import HandyJSON

class Rating: HandyJSON {
    var min = 0
    var average = "8.4"
    var max = 10
    var numRaters = 183
    
    required init() {}
}

//MARK: inherit HandyJson
class Book: HandyJSON {
    var isbn13 = "9780300164695"
    var author_intro = ""
    var publisher = ""
    var pages = ""
    var title = "The Swift Programming Language"
    var tags = [Any]()
    var image = "https://img3.doubanio.com/view/subject/m/public/s29728470.jpg"
    var catalog = ""
    var alt = "https://book.douban.com/subject/25899841/"
    var isbn10 = "0300164696"
    var url = "https://api.douban.com/v2/book/25899841"
    var alt_title = ""
    var images = [String]()
    var summary = "Swift is a new programming language for creating iOS and OS X apps. Swift builds on the best of C and Objective-C, without the constraints of C compatibility. Swift adopts safe programming patterns and adds modern features to make programming easier, more flexible, and more fun. Swift’s clean slate, backed by the mature and much-loved Cocoa and Cocoa Touch frameworks, is an opportunity to reimagine how software development works.This book provides:- A tour of the language.- A detailed guide delving into each language feature.- A formal reference for the language."
    var pubdate = "2014-6-2";
    var origin_title = "";
    var id = "25899841";
    var subtitle = "";
    var translator = [Any]()
    var price = "";
    var rating = Rating()
    var author = [Any]()
    var binding = "电子书"
    
    required init() {}
}


