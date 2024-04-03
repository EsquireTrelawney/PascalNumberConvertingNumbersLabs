var
  number, fractional_part, real_number: real; // число для перевода в функциях, дробная часть, вещественное число
  base_of_system, option, integer_part, i, decimal_places: int64; // основание системы счисл, выбор пользователя, целая часть, переменная для цикла, кол-во знаков после запятой
  string_of_integer_part, string_of_fractional_part, number2, integer_part2, fractional_part2: string; 
  // строка для хранения целой части, дробной части, строка для хранения числа в случае выбора пользователем второй опции, целая часть этого числа, дробная часть этого числа

//Функция для перевода целой части из 10ой в любую СС
function Integer10toIntegerAny(number, base_of_system: integer): string;
const
  symbols: string[36] = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  converted_number: string;
begin
  converted_number := '';
  repeat
    converted_number := symbols[number mod base_of_system + 1] + converted_number;
    number := number div base_of_system;
  until number = 0;
  Integer10toIntegerAny := converted_number;
end;



//Функция для перевода дробной части из 10ой в любую СС
function Fractional10toFractionalAny(number: real; base_of_system, decimal_places: integer): string;// вещественная часть
const
  symbols: string[36] = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  k: integer;
  converted_number: string;
begin
  k := 0;
  converted_number := '';
  while k <> decimal_places do
  begin
    converted_number := converted_number + symbols[trunc(number * base_of_system) + 1]; 
    // здесь много описывать,нужно почитать,как работает перевод дробной части из десятичной в другую. Сам код не особо даст понимание
    number := frac(number * base_of_system);
    k := k + 1;
  end;
  Fractional10toFractionalAny := converted_number;
end;

// Функция для перевода некоторой строки,содержащей число,в само число
function translate_to_number(string_of_number: char): integer;
begin
  if (string_of_number >= '0') and (string_of_number <= '9') then 
    translate_to_number := ord(string_of_number) - 48 // ord - это поиск кода буквы по её написанию в формате ASCII
  // то есть мы находим код цифровой буквы (которая является цифрой),отнимая от него 48,если она в пределах от 0 до 9, 
  // и получаем эту же цифру,только в формате Int
  else 
    translate_to_number := ord(string_of_number) - 55;
  // если на вход подали строку не в пределах от 0 до 9,тогда нужно от кода символа отнять 55,чтобы получить само число 
end;


// Функция перевода целого из любой в 10ую
function IntegerAnyTo10(number: string; base_of_system: integer): string;
var
  b, k: integer;
  a: real;
  converted_number: string;
begin
  a := 0;
  k := 0;
  while number <> '' do
  begin
    converted_number := copy(number, Length(number), 1); // copy - возвращает подстроку строки, содержащую Length(number) символов с 1 символа
    b := translate_to_number(converted_number[1]);
    writeln(b);
    a := a + b * power(base_of_system, k); // это просто формула для представления развернутой части числа в какой-либо СС. Лучше погуглить,много писать
    // так, например, 123 = 1*10^2 + 2*10^1 + 3*10^0. Тут то же самое в этой функции она делает,только вместо 10 - base_of_system,т.к. мы по сути
    // записываем число развернуто в base_of_system системе счисления. например, двоичное число: 110 таким образом в цикле будет расписываться так:
    // 1*2^2 + 1*2^1 + 0*2^0, отсюда это число можно посчитать и записать уже в десятичной.
    
    delete(number, Length(number), 1); // исключает уже переведённую цифру из записи числа. 
    k := k + 1;
  end;
  IntegerAnyTo10 := floattostr(a);
end;

// Функция для перевода дробной части из любой сс в десятичную
function FractionalAnyTo10(number: string; base_of_system, decimal_places: integer): string;
// суть работы примерно такая же по самим командам,ньо лучше почитать о том, как переводится дробная часть чисел,чтобы можно было
// провести аналогию с переводом целых частей 
var
  b, k: integer;
  a: real;
  converted_number, c: string;
begin
  a := 0;
  k := -1;
  while number <> '' do
  begin
    c := copy(number, 1, 1);
    b := translate_to_number(c[1]);
    a := a + b * power(base_of_system, k);
    delete(number, 1, 1);
    k := k - 1;
  end;
  converted_number := floattostr(a);
  FractionalAnyTo10 := copy(converted_number, pos('.', converted_number) + 1, decimal_places);
end;


