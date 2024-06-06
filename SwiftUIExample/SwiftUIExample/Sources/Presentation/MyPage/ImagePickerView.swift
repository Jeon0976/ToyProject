//
//  ImagePickerView.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 6/3/24.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var pickedImage: Image
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = context.coordinator
        imagePickerController.allowsEditing = true
        
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    final class Coordinator: NSObject {
        let parent: ImagePickerView
        
        init(_ imagePickerView: ImagePickerView) {
            self.parent = imagePickerView
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension ImagePickerView.Coordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        let originalImage = info[.originalImage] as! UIImage
        let editedImage = info[.editedImage] as? UIImage
        let selectedImage = editedImage ?? originalImage
        
        parent.pickedImage = Image(uiImage: selectedImage)
        
        picker.dismiss(animated: true)
    }
}

struct ContentView: View {
    @State private var pickedImage: Image = Image(systemName: "photo")
    @State private var isPickerPresented: Bool = false
    
    var body: some View {
        VStack {
            pickedImage
                .resizable().scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.bottom)
            
            Button(action: { self.isPickerPresented.toggle() }, label: {
                Text("Show ImagePicker").bold()
            })
        }
        .sheet(isPresented: $isPickerPresented, content: {
            ImagePickerView(pickedImage: self.$pickedImage)
        })
    }
}

#Preview {
    ContentView()
}
