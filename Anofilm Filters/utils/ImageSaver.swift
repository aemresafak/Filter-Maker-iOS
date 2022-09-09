//
//  ImageSaver.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 9.09.2022.
//

import UIKit


class ImageSaver: NSObject {
    private var onSuccess: ((UIImage) -> Void)?
    private var onFailure: ((UIImage, Error) -> Void)?
    
    init(onSuccess: ((UIImage) -> Void)? = nil, onFailure: ((UIImage, Error) -> Void)? = nil) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
    
    func saveImageToPhotos(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError: Error?, contextInfo: UnsafeRawPointer) {
        if let didFinishSavingWithError = didFinishSavingWithError {
            onFailure?.self(image, didFinishSavingWithError)
        } else {
            onSuccess?.self(image)
        }
        
    }
}
