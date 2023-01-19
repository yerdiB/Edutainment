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
    @State private var correctOrNot = [""]
    @State private var checked = false
    @State private var score = 0
    
    var body: some View{
        NavigationView{
            ZStack{
                LinearGradient(colors: [.yellow, .black], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    if gameIsOn{
                        gameView
                    }else{
                        preGameView
                    }
                }
                .navigationTitle("Edutainment")
                .foregroundColor(.black)
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
    }
    func checkAnswers(){
        for i in 0..<(questionAmount) {
            if numbers[2 * i] * numbers[2 * i + 1] == answers[i]{
                correctOrNot.append("Correct")
                score += 1
            }else{
                correctOrNot.append("Wrong, answer is \(numbers[2 * i] * numbers[2 * i + 1])")
            }
        }
        checked.toggle()
    }
}

extension ContentView {
    private var gameView: some View{
        VStack{
            List{
                ForEach(0 ..< questionAmount){i in
                    HStack {
                        Text("\(numbers[2 * i])  x  \(numbers[2 * i + 1])  =")
                        TextField("Your answer", value: $answers[i], format: .number)
                            .keyboardType(.numberPad)
                    }
                }
                HStack{
                    Spacer()
                    Button("Check", action: checkAnswers)
                        .font(.headline)
                        .foregroundColor(.black)
                        .buttonStyle(.borderedProminent)
                        .tint(.yellow)
                    Spacer()
                }
            }
            .scrollContentBackground(.hidden)
            .padding([.top, .bottom], 50)
            HStack{
                Spacer()
                Button("Try Again", action: again)
                    .font(.headline)
                    .foregroundColor(.black)
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                Spacer()
            }
        }
        .alert("Your score is \(score)", isPresented: $checked){
            Button("OK"){}
        }
    }
    private var preGameView: some View{
        VStack{
            List{
                Group{
                    HStack{
                        Picker("Table range between", selection: $range[0]) {
                                ForEach(2 ..< 13) {
                                    Text("\($0)")
                                }
                            }
                        Picker(" and ", selection: $range[1]) {
                                ForEach(2 ..< 13) {
                                    Text("\($0)")
                                }
                            }
                        .frame(width: 110)
                    }
                    Picker("Question amount", selection: $questionAmount) {
                        ForEach(questionAmounts, id: \.self){
                            Text("\($0)")
                        }
                    }
                }

            }
            .scrollContentBackground(.hidden)
            .padding([.top, .bottom], 50)
            HStack{
                Spacer()
                Button("Start Game", action: startGame)
                    .font(.headline)
                    .foregroundColor(.black)
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
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
