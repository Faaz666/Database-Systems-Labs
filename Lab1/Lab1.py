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
from PyQt6.QtCore import QDate


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
        self.comboBox.currentTextChanged.connect(self.handle_update_comboBox)
        self.comboBox.addItems(["Database Systems", "OOP", "Artificial Intelligence"])

    def handle_add_click(self):
        list1 = self.lineEdit_3.text()
        if list1 != "":
            self.listWidget.addItems([list1])
            self.lineEdit_3.clear()
    def handle_validation(self):
        wrong = []
        isbn = self.lineEdit_2.text()
        buy = self.dateEdit.date()
        aj = QDate.currentDate()
        n = self.listWidget.count()
        if len(isbn) > 12 or buy >= aj:
            wrong.append("The Length of ISBN is greater than 12 or Purchased On Date is greater than today")
        if self.radioButton_3.isChecked():
            if n > 0:
                wrong.append("Book of Journal Type should have no authors.")
        else:
            if n == 0:
                wrong.append("Reference books or Text book should have at least one author.")
        if self.checkBox.isChecked():
            kis = self.lineEdit_4.text()
            kab = self.dateEdit_2.date()
            if kis == "" or not (buy < kab < aj):
                wrong.append("Issued to is empty or Issued Date is not between Purchased On and Today's Date.")
        if wrong == []:
            self.msg("Book added successfully!")
        else:
            for i in wrong:
                self.msg(i)
    def msg(self, t):
        b = QtWidgets.QMessageBox(self)
        b.setWindowTitle("Message Box")
        b.setText(t)
        b.setIcon(QtWidgets.QMessageBox.Icon.Information)
        b.exec()
    def disable(self, checked):
        self.lineEdit_4.setEnabled(checked)
        self.dateEdit_2.setEnabled(checked)
    def handle_update_comboBox(self, data):
        self.comboBox_2.clear()
        if data == "Database Systems":
            self.comboBox_2.addItems(["ERD", "SQL", "OLAP", "Data Mining"])
        elif data == "OOP":
            self.comboBox_2.addItems(["C++", "Java"])
        elif data == "Artificial Intelligence":
            self.comboBox_2.addItems(["Machine Learning", "Robotics", "Computer Vision"])


app = QtWidgets.QApplication(sys.argv)  # Create an instance of QtWidgets.QApplication
window = UI()  # Create an instance of our class
app.exec()  # Start the application