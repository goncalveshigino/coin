//
//  ContentView.swift
//  Coins
//
//  Created by Goncalves Higino on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CoinsViewModel()
    @Environment(\.presentationMode) var PresentationMode
    @State private var selectedCoin: Coin?
    @State private var showAlert = false


    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                     CoinRowView(coin: coin)
                        .onAppear {
                            if coin.id == viewModel.coins.last?.id {
                                viewModel.loadData()                            }
                        }
                }
            }
            .refreshable {
                viewModel.handRefresh()
            }
            .onReceive(viewModel.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? "")
                )
            })
            .navigationTitle("Live Prices")
        }
    }
}

//Button {
//    selectedCoin = coin
//} label: {
//    
// 
//}
//.sheet(item: $selectedCoin) { icon in
//    CoinDetailsView()

struct CoinRowView: View {
    let coin: Coin
    
    var body: some View {
        HStack(spacing: 12) {
            
            Text("\(coin.marketCapRank)")
            
            AsyncImage(url: URL(string: coin.image)) { image in
                      image
                          .resizable()
                          .scaledToFit()
                          .aspectRatio(contentMode: .fill)
                  } placeholder: {
                      Image(systemName: "photo.fill")
                  }.frame(width: 50, height: 50)
          

            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .fontWeight(.semibold)
                
                Text(coin.symbol.uppercased())
            }
            .padding(.leading,2)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(coin.currentPrice, format: .currency(code: "USD"))
                    .font(.subheadline)
            }
        }
        .font(.footnote)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
