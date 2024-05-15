//
//  ImageGridViewController.swift
//  LazyDemo
//
//  Created by Rakesh Sharma on 08/05/24.
//

import UIKit

class ImageGridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ImageCVC.nib, forCellWithReuseIdentifier: ImageCVC.identifire)
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchImagesFromAPI()
    }
    
    func fetchImagesFromAPI() {
        Task {
            do {
                let data = try await fetchData(from: URL(string: apiURL)!)
                let decodedData = try JSONDecoder().decode([ImageModel].self, from: data)
                for imageData in decodedData {
                    if let imageURL = constructImageURL(from: imageData.thumbnail) {
                            images.append(imageURL)
                    }
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func constructImageURL(from thumbnail: Thumbnail) -> URL? {
        guard let domain = thumbnail.domain, let basePath = thumbnail.basePath, let key = thumbnail.key else {
            return nil
        }
        
        let imageURLString = "\(domain)/\(basePath)/0/\(key)"
        return URL(string: imageURLString)
    }
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

extension ImageGridViewController: UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCVC.identifire, for: indexPath) as! ImageCVC
        cell.imgThumb.loadImage(url: images[indexPath.item])
        return cell
    }
    
}

extension ImageGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width/3 - 10), height: (collectionView.bounds.width/3 - 10))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
