//
//  ContentView.swift
//  tic tac toe
//
//  Created by pushkar mondal on 24/12/22.
//.onTapGesture {
/*if issquareoccupied(in: moves, forindex: i) { return}
moves[i] = move(Player: isHumanTurn ? .human : .computer, boardindex: i)
//isHumanTurn.toggle()*/
//

import SwiftUI

struct ContentView: View {
    let columns:[GridItem] = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible()),]
    @State private var moves:[move?] = Array(repeating: nil, count: 9)
//    @State private var isHumanTurn = true
    @State private var isgamedisbled = false
    @State private var alertitem: Alertitem?
    
        var body: some View {
        GeometryReader{ geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 5){
                    ForEach(0..<9){ i in
                        ZStack{
                            Circle()
                                .foregroundColor(.red).opacity(0.5)
                                .frame(width: geometry.size.width/3 - 15,
                                       height: geometry.size.width/3 - 15)
                            Image(systemName:moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40,height: 40)
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                            if issquareoccupied(in: moves, forindex: i) { return}
                            moves[i] = move(Player:.human , boardindex: i)
                            //isHumanTurn.toggle()
//                            isgamedisbled = true
                            
                            if checkwin(for: .human, in: moves){
//                                print("HUMAN WINS")
                                alertitem = alertcontext.humanwin
                                return
                            }
                            
                            if checkcondition(in: moves){
                                alertitem = alertcontext.draw

                                return
                            }
                            isgamedisbled = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.7){
                                let compmove = computerposition(in: moves)
                                moves[compmove] = move(Player: .computer, boardindex: compmove)
                                isgamedisbled = false
                                
                                if checkwin(for: .computer, in: moves){
//                                    print("COMPUTER WINS")
                                    alertitem = alertcontext.computerwin
                                    return
                                }
                                if checkcondition(in: moves){
//                                    print("DRAW")
                                    alertitem = alertcontext.draw
                                    return
                                }
                            }
                        }
                    
                        
                    }
                    
                }
                Spacer()
            }
            .disabled(isgamedisbled)
            .padding()
            .alert(item:$alertitem,content: {alertitem in
                Alert(title: alertitem.title, message: alertitem.massage, dismissButton: .default(alertitem.buttonTitle,action:{resetgame()} ))
            })
            
        }
        
    }
    func issquareoccupied(in moves:[move?], forindex index:Int) -> Bool{
        return moves.contains(where: {$0?.boardindex == index})
    }
    func computerposition(in moves:[move?]) -> Int{
        
        
        let winpattern: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        let compmoves = moves.compactMap { $0 }.filter{ $0.Player == .computer}
        let compPosition = Set(compmoves.map {$0.boardindex})
        
        for pattern in winpattern {
            let winposition = pattern.subtracting(compPosition)
            
            if winposition.count == 1{
                let isavailable = !issquareoccupied(in: moves, forindex: winposition.first!)
                if isavailable { return winposition.first!}
            }
        }
        
        let humanmoves = moves.compactMap { $0 }.filter{ $0.Player == .human}
        let humanPosition = Set(humanmoves.map {$0.boardindex})
        
        for pattern in winpattern {
            let winposition = pattern.subtracting(humanPosition)
            
            if winposition.count == 1{
                let isavailable = !issquareoccupied(in: moves, forindex: winposition.first!)
                if isavailable { return winposition.first!}
            }
        }
        
        if !issquareoccupied(in: moves, forindex: 4){
            return 4
        }
        
        
        var moveposition = Int.random(in: 0..<9)
        while issquareoccupied(in: moves, forindex: moveposition){
             moveposition = Int.random(in: 0..<9)
        }
        return moveposition
    }
    func checkwin(for Player: player, in moves:[move?]) -> Bool{
        let winpattern: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let pmoves = moves.compactMap { $0 }.filter{ $0.Player == Player}
        let playerposition = Set(pmoves.map {$0.boardindex})
        for pattern in winpattern where pattern.isSubset(of: playerposition){
            return true }
        return false
    }
    func checkcondition(in moves: [move?]) -> Bool{
        return moves.compactMap { $0 }.count == 9
    }
    func resetgame(){
        moves = Array(repeating: nil, count: 9)
    }
}
enum player{
    case human,computer
}

struct move{
    let Player:player
    let boardindex: Int
    var indicator: String{
        return Player == .human ? "xmark" : "circle"
    }
     
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
