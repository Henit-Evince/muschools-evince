//
//  ContentView.swift
//  MuSchool
//
// Created by Evince Development on 20/09/21.
//

import SwiftUI
import SwiftyJSON
import Alamofire
import SwiftUIRefresh

struct ContentView: View {
    
    init() {
        //Navigation bar Appearance
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appTheme]
        UINavigationBar.appearance().backgroundColor = UIColor.lightBackground
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appTheme]
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        //Textfield Appearance
        UITextField.appearance().tintColor = UIColor.appTheme
        
        //Table View Appearance
        UITableView.appearance().backgroundColor = UIColor.lightBackground
        UITableViewCell.appearance().backgroundColor = UIColor.white
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = UIColor.clear
        UIScrollView.appearance().bounces = true
    }
    
    @State var showActionSheet: Bool = false
    @EnvironmentObject var envObjects : EnvObjects
    @State var objCryptoListData : [CryptoDetailModel] = []
    @State private var searchText = ""
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @State private var isShowing = false
    @State private var isScrollTotop = false
    @State private var showingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        NavigationView() {
            ZStack{
                VStack{
                    ScrollViewReader { scrollViewReader in
                        List{
                            Section(header:
                                        SearchBar(text: $searchText).padding(EdgeInsets(top: 00, leading: 05, bottom: 0, trailing: 05))) {
                                ForEach(self.objCryptoListData.filter(({ searchText.isEmpty ? true : $0.name.contains(searchText) })), id: \.self) { item in
                                    
                                    //CryptoCard ListView
                                    CryptoCardListView(cryprodetailModel: item).padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)).background((Color.white)).cornerRadius(10)
                                        .shadow(radius: 2)
                                    
                                }.padding(EdgeInsets(top: 05, leading: -16, bottom: 05, trailing: -16))
                            }.textCase(nil).listRowBackground(Color(ConstantManager.appcolorNames.offWhite))
                        }.onAppear(){
                            withAnimation {
                                
                                //Scroll to Top on sorting
                                if self.isScrollTotop{
                                    scrollViewReader.scrollTo(self.objCryptoListData.first)
                                    self.isScrollTotop = false
                                }
                            }
                        }
                        
                        //Pull to refresh
                        .pullToRefresh(isShowing: $isShowing) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isShowing = false
                                self.getCryptoListData()
                            }
                        }.background(Color(ConstantManager.appcolorNames.AppThemeColorSecond)).foregroundColor(Color(ConstantManager.appcolorNames.AppThemeColorSecond)).listStyle(InsetGroupedListStyle())
                    }
                }.background(Color(ConstantManager.appcolorNames.offWhite))
                
                //Activity Indicator
                if envObjects.isLoading {
                    ActivityIndicator(style: .large).foregroundColor(Color(ConstantManager.appcolorNames.AppThemeColorSecond))
                }
            }.alert(isPresented: $showingAlert, content: {
                return Alert(title: Text(LocalizableConstants.AppName.muSchool), message: Text(alertMessage),
                             dismissButton: .default(Text(LocalizableConstants.ButtonNames.ok)) {
                                
                             })
            })
            .background(Color(ConstantManager.appcolorNames.offWhite))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showActionSheet.toggle()
                                    }) {
                                        Image(uiImage: #imageLiteral(resourceName: "icon_filter"))
                                            .resizable()
                                            .foregroundColor(Color(ConstantManager.appcolorNames.offWhite))
                                            .frame(width: 25, height: 25, alignment: .center)
                                            .aspectRatio(contentMode: .fill)
                                            .padding(EdgeInsets(top: 05, leading: 05, bottom: 05, trailing: 05))
                                    }.foregroundColor(Color(ConstantManager.appcolorNames.offWhite))
                                    
                                    //Action Sheet for Sorting
                                    .actionSheet(isPresented: $showActionSheet, content: {
                                        ActionSheet(title: Text(LocalizableConstants.ButtonNames.sortBy),
                                                    message: Text(""),
                                                    buttons: [
                                                        .default(Text(LocalizableConstants.ButtonNames.sortbyValueHtoL)) {
                                                            self.isScrollTotop = true
                                                            let cryptoData = self.objCryptoListData.sorted(by: { $0.currentRate > $1.currentRate })
                                                            self.objCryptoListData = cryptoData
                                                        },
                                                        .default(Text(LocalizableConstants.ButtonNames.sortbyValueLtoH)) {
                                                            self.isScrollTotop = true
                                                            let cryptoData = self.objCryptoListData.sorted(by: { $0.currentRate < $1.currentRate })
                                                            self.objCryptoListData = cryptoData
                                                        },
                                                        .default(Text(LocalizableConstants.ButtonNames.sortbyName)) {
                                                            self.isScrollTotop = true
                                                            let cryptoData = self.objCryptoListData.sorted(by: { $0.name < $1.name })
                                                            self.objCryptoListData = cryptoData
                                                        },
                                                        .default(Text(LocalizableConstants.ButtonNames.sortbyType)) {
                                                            self.isScrollTotop = true
                                                            let cryptoData = self.objCryptoListData.sorted(by: { $0.symbol < $1.symbol })
                                                            self.objCryptoListData = cryptoData
                                                        },
                                                        .destructive(Text(LocalizableConstants.ButtonNames.cancel)) {
                                                        }
                                                    ])
                                    })
            )
            .navigationBarTitle(LocalizableConstants.ScreenNames.currencies,displayMode: .large)
        }.edgesIgnoringSafeArea(.all)
        .onAppear{
            self.getCryptoListData()
            
        }.onReceive(timer) { time in
            self.getCurrentRatesOfCrypto(isActivityIndicator: false)
            
        }.onDisappear(){
            self.timer.upstream.connect().cancel()
        }
    }
}

