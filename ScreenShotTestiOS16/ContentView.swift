//
//  ContentView.swift
//  ScreenShotTestiOS16
//
//  Created by DONG SHENG on 2022/7/29.
//

// iOS 16 以後的版本才能使用  要記得在info 添加 Privacy - Photo Library Additions Usage Description
// 將 SwiftUI View 變成 UIImage
//

import SwiftUI

struct ContentView: View {
    
    @State private var newImage: UIImage?
    
    var body: some View {
        VStack {
         
            ScreenView
            
            Button {
                let render = ImageRenderer(content: ScreenView)
                render.scale = UIScreen.main.scale // 讓解析與iPhone一致
                self.newImage = render.uiImage
                
                // 保存到相簿
                if let saveImage = render.uiImage{
                    UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil)
                }
                
                // 假設有透明的地方要保留 則要轉成png檔 再儲存
                if let pngData = render.uiImage?.pngData(), let pngImage = UIImage(data: pngData){
                    UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
                }
                
            } label: {
                Text("iOS 16 ScreenShot ")
                    .font(.title)
                    .padding()
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                
            }
            
            if let newImage{
                Image(uiImage: newImage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView{
    
    private var ScreenView: some View{
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .frame(width: 350 ,height: 500)
        .background(.yellow)
    }
}
