//
//  MyTableViewCell.swift
//  FetchApi
//
//  Created by Vikas Pandey on 05/07/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var articlesList = [Article]()
    
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
   
}
