<dl> 
<style>
h4 {
border-bottom: 1px solid #eaecef;
padding-bottom: .3em;
}
</style>
</dl>

#### Как я буду совмещать учебу и работа?
Самое главное это сдать сессию, для сдачи сессии нужно делать лабораторные работы, 
а для сдачи лабораторных работ не обязательно ходить в занятия.

#### Отличие хаба от коммутатора
**Хаб** - обеспечивает соединение нескольких ПК в сеть на первом уровне модели OSI

**Коммутатор** - обеспечивает обьединение нескольких пк на втором уровне модели OSI

Хаб дублирует сигнал всем хостам подключенным в сеть. В то время как коммутатор создает таблицу IP-адресов

#### MTU (Maximum transmission unit)
**MTU** - означает максимальный размер полезного блока данных одного пакета, который может быть редан протоколом без фрагментации.

| Interfase                   | MTU(byte)   |
| -----------                 | ----------- |
| Internet Path MTU для X.25  | 576         |
| Ethernet 2                  | 1500        |
| Ethernet с LLC, SNAP, PPPoE | 1492        |
| WLAN 802.11                 | 2272        |
| 802.5 Token ring            | 4464        |
| FDDI                        | 4478        |

#### SMTP (Simple Mail Transer Protocol)

**SMTP** - служит для отправки писем

#### POP3 (Post Office Protocol)

**POP3** - служит для получение писем, от почтового сервера, при это после получения письма, удаляет копию с сервера.

#### IMAP (Internet Mail Access Protocol)

**IMAP** - предназначен для получения писем с любого устройства.




| Protocol | Port       |
| ---      | ---        |
| FTP      | 21/20      |
| SFTP     | 22         |
| SSH      | 22         |
| Telnet   | 23         |
| HTTP     | 80         |
| SSL      | 443        |
| IMAP     | 143/993    |
| SMTP     | 25/465/587 |
| POP3     | 110/995    |


# NodeJS

#### Раскажите о своем опыте, какой стек технологий вы использывали?

Дел сайт на PHP, использывал framework Yii2 

#### Можете простыми словами обьяснить, что такое prototype и функция конструктор?

Функция конструктор позволяет описать тип для обьекта.
```javascript
// конструктор типа Car
function Car(mName, mYear){
    this.name = mName;
    this.year = mYear;
    this.getCarInfo = function(){
        document.write("Модель: " + this.name + "  Год выпуска: " + this.year + "<br/>");
    };
};
// конструктор типа User
function User(pName, pAge) {
    this.name = pName;
    this.age = pAge;
    this.driveCar = function(car){
        document.write(this.name + " ведет машину " + car.name + "<br/>");
    };
    this.displayInfo = function(){
        document.write("Имя: " + this.name + "; возраст: " + this.age + "<br/>");
    };
};
```

Prototype - это свойстово.
Каждая функция имеет свойство prototype, представляющее прототип функции. 
Мы можем добавить свойство или методы в prototype и они будут доступны для всех обьектов.
```javascript
function User(pName, pAge) {
    this.name = pName;
    this.age = pAge;
    this.displayInfo = function(){
        document.write("Имя: " + this.name + "; возраст: " + this.age + "<br/>");
    };
};
 
User.prototype.hello = function(){
    document.write(this.name + " говорит: 'Привет!'<br/>");
};
User.prototype.maxAge = 110;
 
var tom = new User("Том", 26);
tom.hello();
var john = new User("Джон", 28);
john.hello();
console.log(tom.maxAge); // 110
console.log(john.maxAge); // 110
```

```javascript
User.prototype.maxAge = 110;
var tom = new User("Том", 26);
var john = new User("Джон", 28);
tom.maxAge = 99;
console.log(tom.maxAge); // 99
console.log(john.maxAge); // 110
```

#### Разница между класическим ооп и обьектно прототипированным?
В обьектно прототипном нет понятия класса, а наследование производится путем клонирования существующего экземпляра обьекта - прототипа.

#### Можно ли в ES6 добавить свойство в класс?
Да можно!
```javascript
class Person{
    constructor(name, age){
        this.name = name;
        this.age = age;
    }
    display(){
        console.log(this.name, this.age);
    }
}
class Employee extends Person{
    constructor(name, age, company){
        super(name, age);
        this.company = company;
    }
    display(){
        super.display();
        console.log("Employee in", this.company);
    }
    work(){
        console.log(this.name, "is hard working");
    }
}
```

#### ES6 что нового заметили и что из них применял?

* Стрелочные функции
* const let
* Classes

#### Как справиться с адом callback, какие варианты используете?
ссылки на функции
Промиссы
Модульность

#### Цепочка промисов, как сбросить ошибку в catch?

В каком-то из callback вызвать callback в отказе и спомощью catch словить его.

#### Как передать картинку на сервер nodejs?

Считать картинку спомощью потока и отправить её как текст
