//
//  ImagePicker.swift
//  Carodes-iOS
//
//  Created by Ahmet Emre Safak on 28.08.2022.
//

import SwiftUI
import PhotosUI


struct ImagePicker: UIViewControllerRepresentable {

    @Binding var imageWithOrientation: (image: UIImage?, orientation: UIImage.Orientation?)?
    class Coordinator: NSObject, PHPickerViewControllerDelegate {

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                var orientation: UIImage.Orientation?
                provider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                    if error != nil {
                        return
                    }
                    let options = [kCGImageSourceShouldCache as String: kCFBooleanFalse]
                    if let url = url, let data = NSData(contentsOf: url)  {
                        guard let imgSrc = CGImageSourceCreateWithData(data, options as CFDictionary) else { return }
                        guard let metadata = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options as CFDictionary) else { return }
                        let metadataDictionary = metadata as NSDictionary
                        guard let orientationValue = metadataDictionary[kCGImagePropertyOrientation] as? Int else { return }
                        orientation = UIImage.Orientation(rawValue: orientationValue)
                    }
                }
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.imageWithOrientation = (image as? UIImage, orientation ?? UIImage.Orientation.up)
                }
            }
        }


        private var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }


    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        let photoLibrary = PHPhotoLibrary.shared()
        var config = PHPickerConfiguration(photoLibrary: photoLibrary)
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
