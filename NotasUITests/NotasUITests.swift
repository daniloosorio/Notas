//
//  NotasUITests.swift
//  NotasUITests
//
//  Created by Danilo Osorio on 9/04/25.
//

import XCTest

final class NotasUITests: XCTestCase {

    func testCreateNote() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCUIApplication().toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Creat Nota"]/*[[".otherElements[\"Creat Nota\"]",".buttons[\"Creat Nota\"].staticTexts[\"Creat Nota\"]",".staticTexts[\"Creat Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let colletionViewsQuery = app.collectionViews
        let tituloField = app.textFields.matching(identifier: "create_note_title").element
       // XCTAssertTrue(tituloField.waitForExistence(timeout: 3), "El campo de título no apareció")
        tituloField.tap()
        tituloField.typeText("NUEVO TEXTO")

        
        
        let textoTextView =  colletionViewsQuery.textFields.matching(identifier: "create_note_text").element
        textoTextView.tap()
        textoTextView.typeText("creando una nueva nota")
        
        app.navigationBars["Crear Nota"].buttons["crear Nota"].tap()
                    
    }
    
    func testCreateTwoNotes() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Creat Nota"]/*[[".otherElements[\"Creat Nota\"]",".buttons[\"Creat Nota\"].staticTexts[\"Creat Nota\"]",".staticTexts[\"Creat Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let colletionViewsQuery = app.collectionViews
        let tituloField = app.textFields.matching(identifier: "create_note_title").element
       // XCTAssertTrue(tituloField.waitForExistence(timeout: 3), "El campo de título no apareció")
        tituloField.tap()
        tituloField.typeText("NUEVO TEXTO")

        
        
        let textoTextView =  colletionViewsQuery.textFields.matching(identifier: "create_note_text").element
        textoTextView.tap()
        textoTextView.typeText("creando una nueva nota")
        
        app.navigationBars["Crear Nota"].buttons["crear Nota"].tap()
        
        //second note
        
        XCUIApplication().toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Creat Nota"]/*[[".otherElements[\"Creat Nota\"]",".buttons[\"Creat Nota\"].staticTexts[\"Creat Nota\"]",".staticTexts[\"Creat Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        

        let tituloField2 = app.textFields.matching(identifier: "create_note_title").element
       // XCTAssertTrue(tituloField.waitForExistence(timeout: 3), "El campo de título no apareció")
        tituloField2.tap()
        tituloField2.typeText("segunda nota")

        
        
        let textoTextView2 =  colletionViewsQuery.textFields.matching(identifier: "create_note_text").element
        textoTextView2.tap()
        textoTextView2.typeText("creando una nueva segunda nota")
        
        app.navigationBars["Crear Nota"].buttons["crear Nota"].tap()
        
    }
    
    func testRemoveNote() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Creat Nota"]/*[[".otherElements[\"Creat Nota\"]",".buttons[\"Creat Nota\"].staticTexts[\"Creat Nota\"]",".staticTexts[\"Creat Nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let colletionViewsQuery = app.collectionViews
        let tituloField = app.textFields.matching(identifier: "create_note_title").element
       // XCTAssertTrue(tituloField.waitForExistence(timeout: 3), "El campo de título no apareció")
        tituloField.tap()
        tituloField.typeText("NUEVO TEXTO")

        
        
        let textoTextView =  colletionViewsQuery.textFields.matching(identifier: "create_note_text").element
        textoTextView.tap()
        textoTextView.typeText("creando una nueva nota")
        
        app.navigationBars["Crear Nota"].buttons["crear Nota"].tap()
        
        let firsNote = colletionViewsQuery.cells.element(boundBy: 0)
        firsNote.tap()
        app.buttons["Eliminar Nota"].tap()
    }
    
}
