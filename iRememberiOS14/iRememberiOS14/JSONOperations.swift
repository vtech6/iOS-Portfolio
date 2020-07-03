//
//  JSONOperations.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 01/07/2020.
//
import Foundation
import SwiftUI

let json = """
[
    {
        "question": "Question1",
        "answer": "Answer1"
    },
    {
        "question": "Question2",
        "answer": "Answer2"
    }
]
""".data(using: .utf8)!

struct FlashcardCodable: Codable {
    var question: String
    var answer: String
}

let decoder = JSONDecoder()
let jsonDecoded = try? decoder.decode([FlashcardCodable].self, from: json)


func printStuff()->[String]{
    var stringArray: [String] = []
    for item in jsonDecoded! {
        stringArray.append(item.question)
}
    return stringArray

}

struct JSONOperations: View {
    @State var decodedJSONStringArray:[String] = [""]
    var body: some View {
        VStack{
            
            Button(action:{decodedJSONStringArray=printStuff()}){Text("The String:\(decodedJSONStringArray[0])")}
        }
    }
}
struct JSONOperations_Previews: PreviewProvider {
    static var previews: some View {
        JSONOperations()
    }
}
