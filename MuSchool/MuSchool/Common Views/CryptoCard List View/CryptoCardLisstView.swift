//
//  CryptoCardLisstView.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21..
//

import SwiftUI
import SDWebImageSwiftUI

struct CryptoCardListView: View {
    var cryprodetailModel : CryptoDetailModel?
    var heightForImage = UIScreen.main.bounds.width/6
    
    var body: some View {
        HStack(alignment: .center){
            WebImage(url: URL(string: (self.cryprodetailModel?.iconUrl ?? "")))
                .onSuccess { image, cacheType,row  in
                    // Success
                }.resizable()
                .placeholder {
                   
                }.indicator(.activity)
                .foregroundColor(Color(ConstantManager.appcolorNames.AppThemeColorSecond))
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .aspectRatio(contentMode: .fill)
                .cornerRadius((self.heightForImage)/2)
                .padding(EdgeInsets(top: 16, leading: 08, bottom: 16, trailing: 00))
                .frame(width: self.heightForImage, height: self.heightForImage, alignment: .center)
            VStack(alignment: .leading){
                HStack{
                    Text(self.cryprodetailModel?.name ?? "").font(Font.CustomSemiBold(size: 15)).foregroundColor(Color(ConstantManager.appcolorNames.AppThemeColorSecond)).lineLimit(01)
                    Spacer()
                    Text("$\(self.cryprodetailModel?.maxSupply ?? 0)").font(Font.CustomSemiBold(size: 15)).foregroundColor(Color(ConstantManager.appcolorNames.AppThemeColorSecond))
                }
                HStack{
                    Text(self.cryprodetailModel?.symbol ?? "").font(Font.CustomRegular(size: 13)).foregroundColor(Color.gray)
                    Spacer()
                    HStack{
                        if self.cryprodetailModel?.currentRate ?? 0 > 0{
                            Text("\(self.cryprodetailModel?.currentRate ?? 0)").font(Font.CustomSemiBold(size: 13)).foregroundColor(Color.white).padding(5)
                        }else{
                            Text("0.00").font(Font.CustomSemiBold(size: 13)).foregroundColor(Color.white).padding(5)
                        }
                    }.background(Color(ConstantManager.appcolorNames.AppThemeColorSecond)).cornerRadius(04)
                }.padding(.top,10)
            }.padding(EdgeInsets(top: 0, leading: 08, bottom: 0, trailing: 08))
        }.padding(EdgeInsets(top: 0, leading: 08, bottom: 0, trailing: 08))
        .background(Color.white).cornerRadius(07)
    }
}

class EnvObjects : ObservableObject {
    @Published var isLoading = false
}
