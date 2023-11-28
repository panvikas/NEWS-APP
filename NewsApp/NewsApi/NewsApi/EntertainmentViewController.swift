//
//  EntertainmentViewController.swift
//  FetchApi
//
//  Created by Mohd Abid on 10/08/22.
//

import UIKit

class EntertainmentViewController: UIViewController {
    
    var articlesList = [Article]()

    @IBOutlet weak var enterTable: UITableView!
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
                self.enterTable.reloadData()
            }
        })
        dataTask.resume()
    }
}

extension UIImageView
{
    func  entertainmentImage(from url: URL)
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
   
extension EntertainmentViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(articlesList.count)
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = enterTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
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
            cell.myImageView.entertainmentImage(from: url!)
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

   


