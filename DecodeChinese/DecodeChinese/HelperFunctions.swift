//
//  ParseJSON.swift
//  DecodeChinese
//
//  Created by Mikolaj Witkowski on 03/09/2020.
//
import SwiftUI
import Foundation
import AVFoundation

//Two functions that allow me to download and unwrap the JSON

public func loadJson(fromURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
    if let url = URL(string: urlString) {
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        urlSession.resume()
    }
}

func parse(jsonData: Data) -> [Word] {
    var words: [Word] = []
    do {
        let decodedData = try JSONDecoder().decode(JSONFile.self, from: jsonData)
        print("Fetching JSON: Success")
        words = decodedData.words
    } catch {
        print("Fetching JSON: Decoding Error")
    }
    return words
}

//This function takes in the character.pinyin_tone and returns a color accordingly

func fetchColor(num: Int) -> Color{
    switch num{
    case 1:
        return Color("firstTone")
    case 2:
        return Color("secondTone")
    case 3:
        return Color("thirdTone")
    case 4:
        return Color("fourthTone")
    case 5:
        return Color("fifthTone")
    default:
        return Color(.black)
    }
    
}

//This function plays the sound of chosen string (although I did not use it, because I found an easier way to play sounds in SwiftUI

func playSound(pathString: String, audioPlayer: AVAudioPlayer) {
    var soundEffect = audioPlayer
    let path = Bundle.main.path(forResource: pathString, ofType:nil)!
    let url = URL(fileURLWithPath: path)

    do {
        soundEffect = try AVAudioPlayer(contentsOf: url)
        soundEffect.play()
    } catch {
        print("SoundEffect: Audio File Missing.")
    }
}

//This function generates haptic feedback when called

func generateHapticFeedback(){
    let impactMed = UIImpactFeedbackGenerator(style: .light)
    impactMed.impactOccurred()
}

//The JSON location and screen frame constants

let urlString = "https://decodechinese.com/assignment_1/word_list.json"
let screen = UIScreen.main.bounds

