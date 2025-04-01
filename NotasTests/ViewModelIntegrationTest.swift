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
}
