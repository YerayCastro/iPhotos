//
//  ModelFormType.swift
//  iPhotos
//
//  Created by Yery Castro on 30/4/24.
//

import SwiftUI

enum ModelFormType: Identifiable, View {
    case new
    case update(SampleModel)
    var id: String {
        String(describing: self)
    }
    var body: some View {
        switch self {
        case .new:
            UpdateEditFormView(vm: UpdateEditFormViewModel())
        case .update(let sample):
            UpdateEditFormView(vm: UpdateEditFormViewModel(sample: sample))
        }
    }
}
