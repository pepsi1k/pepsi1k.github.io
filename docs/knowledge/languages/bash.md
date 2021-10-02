<dl> 
<style>
h2 {
border-bottom: 1px solid #eaecef;
padding-bottom: .3em;
}
</style>
</dl>



## Bash, что необходимо знать с самого начала
1. `#!/bin/bash` в этой строке после #! указывается путь к bash-интерпретатору. C этой сроки должен ничинаться каждый скрипт.
2. Коментарии начинаются с символа # (кроме первой строки).
3. В bash переменные не имеют типа


## Аргументы командной строки
* **$n**, **n** - номер аргумента, **$1**, **$2**
* **$0** - имя запущенного скрипта
* **$@** - все аргументы отдельно
* **$#** - кол. аргументов
* **$$** - pid текущего процесса
* **$!** - pid фонового процесса
* **$?** - статус выхода последней функции


## Условия  
Регулярные выражение в if. Проверка на число:
```bash
if [[ "$string" =~ ^[0-9]+$ ]]; then
	echo "string is a digit"
fi

```

## Массивы
Обьявление массивов:
```bash
arr=("1" "2" "3")
# еще один вариант
arr[0]="1"
arr[1]="2"
arr[2]="3"

```

```bash
${arr[*]} # Все записи в массиве
${!arr[*]} # Все индексы в массиве
${#arr[*]} # Количество записей в массиве
${#arr[0]} # Длина первой записи (нумерация с нуля)
```

## Циклы
```bash 
for i in 1 2 3 4 .. N; do echo $i; done

for file in /etc/*; do echo $file; done

for i in $(command-here); do echo $i; done

for i in {1..5}; do echo $i; done
```

##### Перебор массива
```bash
array=(one two three four [5]=five)

echo "Array size: ${#array[*]}"  # Выводим размер массива

echo "Array items:" # Выводим записи массива
for item in ${array[*]}
do
    printf "   %s\n" $item
done

echo "Array indexes:" # Выводим индексы массива
for index in ${!array[*]}
do
    printf "   %d\n" $index
done

echo "Array items and indexes:" # Выводим записи массива с их индексами
for index in ${!array[*]}
do
    printf "%4d: %s\n" $index ${array[$index]}
done
```

!> **WARNING!** Следуйщие команды предназначенны для старых версий bash. 
Для версий (bash v3.x+) лучше использывать варианты выше.

Цикл с шагом {start..end..increment}:
```bash
for i in {0..10..2}; do
	#commands
done
```

Цикл с шагом `seq 1 2 5` -> **1 2 3**:
```bash
for i in $(seq 1 2 10); do
	#commands
done
```

```bash
for (( i=0; i<=5; i++ )); do
	#commands
done
```

```bash
while [[ expretion ]]; do
	#commands
done
```


## Функции
Сеществует два определения функции:
```bash
function <name> {
	<commands>
}
<name> () {
	<commands>
}
```

В терминале **bash** функции разсматриваются как мини-скрипт, с своим статусом выхода.
```bash
func() {
	echo "text text text"
	ls -l asdf
}
func
echo "Статус выхода: $?"

Результат:
text text text
ls: asdf: No such file or directory
Статус выхода: 2
```

Возможно самому задавать статус выхода, спомощью команды `return`.
Только при этом возвращаемое значение может быть от **0** до **255**.
```bash
func() {
	return $[$1 * 2]
}
func 200
echo $?      # Непредсказуемый значение 
func 100
echo $?      #200
```

Аргументы в функцию передаются также как мы бы вызвали обычную команду **$1**..**$N**.


## Математические операции
**let** - это встроенная функция bash, которая позволяет нам выполнять простую арифметику.
```bash
let a=5+4          # если мы не ставим кавычки вокруг выражения, тогда оно должно быть без пробелов 
echo $a            # 9
let "a = 5 + 4"    # выражение с пробелами
echo $a            # 9
let a++            # a = a + 1
echo $a            # 10
let "a = $1 + 30"  # первый аргумент + 30 
```

**expr** - похож на let, но вместо сохранения результата на переменную, выводит ответ.
```bash
expr 5 + 4         # 9
expr "5 + 4"       # будет выведено "5 + 4"
expr 5 \* $1       # 5 умножить на первый аргумент
expr 11 % 2        # 1
a=$( expr 10 - 3 ) # переменная a=7
```

**Двойные скобки** - мы можем сохранить вывод команды в переменную, `$((expression))`.
```bash
a=$((4+5))         # a = 9
b=$(( a + 3 ))     # b = 12
c=$(( 4 * 5 ))     # c = 20
(( b++ ))          # b = b + 1
(( b += 3 ))       # b = b + 3
```

## Работа со строками string bash

#### Длина строки
```bash
expr length $string #длина строки
${#string} #длина строки

string=abcABC123ABCabc
echo ${#string} # 15
echo `expr length $string` # 15
```

#### Извлечение подстроки
```bash
echo ${string:0}      # abcABC123ABCabc
echo ${string:1}      # bcABC123ABCabc
echo ${string:7}      # 23ABCabc
echo ${string:7:3}    # 23A
```
