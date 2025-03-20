//
//  WelcomeToView.swift
//  Project Gotemba
//
//  Created by Naoki Takehara on 2024/11/22.
//

import SwiftUI
import Kingfisher

struct WelcomeToView: View {
    
    let PostimageUrl =  ["https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2FD66DAB78-2383-4CA1-A616-E09FDE0A2291?alt=media&token=9fe56052-a7cf-43fe-82b3-093ffe43475a", "https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2FC86219CC-28B8-415F-A956-676FDB8B3583?alt=media&token=c50dc4f5-7613-4092-9f8b-39ac9b61cf1c","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F9F0BEEA1-5177-4AD4-9BF1-2A6A249DBD46?alt=media&token=099eadd8-f951-4b9c-a7f2-97d4c1906e8f","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F1CB74404-6947-4DCF-A354-E3BBBC1778E8?alt=media&token=d9f9ab54-56e0-4bc5-8384-45973172ef39","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F6C73F583-AF48-41C2-9DA8-2BF9F71CC76A?alt=media&token=f41d0d40-ff00-4b7d-9045-76bf9f0fe8e1","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F809E376E-59E8-4220-81D5-4A3E4EE85A5B?alt=media&token=2335924a-a7c8-4138-95f9-15ee65182943","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F2C1465BC-1EEA-4283-AB13-C270965F23DB?alt=media&token=a23bb460-8ad1-4235-b6b8-f78156c3ee15"]
    
    let PostImageUrl = [
        "https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F4855CFA8-3454-4976-9359-AEEDBC1E0ECD?alt=media&token=1db46b27-5185-4644-b024-7b01aa189b90","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F1BD68D0F-F68C-46EA-8FB6-49E3FCCDB025?alt=media&token=83d91f21-8c38-4f90-84f0-30a93029cca2","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/thread_image%2F02BF9304-163B-4725-A281-BBC4E82B01E0?alt=media&token=fd00cae4-38cc-44d5-a594-2a08d6c8b71d","https://firebasestorage.googleapis.com:443/v0/b/kaker-deva.appspot.com/o/profile_image%2F48DAEF35-FA49-4220-A13F-38AD3FAFB73A?alt=media&token=a58e18c5-cd7b-4213-b5d1-b30c7416deac"
    ]
    @State private var show = false
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            HStack{
                ImageRow(PostimageUrl: PostimageUrl)
                ImageRow(PostimageUrl: PostImageUrl)
            }
            .offset(y: show ? -4000: 2000)
            .onAppear(){
                withAnimation (.linear(duration: 10)){
                    show.toggle()
                }
            }
        }
    }
}

struct ImageRow: View{
    let PostimageUrl: [String]
    var body: some View{
        VStack(spacing: 50){
            ForEach(0..<PostimageUrl.count, id: \.self){index in
                let scale = CGFloat.random(in: 0.5 ... 1)
                KFImage(URL(string: PostimageUrl[index])).resizable().scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .scaleEffect(scale)
                    .blur(radius: randomBlur())
                    .rotationEffect(Bool.random() ? .degrees(Double.random(in: -10...10)): .degrees(0))
                    .offset(alternatingRandomOffset(index: index))
            }
        }
    }
    private func alternatingRandomOffset(index: Int) -> CGSize {
        let randomX = CGFloat.random(in: 10...120) * (index % 2 == 0 ? -1 : 1)
        let randomY = CGFloat.random(in: 0...80) * (Bool.random() ? 1:-1)
        return CGSize(width: randomX, height: randomY)
    }
    private func randomBlur() -> CGFloat {
        return Int.random(in: 1...PostimageUrl.count) <= 3 ? 5 : 0
    }
}

#Preview {
    WelcomeToView()
}
