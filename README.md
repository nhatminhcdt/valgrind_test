# VALGRIND TEST

---
## Demo of how to use the free valgrind tool under Linux to debug dynamic memory access problems in a C++ program.

---
**How to build and clean the program?**
- To build the program:<br>
<code>make</code>
<blockquote>Execution file is stored in the folder <strong><code>build/</code></strong></blockquote>
- To clean the program:<br>
<code>make clean</code>

---
**Code check**<br>

On Powershell,
- To run cpplint and cppcheck:<br>
<code>.\cpplint\check.ps1</code>
- To run valgrind check:<br>
<code>.\memcheck\check.ps1</code>

<blockquote>To view the check results, go to the folder <strong><code>check/</code></strong></blockquote>

---
**Coverage check**<br>

On Powershell,
- To check the coverage:<br>
<code>./wsl_coverage.sh</code>

<blockquote>To view the coverage results, go to the folder <strong><code>check/coverage/</code></strong></blockquote>

---
**Doxygen**<br>

Open and run Doxyfile on Doxygen GUI will give better overview.

---
**References**
- [Using and understanding the Valgrind core](https://valgrind.org/docs/manual/manual-core.html)
- [Dynamic Memory Debugging with Valgrind](https://www.youtube.com/watch?v=bb1bTJtgXrI)
- [What is a C++ weak pointer and where is it used?](https://iamsorush.com/posts/weak-pointer-cpp/)

---
**Log**
- 2022/09/06 - First commit. The current codes will cause variety of memory leakage errors when using Valgrind for check