//
//  DownloadImageView.swift
//  HelloDownloadImage
//
//  Created by 張健民 on 2017/3/28.
//  Copyright © 2017年 張健民. All rights reserved.
//

import UIKit
class MyButton: UIButton{
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setTitle("Hello", for: .normal)
    }
}


class DownloadImageView: UIImageView {
    
    
    var loading:UIActivityIndicatorView?
    
    //storyboard UI元件子類別一定要寫下列這個方法fatalError
    required init?(coder aDecoder: NSCoder){
        let activityViewFrame = CGRect(x: 0, y: 0, width: 37, height: 37)//還不知Frame data，先以x y 先設零
        UIActivityIndicatorView(frame: activityViewFrame)
        loading = UIActivityIndicatorView(frame: activityViewFrame)
        loading?.color = UIColor.blue
        loading?.hidesWhenStopped = true
        super.init(coder: aDecoder)
        if loading != nil{
            self.addSubview(loading!)
            loading?.frame = CGRect(x: frame.width/2, y: frame.height/2, width: 37, height: 37)
        }

        //fatalError("還沒有寫這個方法")
    }
    override init(frame: CGRect){
        //初始化 activity indicator
        let activityViewFrame = CGRect(x: frame.width/2, y: frame.height/2, width: 37, height: 37)
        UIActivityIndicatorView(frame: activityViewFrame)
        loading = UIActivityIndicatorView(frame: activityViewFrame)
        loading?.color = UIColor.blue
        loading?.hidesWhenStopped = true
        //loading?.activityIndicatorViewStyle = .whiteLarge
        super.init(frame: frame)//初始化要寫在super.init之前
        
        if loading != nil{
            self.addSubview(loading!)
        }
    }
    
//    init(url:URL){
//        super.init(CGRect(x:0,y:0.width:100,height:100))
//        self.loadImageWithURL(url: URL)
//    }
    
    func loadImageWithURL(url:URL){//用這個方法給一個網址，就去下載圖片
        let session = URLSession(configuration: .default)//生出一個 URLsession
        //下載之後檔案的名稱
        let hashFileName = "Cache_\(url.hashValue)"
        //找到快取資料匣的位置
        let cachePath = NSHomeDirectory() + "/Library/Caches/"
        let fullFilePathName = cachePath + hashFileName //最後檔案要存的位置
        
        //在下載前，如果已經下載過的話…
        let cacheImage = UIImage(contentsOfFile: fullFilePathName)
        if cacheImage != nil{
            self.image = cacheImage//把從快取讀到的圖片秀出來
            return//就不要繼續執行
        }
        
        //產生一個下載工作
        let task = session.dataTask(with: url) {
            (data, response, error) in //下載完會執行的closure
            DispatchQueue.main.async {//要放在主佇列中才能作用
                self.loading?.stopAnimating()
            }
            
            if error != nil{//如果有錯誤，不要執行下去
                return
            }
            if let okData = data{//如果真的有值，真的下載到圖片
                let downloadImage = UIImage(data: okData)//用下載的資料產生圖片
                DispatchQueue.main.async {       //找到主佇列
                    self.image = downloadImage  //更改畫面的圖片
                }
                //把下載的資料存到手機裡面
                do{
                    let url = URL(fileURLWithPath: fullFilePathName)
                    try okData.write(to: url)
                    print("write to file ok")
                }catch{
                    print(error.localizedDescription)
                    print("write to file error")
                }
            }
        }
        loading?.startAnimating()
        task.resume()
    }
    
}
