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
    func update(identifier:UUID, title:String,text:String?) async throws {
        let notePredicate = #Predicate<Note>{
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            updateNote.title = title
            updateNote.text = text
            try container.mainContext.save()
        }catch{
            print("Error actualizando informacion")
            throw DatabaseError.errorUpdate
        }
    }
    
    @MainActor
    func remove(identifier:UUID) throws {
        let notePredicate = #Predicate<Note>{
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            container.mainContext.delete(deleteNote)
            try container.mainContext.save()
        }catch{
            print("Error actualizando informacion")
            throw DatabaseError.errorUpdate
        }
    }
}
