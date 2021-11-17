# interpreter

An Programming Language Interpreter developed using YACC/Bison and Flex.

Run the following command to create the interpreter.

```sh
make create_interpreter 
```

Here is a sample of the Programming Language that you can use in this interpreter:

```txt
inteiro a = 2
a = 3
inteiro b = 2
inteiro c = a + b

escreve c

inteiro d
le d
```

You can run this sample code with:

```sh
make run_sample
```
