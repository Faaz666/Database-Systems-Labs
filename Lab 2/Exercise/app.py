from PyQt6 import QtWidgets, uic
from PyQt6.QtCore import Qt
from PyQt6.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget, QPushButton, QComboBox, QLabel, QTableWidgetItem, QTableWidget, QHBoxLayout
from PyQt6.QtWidgets import QTableWidget, QTableWidgetItem

import sys

books = [
["0201144719 9780201144710","An introduction to database systems","Database","Reference Book","True"],
["0805301453 9780805301458","Fundamentals of database systems","Database","Reference Book","False"],
["1571690867 9781571690869","Object oriented programming in Java","OOP","Text Book","False"],
["1842652478 9781842652473","Object oriented programming using C++","OOP","Text Book","False"],
["0070522618 9780070522619","Artificial intelligence","AI","Journal","False"],
["0865760047 9780865760042","The Handbook of artificial intelligence","AI","Journal","False"],
]

category=["Database","OOP","AI"]
class UI(QtWidgets.QMainWindow):
    def __init__(self):
        # Call the inherited classes __init__ method
        super(UI, self).__init__() 
        # Load the .ui file
        uic.loadUi('Lab02.ui', self) 
        self.booksTableWidget.setRowCount(len(books))
        for i in range(len(books)):
            for j in range(5):
                item = QtWidgets.QTableWidgetItem(books[i][j])
                # Make the items non-editable
                item.setFlags(Qt.ItemFlag.ItemIsEnabled | Qt.ItemFlag.ItemIsSelectable) 
                self.booksTableWidget.setItem(i,j,item)
                
                
        # Populate the comboBox 
        ...
        self.comboBox.addItems(["Database", "OOP", "AI"])
        # Set current selection of comboBox to None
        self.comboBox.setCurrentIndex(-1) 
        
        # Connect the search function with the search button.
        ...
        self.pushButton.clicked.connect(self.search)
        # Connect the view function with the view button.
        ...
        self.pushButton_2.clicked.connect(self.view)
        # Connect the delete function with the delete button.
        ...
        self.pushButton_3.clicked.connect(self.delete)

        # Connect the close function with the close button.
        ...
        self.pushButton_4.clicked.connect(self.close)

    def search(self):
        """
        Function to search and filter the booksTableWidget 
        based on user input from comboBox, lineEdit, radioButtons, and checkBox.
        """

        # Get user input
        selected_combo = self.comboBox.currentText()
        selected_title = self.lineEdit.text()
        sel_radio_4 = self.radioButton_4.isChecked()
        sel_radio_5 = self.radioButton_5.isChecked()
        sel_radio_6 = self.radioButton_6.isChecked()
        issued = self.checkBox.isChecked()

        # Go through each row in the table
        for row in range(self.booksTableWidget.rowCount()):
            # Get values from the current row
            combo_compare = self.booksTableWidget.item(row, 2)
            title_compare = self.booksTableWidget.item(row, 1)
            radio_compare = self.booksTableWidget.item(row, 3)
            issued_compare = self.booksTableWidget.item(row, 4)

            # Check if the user input and row data matches
            combo_match = selected_combo in {"", combo_compare.text()}  
            title_match = selected_title.lower() in title_compare.text().lower() if selected_title else True if selected_title == "" else False
            issued_match = (issued and issued_compare.text() == "True") or (not issued and issued_compare.text() == "False")
            
            radio_match = False
            # Implement radio_match conditions below
            if sel_radio_4 and radio_compare.text() == "Reference Book":
                radio_match = True
            elif sel_radio_5 and radio_compare.text() == "Text Book":
                radio_match = True
            elif sel_radio_6 and radio_compare.text() == "Journal":
                radio_match = True

            # Show row if all conditions are satisfied, otherwise hide it
            match = combo_match and title_match and radio_match and issued_match
            self.booksTableWidget.setRowHidden(row, not match)

        pass
    
    def view(self):
        # Get the currently selected row
        curr_row = self.booksTableWidget.currentRow()

        if curr_row >= 0:
            # Extract values from the selected row
            isbn = self.booksTableWidget.item(curr_row,0).text()   
            title = self.booksTableWidget.item(curr_row,1).text()  
            cat = self.booksTableWidget.item(curr_row,2).text()
            rad = self.booksTableWidget.item(curr_row,3).text()    
            issue = self.booksTableWidget.item(curr_row,4).text()

            # Create and show the detailed view window
            self.view = ViewBook(isbn, title, cat, rad, issue)
            self.view.show()

            # Reset current selection
            self.booksTableWidget.setCurrentItem(None)
        else:
            # Show a warning if no row is selected
            if self.booksTableWidget.currentRow() == -1:
                QtWidgets.QMessageBox.warning(self, "Warning", "No Row Selected.")
        pass
        
    def delete(self):
        # Get the currently selected row
        row_delete = self.booksTableWidget.currentRow()

        if row_delete >= 0:
            # Ask for confirmation before deleting
            confirmation = QtWidgets.QMessageBox.warning(
                self, "Confirmation Box", "Are you sure you want to delete this book?",
                QtWidgets.QMessageBox.StandardButton.Yes | QtWidgets.QMessageBox.StandardButton.No
            )

            # If user confirms, delete the row and set current item to None
            if confirmation == QtWidgets.QMessageBox.StandardButton.Yes:
                books.pop(row_delete)
                self.booksTableWidget.removeRow(row_delete)
                self.booksTableWidget.setCurrentItem(None)
            elif confirmation == QtWidgets.QMessageBox.StandardButton.No:
                pass
        else:
            # Show warning if no row is selected
            QtWidgets.QMessageBox.warning(self, "Warning", "No Row Selected.")
        pass
    
    def close(self):
        # Close the form
        QtWidgets.QMainWindow.close(self)
        pass
            
 
class ViewBook(QtWidgets.QMainWindow):
    def __init__(self, isbn, title, cat, rad, issue):
        super(ViewBook, self).__init__()
        # Load the UI file
        uic.loadUi('view.ui', self)

        # Disable inputs (make them read-only)
        self.lineEdit.setReadOnly(True)
        self.lineEdit_2.setReadOnly(True)
        self.lineEdit_3.setReadOnly(True)
        self.radioButton_4.setEnabled(False)
        self.radioButton_5.setEnabled(False)
        self.radioButton_6.setEnabled(False)
        self.checkBox.setEnabled(False)

        # Set values in fields
        self.lineEdit.setText(isbn)
        self.lineEdit_2.setText(title)
        self.lineEdit_3.setText(cat)

        # Select the correct radio button
        if rad == "Reference Book":
            self.radioButton_4.setChecked(True)
        elif rad == "Text Book":
            self.radioButton_5.setChecked(True)
        elif rad == "Journal":
            self.radioButton_6.setChecked(True)

        # Set checkbox if issued
        if issue == "True":
            self.checkBox.setChecked(True)

        
if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = UI()
    window.show()
    sys.exit(app.exec())
