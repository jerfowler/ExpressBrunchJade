@ECHO OFF
SET PHANTOMJS_BIN=%AppData%\npm\node_modules\phantomjs\lib\phantom\phantomjs.exe
REM SET CHROME_BIN=C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
SET CHROME_BIN=%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe
SET FIREFOX_BIN=C:\Program Files (x86)\Mozilla Firefox\firefox.exe

karma start --browsers PhantomJS,Chrome,Firefox,IE