//
//  NewsContentViewController.swift
//  FetchApi
//
//  Created by Vikas Pandey on 05/07/22.
//

import UIKit

class NewsContentViewController: UIViewController {
    
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myNewsContent: UILabel!
    
    var newsContent:Article = Article(author: "", title: "", description: "", url: "", urlToImage: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        myTitle.text = newsContent.title
        if newsContent.urlToImage != nil
        {
            let url = URL(string: newsContent.urlToImage!)
            myImage.businessImage(from: url!)
            myImage.contentMode = .scaleToFill
        }
        else
        {
            myImage.image = UIImage(named: "emptyimage")
        }
        myNewsContent.text = newsContent.description
    }
    

    

}
