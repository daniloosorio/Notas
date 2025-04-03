//
//  ViewModelIntegrationTest.swift
//  NotasTests
//
//  Created by Danilo Osorio on 31/03/25.
//

import Testing
@testable import Notas

@MainActor
final class ViewModelIntegrationTest {
    var sut: ViewModel!
    let database = NotesDatabase.shared

    init() {
        database.container = NotesDatabase.setupContainer(inMemory: true)
    }

    func setupTest() {
        database.container = NotesDatabase.setupContainer(inMemory: true)
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        sut = ViewModel(createNoteUseCase: createNoteUseCase, fetchAllNotesUseCase: fetchAllNotesUseCase)
    }

    @Test
    func testCreateNote() {
        setupTest() // Llamada a setupTest antes de cada test
        // Given
        sut.createNoteWith(title: "helo integration", text: "test view model")

        // When
        let note = sut.notes.first

        // Then
        #expect(note != nil)
        #expect(note?.title == "helo integration")
        #expect(note?.text == "test view model")
        #expect(sut.notes.count == 1)
    }

    @Test
    func testCreateTwoNotes() {
        setupTest() // Llamada a setupTest antes de cada test
        // Given
        sut.createNoteWith(title: "helo integration", text: "test view model")
        sut.createNoteWith(title: "helo2 integration", text: "test view model2")

        // When
        let note = sut.notes.first
        let lastNote = sut.notes.last

        // Then
        #expect(note != nil)
        #expect(note?.title == "helo integration")
        #expect(note?.text == "test view model")
        #expect(lastNote?.title == "helo2 integration")
        #expect(lastNote?.text == "test view model2")
        #expect(sut.notes.count == 2)
    }

    
    @Test("obtener todas las notas")
    func testFetchAllNotes() {
        setupTest()
        //Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        //when
        let firstNote = sut.notes[0]
        let lastNote = sut.notes[1]
        // Then
        #expect(sut.notes.count == 2,"no hay dos objetos")
        #expect(firstNote.title == "Hello 1")
        #expect(firstNote.text == "text 1")
        #expect(lastNote.title == "Hello 2")
        #expect(lastNote.text == "text 2")
    }
    
    @Test
    func testUpdateNote() async{
        setupTest()
        //given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        
        //then
        guard let note = sut.notes.first else {
            #expect(Bool(false),"no hay un objeto")
            return
        }
        
        //When
        await sut.updateNoteWith(identifier: note.identifier, newTitle: "nuevo titulo", newText: "nuevo texto")
        sut.fetchAllNotes()
        
        //Then
        #expect(sut.notes.count == 1, "deberua haber una nota")
        #expect(sut.notes[0].title == "nuevo titulo", "el titulo no se actualizo")
        #expect(sut.notes[0].text == "nuevo texto", "el texto no se actualizo")
        
    }
    
    @Test
    func testRemoveNote(){
        setupTest()
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        sut.createNoteWith(title: "Hello 3", text: "text 3")
        
        guard let note = sut.notes.last else {
            #expect(Bool(false),"lista vacia")
            return
        }
        
        sut.removeNoteWith(identifier: note.identifier)
        #expect(sut.notes.count == 2,"no se borro la nota")
        
    }
}
