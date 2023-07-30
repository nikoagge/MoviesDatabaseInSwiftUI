//
//  ImageLoader.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import UIKit
import SwiftUI

private let _imageCache = NSCache<AnyObject, AnyObject>()

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache
    
    func loadImage(with url: URL) {
        let urlAbsoluteString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlAbsoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: urlAbsoluteString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
