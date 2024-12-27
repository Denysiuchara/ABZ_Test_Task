//
//  UIImage + description.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import UIKit
import Photos

extension UIImage {
    var imageDescription: String {
        var description = ""
        
        if let imageData = self.pngData() {
            let imageSizeMB = Double(imageData.count) / (1024.0 * 1024.0)
            description += String(format: " %.0fMB", imageSizeMB)
        }
        
        return description
    }
    
    var asData: Data? {
        if let jpegData = self.jpegData(compressionQuality: 1.0) {
            return jpegData
        } else if let pngData = self.asData {
            return pngData
        } else {
            return nil
        }
    }
    
    var asBackendReadyData: Data? {
        let minimumSize: CGSize = CGSize(width: 70, height: 70)
        
        guard self.size.width >= minimumSize.width, self.size.height >= minimumSize.height else {
            print("Image is too small")
            return nil
        }
        
        let resizedImage = self.resize(to: minimumSize)
        var compressionQuality: CGFloat = 0.9
        var jpegData = resizedImage.jpegData(compressionQuality: compressionQuality)
        
        while let data = jpegData, Double(data.count) / (1024.0 * 1024.0) > 5, compressionQuality > 0.1 {
            compressionQuality -= 0.1
            jpegData = resizedImage.jpegData(compressionQuality: compressionQuality)
        }
        
        guard let finalData = jpegData, Double(finalData.count) / (1024.0 * 1024.0) <= 5 else {
            print("Image size is greater than 5 MB after resizing and compressing")
            return nil
        }
        
        return finalData
    }

    fileprivate func resize(to targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage
    }
}
