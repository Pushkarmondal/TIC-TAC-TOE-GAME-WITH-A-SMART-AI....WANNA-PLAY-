//
//  Alert.swift
//  tic tac toe
//
//  Created by pushkar mondal on 25/12/22.
//

//import Foundation
import SwiftUI

struct Alertitem: Identifiable{
    let id = UUID()
    var title: Text
    var massage: Text
    var buttonTitle: Text
}
struct alertcontext{
   static let humanwin = Alertitem(title: Text("YOU WIN!"), massage: Text("YOU BEAT AI!"), buttonTitle: Text("YAH!"))
    
   static let computerwin = Alertitem(title: Text("YOU LOSE!"), massage: Text("BEST AI!"), buttonTitle: Text("REMATCH!"))
    
   static let draw = Alertitem(title: Text("DRAW!"), massage: Text("WHAT A BATTLE!"), buttonTitle: Text("TRY AGAIN!"))
    
}