// тело самой программы
begin
  repeat
    writeln('Для перевода из 10ой в любую СС - введите "1", для перевода из любой СС в 10ую  - введите "2"');
    readln(option);
  until option in [1..2]; // пока пользователь не выберет число в пределах от 1 до 2
  
  // Переводим из 10ой в любую,используя описанные выше функции
  if option = 1 then begin
    writeln('В какую систему счисления необходимо перевести?');
    read(base_of_system);
    writeln('Введите число в 10ой системе счисления: ');
    readln(number);
    writeln('Какое количество знаков должно быть после запятой? ');
    readln(decimal_places);
    real_number := abs(number); // отбрасываем знак "-" у числа,если он был
    
    // Разбиваем число на целую и дробную части
    integer_part := trunc(real_number); // trunc - отбрасывает дробную часть,берёт целую
    fractional_part := frac(real_number);  // frac - отбрасывает целую часть,берёт дробную
    
    
    
    // --------------------------------------------------------------------------------------------------
    // Для вывода на экран используем строковые переменные,куда отдельно записываем целую часть и дробную часть
    
    string_of_integer_part := Integer10toIntegerAny(integer_part, base_of_system);
    // Здесь с помощью функции перевода целую часть числа переводим в выбранную СС
    string_of_fractional_part := Fractional10toFractionalAny(fractional_part, base_of_system, decimal_places);
    // Здесь же переводим его дробную часть в выбранную СС
    
    
    // Если исходное число было отрицательным,то перед его записью добавляем "-",а между дробной и целой частью выводим точку
    if number < 0 then
      writeln('-', string_of_integer_part, '.', string_of_fractional_part)
      else
    if fractional_part = 0 then writeln(string_of_integer_part) // если дробной части не было,то просто выводим целую часть
    else
      writeln(string_of_integer_part, '.', string_of_fractional_part); // если число 0 или >0, то просто выводим целую_часть.дробную_часть
  end;
  
  
    //В случае выбора второй опции, переводим из любой сс в десятичную,используя функции, которые в цикле представляют число в 
    // развернутой форме записи 
  if option = 2 then begin
    writeln('Из какой системы счисления необходимо перевести число?');
    readln(base_of_system);
    writeln('Введите число в этой системе счисления');
    readln(number2);
    writeln('Какое необходимо количество знаков после запятой?');
    readln(decimal_places);
    
    // Переводим введённое число в верхний регистр,ведь вводят не десятичное,а произвольной ССчисло
    // например, могут вводить 1F или 1f, необходимо f и F считать одинаковыми
    for i := 1 to length(number2) do
      number2[i] := upcase(number2[i]);
    
    // Необходимо проверить,принадлежит ли введённое число нужной системе счисления
    for i := 1 to length(number2) do
      // если в записи числа встречается цифра, которая больше или равна основанию системы счисления, то очевидно число не принадлежит это СС
      // Например, в троичной сс у чисел знаки только 0,1,2. В записи троичного числа не может быть "3"-йки. 
      // Используя функцию перевода цифры,записанной строкой в число, мы сравниваем его с основанием СС
      if translate_to_number(number2[i]) >= base_of_system then begin
        writeln(number2[i]); // выводим число в обратном порядке поциферно. Это скорее для проверки нужно,чтобы убедиться, что всё ОК переводится
        writeln('Число ', number2, ' не принадлежит ', base_of_system, ' системе счисления');
        exit;
      end; 
      
    // Разбиваем число, записанное теперь как набор цифр или букв в строковом формате на дробную часть и целую,разделяя 
    // ... строку на две подстроки,как только встретился символ точки. 
    // pos - ищет первое вхождение строки '.' в строке number2 и возвращает индекс этого символа в этой строке. 
    // С такой точки зрения наша строка, содержащая число, является массивом, которым мы разбили на две части, зная, 
    // ... адрес точки. Логично,что если точки нет в записи (её индекс в массиве = 0), то всё число и есть целой частью
    if pos('.', number2) = 0 then integer_part2 := copy(number2, pos('.', number2) + 1, Length(number2))
    else begin
      // иначе целая часть это то,что идёт до адреса точки в строке, начиная с первого индекса массива
      integer_part2 := copy(number2, 1, pos('.', number2) - 1);
      // а дробная часть - это то, что идёт с индекса точки в массиве и до конца строки( до индекса,равного её длине)
      fractional_part2 := copy(number2, pos('.', number2) + 1, Length(number2));
    end;
    
    
    // Вывод на экран числа c переводом целой и дробной части в десятичную систему с помощью функций
    // если в записи числа был символ "-", то есть его индекс != (не равен) нулю,то нужно к записи числа приписать перед выводом "-"
    if pos('-', number2, 1) <> 0 then
      writeln('-', IntegerAnyTo10(integer_part2, base_of_system), '.',  FractionalAnyTo10(fractional_part2, base_of_system, decimal_places))
    else
      writeln(IntegerAnyTo10(integer_part2, base_of_system), '.',  FractionalAnyTo10(fractional_part2, base_of_system, decimal_places))
  end;
end.