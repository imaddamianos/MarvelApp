//
//  ImageDownloader.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import UIKit
import Alamofire
import AlamofireImage


class ImageDownloader {
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseImage { response in
            debugPrint(response)

            if case .success(let image) = response.result {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
