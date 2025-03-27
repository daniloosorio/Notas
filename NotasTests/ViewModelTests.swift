//
//  ViewModelTests.swift
//  NotasTests
//
//  Created by Danilo Osorio on 26/03/25.
//

import Testing
@testable import Notas

@MainActor
final class ViewModelTests {
    var viewModel: ViewModel!
    
    init() {
        self.viewModel = ViewModel()
    }
    
    deinit {
        
    }
    
    @Test
    func testCreateNote() {
        //given
        let title = "test title"
        let text = "test text"
        
        //when
        viewModel.createNoteWith(title: title, text: text)
        
        //then
        #expect(viewModel.notes.count == 1)
        #expect(viewModel.notes.first?.title == title)
        #expect(viewModel.notes.first?.id != nil)
        #expect(viewModel.notes.first?.text == text)
    }
    
    @Test
    func testCreateTreeNotes() {
        //given
        let title1 = "test title 1"
        let text1 = "test text 1"
        
        let title2 = "test title 2"
        let text2 = "test text 2"
        
        let title3 = "test title 3"
        let text3 = "test text 3"
        
        //when
        viewModel.createNoteWith(title: title1, text: text1)
        viewModel.createNoteWith(title: title2, text: text2)
        viewModel.createNoteWith(title: title3, text: text3)
        
        //then
        #expect(viewModel.notes.count == 3)
        #expect(viewModel.notes.first?.title == title1)
        #expect(viewModel.notes.first?.text == text1)
        #expect(viewModel.notes[1].title == title2)
        #expect(viewModel.notes[1].text == text2)
        #expect(viewModel.notes[2].title == title3)
        #expect(viewModel.notes[2].text == text3)
    }
    
}
