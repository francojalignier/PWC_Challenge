from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.opera import OperaDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager

def install_all_drivers():
    ChromeDriverManager().install()
    #GeckoDriverManager().install()
    EdgeChromiumDriverManager().install()
