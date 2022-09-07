//
//  ImagePicker.swift
//  Carodes-iOS
//
//  Created by Ahmet Emre Safak on 28.08.2022.
//

import SwiftUI
import PhotosUI


struct ImagePicker: UIViewControllerRepresentable {

    @Binding var uiImage: UIImage?

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.uiImage = image as? UIImage
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
