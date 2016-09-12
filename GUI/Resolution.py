from PyQt5.uic.properties import QtCore


class ResolutionManager():
    def getResolution(self, resolution):
        width, height = resolution.width(), resolution.height()
        x = None
        y = None

        if width == 1920 and height == 1080:  # 1920x1080
            x = 1250
            y = 960

        elif width == 1366 and height == 768:  # 1366x768
            x = 1800
            y = 900

        elif width == 2560 and height == 1600:  # 2560x1600
            x = 1800
            y = 900

        elif width == 1680 and height == 1050:  # 1680x1050
            x = 1800
            y = 900

        elif width == 1440 and height == 900:  # 1440x900
            x = 1280
            y = 800

        elif width == 1024 and height == 768:  # 1024x768 a mio malgrado....
            x = 1024
            y = 768

        elif width == 1280 and height == 800:  # 1280x800
            x = 1800
            y = 900

        return x, y
