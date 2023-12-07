//
//  Extension.swift
//  SocialApp
//
//  Created by DucDo on 28/11/2023.
//

import Foundation
import SwiftUI

extension Encodable {
    func asDictionary() -> [String : Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String : Any]
            return json ?? [:]
        } catch {
            return [:]
        }
        
    }
}
extension UIImage {
    func changeImageResolution(scale: CGFloat) -> UIImage? {
        let imageData = self.jpegData(compressionQuality: 1.0)
        let imageWithNewScale = UIImage(data: imageData ?? Data(), scale: scale)
        return imageWithNewScale
    }
}
