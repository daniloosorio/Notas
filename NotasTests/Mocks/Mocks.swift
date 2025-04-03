//
//  Mocks.swift
//  NotasTests
//
//  Created by Danilo Osorio on 2/04/25.
//

import Foundation
@testable import Notas

// 1. Mock mutable correctamente implementado
final class CreateNoteUseCaseMock: CreateNoteProtocol {
    var MockDatabase: [Note] = []
    
    func createNoteWith(title: String, text: String) throws {
        let note = Note(title: title, text: text, createdAt: .now)
        MockDatabase.append(note)
    }
    
}

// 2. Mock para fetch que comparte el mismo storage
final class FetchAllNotesUseCaseMock: FetchAllNotesProtocol {
    private let noteCreator: CreateNoteUseCaseMock
    
    init(noteCreator: CreateNoteUseCaseMock) {
        self.noteCreator = noteCreator
    }
    
    func FetchAllNote() throws -> [Note] {
        return noteCreator.MockDatabase
    }
}
// 3. update note
final class UpdateNoteUseCaseMock: UpdateNoteProtocol {
    private let noteCreator: CreateNoteUseCaseMock
    
    init(noteCreator: CreateNoteUseCaseMock) {
        self.noteCreator = noteCreator
    }
    
    func updateNoteWith(identifier: UUID, title: String, text: String) async throws {
        if let index = self.noteCreator.MockDatabase.firstIndex(where: {$0.identifier == identifier}){
            self.noteCreator.MockDatabase[index].title = title
            self.noteCreator.MockDatabase[index].text = text
        }
    }
}
// 4. remove note
final class RemoveNoteUseCaseMock: RemoveNoteProtocol {
    
    
    private let noteCreator: CreateNoteUseCaseMock
    
    init(noteCreator: CreateNoteUseCaseMock) {
        self.noteCreator = noteCreator
    }
    
    func removeNoteWith(identifier: UUID) throws {
        if let index = self.noteCreator.MockDatabase.firstIndex(where: {$0.identifier == identifier}){
            self.noteCreator.MockDatabase.remove(at: index)
        }
    }
}
