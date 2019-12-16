//
//  DetailViewController.swift
//  Tumble
//
//  Created by Dinaol Melak on 12/16/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var photoVC: UIImageView!
    var post = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPicture()
    }
    
    func setupPicture(){
        if let photos = post["photos"] as? [[String: Any]]{
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let picHeight = originalSize["height"] as! Int
            let picWidth = originalSize["width"] as! Int
            
            //let url = URL(string: urlString)!
            //cell.cellImageView.af_setImage(withURL: url)
            //cell.cellImageView.frame.size = CGSize(width: imageWidth, height: imageHeight)
            let picUrl = URL(string: urlString)!
            photoVC.af_setImage(withURL: picUrl)
            //photoVC.frame.size = CGSize(width: picWidth, height: picHeight)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
