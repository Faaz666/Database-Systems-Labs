import sys
from PyQt6.QtWidgets import (
    QApplication,
    QLabel,
    QLineEdit,
    QMainWindow,
    QVBoxLayout,
    QWidget,
)
from PyQt6 import (
    QtWidgets,
    uic,
    QtGui,
    QtCore
)


class UI(QtWidgets.QMainWindow):
    def __init__(self):
        super(UI, self).__init__()
        uic.loadUi('Lab1/Lab1.ui', self)
        self.show()
        self.setWindowTitle("Library Management System")
        self.pushButton.clicked.connect(self.handle_add_click)
        self.buttonBox.accepted.connect(self.handle_validation)
        self.buttonBox.rejected.connect(self.close)
        self.checkBox.toggled.connect(self.disable)
        name = self.lineEdit.text()
        isbn = self.lineEdit_2.text()
        date = self.dateEdit.date().toString(self.dateEdit.displayFormat())
        self.comboBox.addItems(["Database Systems", "OOP", "Artificial Intelligence"])
        self.comboBox.currentTextChanged.connect(self.handle_update_comboBox)

    def handle_add_click(self):
        list1 = self.lineEdit_3.text()
        self.listWidget.addItems([list1])
        self.lineEdit_3.clear()
    def handle_validation(self):
        pass
    def disable(self):
        self.lineEdit_4.setEnabled(False)
        self.dateEdit_2.setEnabled(False)
    def handle_update_comboBox(self, data):
        self.comboBox_2.clear()
        if data == "Database Systems":
            self.comboBox_2.addItems(["ERD", "SQL", "OLAP", "Data Mining"])
        elif data == "OOP":
            ["C++", "Java"]
        elif data == "Artificial Intelligence":
            ["Machine Learning", "Robotics", "Machine Learning"]


app = QtWidgets.QApplication(sys.argv)  # Create an instance of QtWidgets.QApplication
window = UI()  # Create an instance of our class
app.exec()  # Start the application
