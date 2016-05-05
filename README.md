#RESTful Calculator
This RESTful calculator was created as part of semester 2 of the course **Introduction to Functional Programming**.
##Instructions for Running
**Git**, **Stack**, and **cURL** are needed for this project.
Clone the repository into a directory of your choosing by using ($ indicates cmd/terminal/preffered prompt):
```
$ git clone https://github.com/Tarabadi/CI285Calc.git
```
Following this `cd` into the directory and run
```
$ stack build
```
to build the project and create executables. Executing 
```
$ stack exec CI285Calc-exe
```
will run the project, hosting the calculator at port 3000 of **localhost**. Another cmd/terminal/preffered prompt has to opened to use the calculator.

With the second prompt, a connection test can be run to ensure the calculator is being hosted and you can connect to it. If everything is okay, it should look like:
```
$ curl localhost:3000/test
<p>Connection Successful!</p>
```
