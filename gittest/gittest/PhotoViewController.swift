//
//  PhotoViewController.swift
//  gittest
//
//  Created by 張健民 on 2017/4/18.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var myImageView: DownloadImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(fileURLWithPath: "https://s-media-cache-ak0.pinimg.com/originals/7f/f1/7a/7ff17a18dba0e8ad167d96f1a845a896.jpg")
        myImageView.loadImageWithURL(url: url)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
