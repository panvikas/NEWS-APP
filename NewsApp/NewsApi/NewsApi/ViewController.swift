//
//  ViewController.swift
//  FetchApi
//
//  Created by Prachi Gupta on 4/08/22.
//

import UIKit

class ViewController: UIViewController {

    var articlesList = [Article]()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
      }
    
    func fetchData ()
    {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=9bce03c2bd8d453b868e38e0be03b29c")

        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else
            {
                print("error occured while accessing data with url")
                return
            }
            var newsFullList:NewsFeed?
            do
            {
                newsFullList = try JSONDecoder().decode(NewsFeed.self, from: data)
            }
            catch{
                print("error occured while decoding json into swift structure \(error)")
            }
            self.articlesList = newsFullList!.articles ?? []
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        })
        dataTask.resume()
    }
}

extension UIImageView
{
    func businessImage(from url: URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
                    else
                    {
                        return
                    }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}
   
extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(articlesList.count)
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        if articlesList[indexPath.row].author != nil
        {
            cell.author.text = "Author: \(articlesList[indexPath.row].author!)"
        }
        else
        {
            cell.author.text = "No Author"
        }
        cell.title.text = articlesList[indexPath.row].title
        if articlesList[indexPath.row].urlToImage != nil
        {
            let url = URL(string: articlesList[indexPath.row].urlToImage!)
            cell.myImageView.businessImage(from: url!)
            cell.myImageView.contentMode  = .scaleToFill
        }
        else
        {
            cell.myImageView.image = UIImage(named: "emptyimage")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsContentViewController") as? NewsContentViewController
        vc?.newsContent = articlesList[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
}
           
           
        
    

