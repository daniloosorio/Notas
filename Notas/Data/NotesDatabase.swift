//
//  NoteDatabase.swift
//  Notas
//
//  Created by Danilo Osorio on 27/03/25.
//

import Foundation
import SwiftData

final class NotesDatabase : NotesDatabaseProtocol {
    static let shared: NotesDatabase = NotesDatabase()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private  init() {}
    
    @MainActor
    static func setupContainer(inMemory: Bool = false) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self,
                                               configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        }catch {
            print("Error \(error.localizedDescription)")
            fatalError("Database cannot be created")
        }
    }
    
    
    @MainActor func insert(note:Note) throws {
        container.mainContext.insert(note)
        
        do {
            try container.mainContext.save()
        } catch {
            print("error \(error.localizedDescription)")
            throw DatabaseError.errorInsert(error :error.localizedDescription)
        }
    }
    

    
    @MainActor
    func fetchAll()  throws -> [Note] {
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createdAt)])
        
        do {
            return try  container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    
    @MainActor
    func deleteAll() throws {
        do {
            try container.mainContext.delete(model: Note.self)
        }catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }

    
}