//MARK:- API calling -

extension ContentView{
    
    //Get List of crypto currency API
    
    func getCryptoListData(){
        self.envObjects.isLoading = true
        
        if IS_INTERNET_AVAILABLE() {
            RequestManager.postAPI(urlPart: ConstantManager.APINames.cryptoList, parameters: [:], successResult: { (response, statusCode) in
                self.envObjects.isLoading = false
                
                let responseObject = JSON(response)
                print(responseObject)
                self.getCurrentRatesOfCrypto(isActivityIndicator: true)
                
                let cryptoData = responseObject[APIKey.kcrypto]
                
                for (key, value) in cryptoData {
                    print(key)
                    print(value)
                    
                    let data = CryptoDetailModel(fromJson: JSON(value))
                    self.objCryptoListData.append(data)
                }
                
            }) { (error) in
                self.envObjects.isLoading = false
                self.showingAlert = true
                self.alertMessage = LocalizableConstants.Message.apiFailed
            }
        }else{
            self.envObjects.isLoading = false
            self.showingAlert = true
            self.alertMessage = LocalizableConstants.Message.noINternetconnection
        }
    }
    
    //Get Current Rate API -
    
    func getCurrentRatesOfCrypto(isActivityIndicator: Bool){
        self.envObjects.isLoading = isActivityIndicator
        
        if IS_INTERNET_AVAILABLE() {
            RequestManager.postAPI(urlPart: ConstantManager.APINames.currentRateList, parameters: [:], successResult: { (response, statusCode) in
                self.envObjects.isLoading = false
                
                let responseObject = JSON(response)
                print(responseObject)
                
                let currentRate = responseObject[APIKey.krates]
                let allCryptoData = self.objCryptoListData
                
                for count in 0..<allCryptoData.count{
                    for (key, value) in currentRate {
                        print(key)
                        print(value)
                        if allCryptoData[count].symbol == key{
                            allCryptoData[count].currentRate = currentRate[key].doubleValue
                            break
                        }
                    }
                }
                
                self.objCryptoListData = allCryptoData
                
            }) { (error) in
                self.envObjects.isLoading = false
                self.showingAlert = true
                self.alertMessage = LocalizableConstants.Message.apiFailed
            }
        }else{
            self.envObjects.isLoading = false
            self.showingAlert = true
            self.alertMessage = LocalizableConstants.Message.noINternetconnection
        }
    }
}

