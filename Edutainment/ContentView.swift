//
//  ContentView.swift
//  Edutainment
//
//  Created by Yerdaulet Ismanaliyev on 16.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var gameIsOn = false
    @State private var range = [0, 10]
    @State private var questionAmount = 10
    @State private var questionAmounts = [5,10,15]
    @State private var numbers = [Int]()
    @State private var answers = [Int]()
    @State private var correctOrNot = ["","","","","","","","","","","","","","","",""]
    @State private var checked = false
    @State private var alerted = false
    @State private var score = 0
    
    var body: some View{
        NavigationView{
            ZStack{
                LinearGradient(colors: [.purple, .black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    Text("Edutainment")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    if gameIsOn{
                        gameView
                    }else{
                        preGameView
                    }
                }
            }
        }
    }
    
    func startGame() {
        range[0] += 2
        range[1] += 2
        for _ in 0..<(questionAmount * 2) {
            numbers.append(Int.random(in: range[0] ... range[1]))
        }
        for _ in 0..<questionAmount {
            answers.append(0)
        }
        gameIsOn.toggle()
        score = 0
    }
    func again() {
        range[0] = 0
        range[1] = 10
        gameIsOn.toggle()
        checked = false
    }
    func checkAnswers(){
        score = 0
        for i in 0..<(questionAmount) {
            if numbers[2 * i] * numbers[2 * i + 1] == answers[i]{
                correctOrNot[i] = "Correct answer, Yaay!!!"
            }else{
                correctOrNot[i] = "Wrong, answer is \(numbers[2 * i] * numbers[2 * i + 1])"
            }
        }
        for i in 0..<(questionAmount) {
            if correctOrNot[i] == "Correct"{
                score += 1
            }
        }
        checked = true
        alerted.toggle()
    }
}

extension ContentView {
    //Game View that will be shown when game is started
    private var gameView: some View{
        VStack{
            List{
                ForEach(0 ..< questionAmount){i in
                    HStack {
                        Text("\(numbers[2 * i])  x  \(numbers[2 * i + 1])  =")
                            .bold()
                        TextField("answer", value: $answers[i], format: .number)
                            .keyboardType(.numberPad)
                            .bold()
                            .frame(width: 50)
                        if checked {
                            Text(correctOrNot[i])
                                .bold()
                                .foregroundColor(correctOrNot[i] == "Correct answer, Yaay!!!" ? .green : .red)
                        }
                    }
                }
                .listRowBackground(opacity(0))

            }
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
            Spacer()
            HStack{
                Spacer()
                Button("Try again", action: again)
                    .font(.headline)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                Spacer()
                Button("Check", action: checkAnswers)
                    .font(.headline)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                Spacer()
            }
        }
        /*
        .alert(score > 5 ? "Your got \(score) correct. Good job!!!" : "You got \(score) correct. Try again, you can do better!", isPresented: $alerted){
            Button("OK"){}
        }*/
    }
    //PreGame View that will be shown first until player starts the game
    private var preGameView: some View{
        VStack{
            List{
                Group{
                    VStack{
                        Text("Choose multiplication table to train between")
                        Picker("Choose multiplication table to train", selection: $range[0]) {
                                ForEach(2 ..< 13) {
                                    Text("\($0)")
                                }
                            }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                        Text("and")
                        Picker(" and ", selection: $range[1]) {
                                ForEach(2 ..< 13) {
                                    Text("\($0)")
                                }
                            }
                        .pickerStyle(.segmented)
                    }
                    VStack{
                        Text("Choose question amount you'll solve")
                        Picker("Choose question amount you'll solve", selection: $questionAmount) {
                            ForEach(questionAmounts, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                        
                    }
                }
                .listRowBackground(opacity(0))

            }
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
            .font(.title3)
            .bold()
            Spacer()
            HStack{
                Spacer()
                Button("Start Game", action: startGame)
                    .font(.headline)
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
