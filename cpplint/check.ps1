$PSDefaultParameterValues["Out-File:Width"] = 1000
$PSDefaultParameterValues["Out-File:Encoding"] = "UTF8"
$current_directory = Get-Location
$project_name = Split-Path $current_directory -Leaf
$file_list = Get-ChildItem . -Name -Recurse -include *.c,*.cpp,*.h,*.hpp,*.inc -Exclude gtest_*.cpp,gtest_*.h,gtest_*.inc,gtestsample_*.cpp

If( -not (Test-Path check) ){
  New-Item check -ItemType Directory
}
echo "check lint..."
python cpplint.py --extensions=c,cpp,h,hpp,inc $file_list 2> check/check_result_lint_err.log > check/check_result_lint.log
echo "check static..."
cppcheck.exe --language=c++ ––enable=all --force $file_list 2> check/check_result_static_err.log > check/check_result_static.log
# --addon=misra.json 
# cppcheck.exe -I ../${project_name}_bsp/drivers/inc --language=c++ ––enable=all --force $file_list 2> check/check_result_static_err.log > check/check_result_static.log

$error_count = 0
Write-Output "summary" > check/check_result_summary.log
# cpplint...
If((Get-Item check/check_result_lint.log).Length -eq 0){
  Write-Output "LINT   : Not executed." >> check/check_result_summary.log
}ElseIf((Get-Item check/check_result_lint_err.log).Length -eq 0){
  Write-Output "LINT   : Succeed." >> check/check_result_summary.log
}Else{
  Write-Output "LINT   : Failed. -> check/check_result_lint_err.log" >> check/check_result_summary.log
  $error_count = $error_count + 1;
}
# cppcheck...
If((Get-Item check/check_result_static.log).Length -eq 0){
  Write-Output "STATIC : Not executed." >> check/check_result_summary.log
}ElseIf((Get-Item check/check_result_static_err.log).Length -eq 0){
  Write-Output "STATIC : Succeed." >> check/check_result_summary.log
}Else{
  Write-Output "STATIC : Failed. -> check/check_result_static_err.log" >> check/check_result_summary.log
  $error_count = $error_count + 1;
}

echo ""
Get-Content check/check_result_summary.log

If($error_count -eq 0){
  echo ""
  echo "generate document..."
  doxygen 2> check/check_result_doc_err.log > check/check_result_doc.log
}

echo ""
echo "finished"