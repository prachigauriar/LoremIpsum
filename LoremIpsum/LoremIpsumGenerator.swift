//
//  LoremIpsumGenerator.swift
//  LoremIpsum
//
//  Created by Prachi Gauriar on 4/25/2018.
//  Copyright © 2018 Prachi Gauriar. All rights reserved.
//

import Cocoa


/// `LoremIpsumGenerator`s generate random sentences and paragraphs of lorem ipsum text.
final class LoremIpsumGenerator : NSObject {
    /// The `Lexicon` type contains all of the generator’s words and sentence templates.
    private struct Lexicon : Codable {
        /// The Latin gibberish words that the generator uses.
        let words: [String]
        
        /// The sentence templates used by the generator to generate sentences. These strings are composed of some
        /// sequence of `«word»` tokens separated by spaces and punctuation.
        let sentenceTemplates: [String]
        
        /// The token used to denote a word in a sentence template.
        static let templateWordToken = "«word»"
        
        /// Returns the shared lexicon, which is loaded from Lexicon.plist in the main bundle.
        static let `default`: Lexicon = {
            guard let url = Bundle.main.url(forResource: "Lexicon", withExtension: "plist") else {
                fatalError("Could not open Lexicon.plist")
            }
            
            do {
                return try PropertyListDecoder().decode(Lexicon.self, from: try Data(contentsOf: url))
            } catch {
                fatalError("Failed to load lexicon: \(error)")
            }
        }()
    }

    
    /// Generates a random lorem ipsum sentence.
    ///
    /// - Returns: A lorem ipsum sentence.
    func generateSentence() -> String {
        var sentence = Lexicon.default.sentenceTemplates.randomElement()
     
        var range = sentence.range(of: Lexicon.templateWordToken)
        var isFirstWord = true
        while range != nil {
            let word = Lexicon.default.words.randomElement()
            sentence.replaceSubrange(range!, with: isFirstWord ? word.localizedCapitalized : word)
            isFirstWord = false
            range = sentence.range(of: Lexicon.templateWordToken)
        }
        
        return sentence
    }
    
    
    /// Generates a random lorem ipsum paragraph containing between 3 and 10 sentences.
    ///
    /// - Returns: A lorem ipsum paragraph.
    func generateParagraph() -> String {
        let sentenceCount = 3 + Int(arc4random_uniform(7))
        return (0 ..< sentenceCount).map { _ in generateSentence() }.joined(separator: "")
    }
    
    
    // MARK: - Service Menu messages
    
    /// Generates a random lorem ipsum sentence and places it on `pasteboard`.
    ///
    /// - Parameters:
    ///   - pasteboard: The pasteboard on which to place the generated sentence.
    ///   - userData: Ignored.
    /// - Throws: Does not throw.
    @objc func generateSentence(_ pasteboard: NSPasteboard, userData: String) throws {
        pasteboard.clearContents()
        pasteboard.setString(generateSentence(), forType: .string)
    }
    
    
    /// Generates a random lorem ipsum paragraph and places it on `pasteboard`.
    ///
    /// - Parameters:
    ///   - pasteboard: The pasteboard on which to place the generated paragraph.
    ///   - userData: Ignored.
    /// - Throws: Does not throw.
    @objc func generateParagraph(_ pasteboard: NSPasteboard, userData: String) throws {
        pasteboard.clearContents()
        pasteboard.setString(generateParagraph(), forType: .string)
    }
}


// MARK: -

private extension Collection {
    /// Returns a random element in the collection.
    /// - Warning: Fails with a precondition failure if the collection is empty.
    /// - Returns: A random element in collection
    func randomElement() -> Element {
        precondition(!isEmpty, "Collection may not be empty")
        let randomOffset = Int(arc4random_uniform(UInt32(count)))
        let randomIndex = index(startIndex, offsetBy: randomOffset)
        return self[randomIndex]
    }
}
