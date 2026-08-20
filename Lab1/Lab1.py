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

    def handle_add_click(self):
        list1 = self.lineEdit_3.text()
        self.listWidget.addItems([list1])
        self.lineEdit_3.clear()
    def handle_validation(self):
        pass
    def disable(self, checked):
        self.lineEdit_4.setEnabled(not checked)
        self.dateEdit_2.setEnabled(not checked)

app = QtWidgets.QApplication(sys.argv)  # Create an instance of QtWidgets.QApplication
window = UI()  # Create an instance of our class
app.exec()  # Start the application
