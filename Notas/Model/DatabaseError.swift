//
//  DatabaseError.swift
//  Notas
//
//  Created by Danilo Osorio on 27/03/25.
//

import Foundation

enum DatabaseError: Error, Equatable {
    case errorInsert(error: String)
    case errorFetch
    case errorUpdate
    case errorRemove
}
