//
//  UpdateEditFormVievModel.swift
//  iPhotos
//
//  Created by Yery Castro on 30/4/24.
//

import UIKit

@Observable
final class UpdateEditFormViewModel {
    var name: String = ""
    var data: Data?
    var sample: SampleModel?
    var cameraImage: UIImage?
    
    var image: UIImage {
        if let data, let uiImage = UIImage(data: data) {
            return uiImage
        } else {
            return Constants.placeholder
        }
    }
    
    init() {}
    init(sample: SampleModel) {
        self.sample = sample
        self.name = sample.name
        self.data = sample.data
    }
    func clearImage() async {
        await MainActor.run {
            data = nil
        }
    }
    
    var isUpDating: Bool { sample != nil }
    var isDisabled: Bool { name.isEmpty }
}
