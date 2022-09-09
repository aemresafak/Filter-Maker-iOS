//
//  PermissionManager.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 9.09.2022.
//

import Foundation
import Photos

struct PhotosLibraryPermissionManager {
    var onAuthorized: (() -> Void)?
    var onDenied: (() -> Void)?
        
    
    
    
    func requestPhotosLibraryAdditionPermission() {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            switch status {
            case .authorized:
                onAuthorized?.self()
            case .denied:
                onDenied?.self()
            default:
                onDenied?.self()
            }
        }
    }
    
    
    
    
    
   
    
    
    
}
