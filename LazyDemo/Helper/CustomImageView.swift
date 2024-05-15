//
//  CustomImageView.swift
//  LazyDemo
//
//  Created by Rakesh Sharma on 16/05/24.
//

import UIKit

class CustomImageView: UIImageView {
    var task: URLSessionTask!
    var imgCache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(url: URL) {
        image = nil
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imgCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("couldn't load image from url: \(url)")
                return
            }
            self.imgCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
            }
        })
        task.resume()
            
    }
}
