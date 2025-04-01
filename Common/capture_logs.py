from robot.libraries.BuiltIn import BuiltIn

def get_selenium_browser_log():
    selib = BuiltIn().get_library_instance('SeleniumLibrary')    
    log = selib.driver.get_log('browser')
    log_errors = []
    for entry in log:
        if entry['level']=='SEVERE' and "422" not in entry['message']:
            log_errors.append('Origen: ' + entry['source'] + ' | Mensaje: ' + entry['message'])
    return log_errors