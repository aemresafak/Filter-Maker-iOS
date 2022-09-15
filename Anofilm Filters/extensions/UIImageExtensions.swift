//
//  UIImageExtensions.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 15.09.2022.
//

import SwiftUI


extension UIImage.Orientation {
    var cgImagePropertyOrientation: CGImagePropertyOrientation {
        let cgImagePropertyOrientation: CGImagePropertyOrientation
        switch self {
        case .up:
            cgImagePropertyOrientation = .up
        case .upMirrored:
            cgImagePropertyOrientation = .upMirrored
        case .left:
            cgImagePropertyOrientation = .left
        case .leftMirrored:
            cgImagePropertyOrientation = .leftMirrored
        case .right:
            cgImagePropertyOrientation = .right
        case .rightMirrored:
            cgImagePropertyOrientation = .rightMirrored
        case .down:
            cgImagePropertyOrientation = .down
        case .downMirrored:
            cgImagePropertyOrientation = .downMirrored
        @unknown default:
            fatalError("Unknown UIImage.Orientation: \(self.rawValue)")
        }
        return cgImagePropertyOrientation
    }
}
