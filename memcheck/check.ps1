$PSDefaultParameterValues["Out-File:Width"] = 1000
$PSDefaultParameterValues["Out-File:Encoding"] = "UTF8"
$current_directory = Get-Location
$project_name = Split-Path $current_directory -Leaf
$file_list = Get-ChildItem . -Name -Recurse -include *.c,*.cpp,*.h,*.hpp,*.inc -Exclude gtest_*.cpp,gtest_*.h,gtest_*.inc,gtestsample_*.cpp

If( -not (Test-Path check) ){
  New-Item check -ItemType Directory
}

echo "check valgrind..."
# --leak-check=full to see details of leaked memory
# --vgdb=no to suppress error calling PR_SET_PTRACER
valgrind --leak-check=full --vgdb=no ./build/prog.exe 2> check/check_valgrind_err.log > check/check_valgrind.log

$error_count = 0
Write-Output "summary" > check/valgrind_summary.log

# valgrind...
If((Get-Item check/check_valgrind.log).Length -eq 0){
  Write-Output "VALGRIND : Not executed." >> check/valgrind_summary.log
}
Else{
  $success_string = "ERROR SUMMARY: 0 errors from 0 contexts"
  If ((Get-Content check/check_valgrind_err.log) -match $success_string) {
    Write-Output "VALGRIND : Succeed." >> check/valgrind_summary.log
  } Else {
    Write-Output "VALGRIND : Failed. -> check/check_valgrind_err.log" >> check/valgrind_summary.log
    $error_count = $error_count + 1;
  }
}
echo ""
Get-Content check/valgrind_summary.log

echo ""
echo "finished"