//
//  ContentView.swift
//  ImagePicker
//
//  Created by Leroy Whitt on 10/6/23.
//
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
    var body: some View {
        VStack {
            if let data = data, let uiimage = UIImage(data: data){
                Image(uiImage: uiimage)
                    .resizable()
            }
            
            Spacer()
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 1,
                matching: .images
            )  {
                Text("Pick photo")
            }
            
           .onChange(of: selectedItems)
            { newValue in
                guard let item = selectedItems.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in switch result {
                case .success(let data):
                    if let data = data {
                        self.data = data
                    } else {
                        print("Data is nil")
                    }
                case .failure(let failure):
                    fatalError("\(failure)")
                }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
