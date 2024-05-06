//
//  SampleView.swift
//  iPhotos
//
//  Created by Yery Castro on 30/4/24.
//

import SwiftUI
import SwiftData

struct SampleView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let sample: SampleModel
    @State private var formType: ModelFormType?
    
    var body: some View {
        VStack {
            Text(sample.name)
                .font(.largeTitle)
            ZoomableScrollView {
                Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
            }
            HStack {
                Button("Edit") {
                    formType = .update(sample)
                }
                .sheet(item: $formType) { $0 }
                Button("Delete", role: .destructive) {
                    modelContext.delete(sample)
                    try? modelContext.save()
                    dismiss()
                } 
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
        }
        .padding()
        .navigationTitle("Sample View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let container = SampleModel.preview
    let fetchDescriptor = FetchDescriptor<SampleModel>()
    let sample = try! container.mainContext.fetch(fetchDescriptor)[0]
    return NavigationStack {
        SampleView(sample: sample)
    }
}
