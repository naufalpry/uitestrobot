*** Settings ***
Library     Selenium2Library
Library     XvfbRobot

*** Variables ***
${TMP_PATH}                 /tmp
${SLEEP}            5s
${Delay}            1s  
*** Test Cases ***
Fresh.Efishery.com
    Start Virtual Display    1920    1080
    Open Chrome Browser
    GoTo    http://fresh.efishery.com
    Pilih Kota
    Pastikan Banner
    Pastikan Catalog Options Link Sesuai dengan Judul
    Blibli

*** Keywords ***
Open Chrome Browser
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method  ${options}  add_argument  --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}
    SLEEP	${SLEEP}
Pilih Kota
   Click element       //div[@id='root']
   Sleep               ${Delay}
   Scroll Element Into View    //div[@class='header']
   Sleep               ${Delay}
   Click element       //div[@class='dropdown-value']//span[@class='f-16 f-bold']
   Sleep               ${Delay}
   Click element       //*[@id="root"]/div/div[1]/div[2]/div[1]/div[2]/div[1]
   Sleep               ${Delay}

Pastikan Banner
    ${url_banner}=    Get Element Attribute    //div[@class='carousel-inner']//div[1]//img    src
    Should Be Equal     ${url_banner}           https://public-tools.s3.amazonaws.com/efishery_drive/banner_fresh
    ${url_banner}=    Get Element Attribute    //div[@class='carousel-inner']//div[2]//img    src
    Should Be Equal     ${url_banner}           https://public-tools.s3.ap-southeast-1.amazonaws.com/efishery_drive/banner_wa
    ${url_banner}=    Get Element Attribute    //div[@class='carousel-inner']//div[3]//img    src
    Should Be Equal     ${url_banner}           https://public-tools.s3.amazonaws.com/efishery_drive/banner
    
Pastikan Catalog Options Link Sesuai dengan Judul
    Reload Page
    Sleep               ${Delay}
    Click element       //div[@class='dropdown-value']//span[@class='f-16 f-bold']
    Sleep               ${Delay}
    Click element       //*[@id="root"]/div/div[1]/div[2]/div[1]/div[2]/div[2]
    Sleep               ${Delay}
    
Blibli
    Reload Page
    SLEEP                           ${SLEEP}
    Click element                   //div[@id='root']
    SLEEP                           ${SLEEP}
    Click Element                   //div[@class='catalogue-grid']//div[@id='Blibli']
    SLEEP                           ${SLEEP}
    Select Window                   NEW
    Location Should Contain         https://www.blibli.com/merchant/efishery/EFY-60021?page=1&start=0&pickupPointCode=&cnc=&multiCategory=true&excludeProductList=false&sort=7
    [Teardown]      Close Browser