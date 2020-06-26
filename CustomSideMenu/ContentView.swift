//
//  ContentView.swift
//  CustomSideMenu
//
//  Created by Aakash on 26/06/2020.
//  Copyright © 2020 Aakash. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showMenu = false
    @State var menu: [MenuItem] = [.init(name: "Home", index:0), .init(name: "My Orders", index:1), .init(name: "My Account", index:2)]
    @State var selectedMenu = 0
    
    var body: some View {
        
        ZStack{
            
            (showMenu ? Color.primary.opacity(0.05).edgesIgnoringSafeArea(.all) : Color.clear.edgesIgnoringSafeArea(.all))
            
            ZStack(alignment: .leading){
                getSideMenu()
                MainView(showMenu: $showMenu)
                    .scaleEffect(showMenu ? 0.8 : 1)
                    .offset(x: showMenu ? 150 : 0, y: showMenu ? 50 : 0)
                    .disabled(showMenu)
            }
        }.edgesIgnoringSafeArea(.bottom)
        
    }
    
    fileprivate func getSideMenu() -> some View {
        return VStack(alignment: HorizontalAlignment.leading, spacing: 20){
            
            HStack {
                Image("pic")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Lana Smith").font(.headline).bold()
                    Text("Karachi, Pakistan")
                }
                Spacer()
                Button(action: {
                    withAnimation(.spring()){
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "xmark").resizable().frame(width: 20, height: 20).foregroundColor(.primary)
                }
                
            }.padding(.horizontal)
            
            VStack(alignment: .leading){
                
                ForEach(menu, id: \.id){ item in
                    Button(action: {
                        self.selectedMenu = item.index
                    }) {
                        HStack{
                            Capsule()
                                .foregroundColor(self.selectedMenu == item.index ? .orange : .clear)
                                .frame(width: 8, height: 25)
                            
                            Text(item.name).font(.system(size: 16)).foregroundColor(self.selectedMenu != item.index ? .primary : Color.primary.opacity(0.6))
                        }.padding(10)
                    }
                }
                
            }.padding(.top, 20)
            Spacer()
        }
    }
}


struct MainView: View{
    
    @Binding var showMenu:Bool
    var body : some View{
        VStack(spacing:0){
            
            ZStack{
                HStack{
                    Button(action: {
                        withAnimation(.spring()){
                            self.showMenu.toggle()
                        }
                    }) {
                        Image("Menu").resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image("menudot").resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.primary)
                    }
                }.padding(.horizontal)
                    .padding(.vertical, 10)
                
                Text("Food").font(.title).bold()
            }
            Home()
            Spacer()
        }.background(Color.white).cornerRadius(showMenu ? 10 : 0).edgesIgnoringSafeArea(.bottom)
    }
}

struct Home: View{
    var body : some View{
        
        ScrollView(.vertical, showsIndicators: false){
            
            ForEach(1 ..< 7, id: \.self){ number in
                Image("p\(number)")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 200)
                    .cornerRadius(20)
            }
            
        }.padding(.top)
    }
}

struct MenuItem:Identifiable{
    var id = UUID()
    var name:String
    var index:Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
