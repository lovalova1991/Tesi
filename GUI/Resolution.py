
class ResolutionManager():
    def getResolution(self, resolution):
        width, height = resolution.width(), resolution.height()
        x = None
        y = None

        if width == 1920 and height == 1080:  # 1920x1080
            x = 1900
            y = 1000

        elif width == 1366 and height == 768:  # 1366x768
            x = 1200
            y = 700

        elif width == 2560 and height == 1600:  # 2560x1600
            x = 2500
            y = 1550

        elif width == 1680 and height == 1050:  # 1680x1050
            x = 1650
            y = 900

        elif width == 1440 and height == 900:  # 1440x900
            x = 1400
            y = 850

        elif width == 1024 and height == 768:  # 1024x768 a mio malgrado....
            x = 1000
            y = 750

        elif width == 1280 and height == 800:  # 1280x800
            x = 1200
            y = 850

        elif width == 1280 and height == 720:  #1280x720
            x = 1200
            y = 700

        return x, y
