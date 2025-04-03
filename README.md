# Robot Framework Automation Project

## Overview
This project is an automation framework built using [Robot Framework](https://robotframework.org/), a generic open-source automation framework for acceptance testing and robotic process automation (RPA).

## Features
- Keyword-driven testing
- Easy-to-read test cases
- Integration with Selenium/WebDriver for web automation
- Support for API testing
- Extensible with custom libraries

## Prerequisites
Ensure you have the following installed:
- Python (>= 3.7)
- Robot Framework
- SeleniumLibrary (for web testing)
- Pabot (for run tests in parallel)

### Installation
1. Install Python: [Download Python](https://www.python.org/downloads/)
2. Install Robot Framework:
   ```sh
   pip install robotframework
   ```
3. Install Selenium:
   ```sh
   pip install robotframework-seleniumlibrary
   ```
4. Install webdriver-manager:
   ```sh
   pip install webdriver-manager
   ```
5. Install additional dependencies if needed:
   ```sh
   pip install robotframework-pabot
   ```

## Project Structure
```
project-root/
│-- Tests/                 # Test case files (.robot)
|-- PageObjects/           # Objects locators stored as variables
│-- Common/                # Reusable keywords and variables
│-- Results/               # Test output files
│-- README.md              # Project documentation
```

## Running Tests
To execute test cases, use the following command:
```sh
robot -d Results Tests/
```

For running a specific test suite:
```sh
robot -d Results Tests/Inventory.robot
```

For running tests with a specific tag:
```sh
robot -d Results -i <tag> Tests/
```

## Test Reports
After execution, Robot Framework generates:
- `log.html` - Detailed execution log
- `report.html` - Test execution summary
- `output.xml` - XML test results

## Contact
For questions or support, contact [francojalignier@gmail.com](francojalignier@gmail.com).

