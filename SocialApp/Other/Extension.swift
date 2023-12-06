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
extension URL {
    func loadImage() ->UIImage {
        do {
            let data : Data =  try Data(contentsOf: self)
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}
