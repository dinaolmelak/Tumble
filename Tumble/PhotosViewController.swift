//
//  PhotosViewController.swift
//  Tumble
//
//  Created by Dinaol Melak on 11/27/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var photos: [[String: Any]] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data,
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              print(dataDictionary)

              // TODO: Get the posts and store in photos property
            let responseDict = dataDictionary["response"] as! [String:Any]
            self.photos = responseDict["posts"] as! [[String:Any]]

              // TODO: Reload the table view
            self.tableView.reloadData()
          }
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let post = photos[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]]{
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let imageHeight = originalSize["height"] as! Int
            let imageWidth = originalSize["width"] as! Int
            
            let url = URL(string: urlString)!
            cell.cellImageView.af_setImage(withURL: url)
            cell.cellImageView.frame.size = CGSize(width: imageWidth, height: imageHeight)
            
            
        }
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let photoDetail = segue.destination as! DetailViewController
        // get the reference for where the data should go to
        let cell = sender as! PhotosCell
        
        let indexPath = tableView.indexPath(for: cell)!
        let post = photos[indexPath.row]
        
        
        
        photoDetail.post = post
        
    }
    

}
