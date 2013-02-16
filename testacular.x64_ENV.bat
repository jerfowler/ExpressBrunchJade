@ECHO OFF
SET PHANTOMJS_BIN=%AppData%\npm\phantomjs.cmd
SET CHROME_BIN=C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
SET FIREFOX_BIN=C:\Program Files (x86)\Mozilla Firefox\firefox.exe

testacular start --browsers Chrome,Firefox,IE,PhantomJS 