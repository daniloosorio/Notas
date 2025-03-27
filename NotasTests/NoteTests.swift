//
//  NotasTests.swift
//  NotasTests
//
//  Created by Danilo Osorio on 26/03/25.
//

import Testing
import Foundation
@testable import Notas

struct NoteTests {
    @Test func testNoteInitialization() {
        //given or arrange
        let title = "Test Title"
        let text = "Test Text"
        let date = Date()
        // when or act
        let note = Note(title: title, text: text, createdAt: date)
        
        //then or assert
        #expect(note.title == title)
        #expect(note.id != nil)
        #expect(note.createdAt == date)
        #expect(note.text == text)
        
    }
    
    @Test func testNoteEmptyText(){
        //Given
        let title = "Test Title"
        let date = Date()
        
        // When
        let note =  Note(title: title, text: nil, createdAt: date)
        
        //then
        #expect(note.getText.isEmpty)
        
    }

}
