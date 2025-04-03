:: Run Robot Framework tests
pabot --testlevelsplit --processes 4 -v AMBIENTE:HD_Resolution -d Results -x output1.xml -l log1.html -r report1.html Tests
:: Check if tests failed
if %ERRORLEVEL% NEQ 0 (
    :: Rerun only the failed tests
    pabot --testlevelsplit --processes 4 -v AMBIENTE:HD_Resolution --rerunfailed Results/output1.xml -d Results -x output2.xml -l log2.html -r report2.html Tests
    rebot --merge Results/output1.xml Results/output2.xml -o Results/output.xml -l Results/log.html -r Results/report.html
) else (
    :: Rename files from first run to be consistent with the rerun output
    ren "Results/output1.xml" "Results/output.xml"
    ren "Results/log1.xml" "Results/log.xml"
    ren "Results/report1.xml" "Results/report.xml"
)