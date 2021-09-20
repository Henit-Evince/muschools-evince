//
//  SearchBar.swift
//  MuSchool
//
//  Created by Evince Development on 20/09/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField(LocalizableConstants.ScreenNames.search, text: $text)
                .font(Font.CustomRegular(size: 18))
                .foregroundColor(Color(ConstantManager.appcolorNames.AppThemeColorSecond))
                .frame(height:60)
                .cornerRadius(07)
                .padding(7)
                .padding(.horizontal, 25)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(ConstantManager.appcolorNames.AppThemeColorSecond))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }.background(Color(ConstantManager.appcolorNames.offWhite)).frame(height:60).cornerRadius(07).shadow(radius: 2)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
