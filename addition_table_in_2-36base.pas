Program Addition_Table_in2_to36_number_system;

uses crt;
// Функция перевода из 10ой в P-ую СС. 
function convert_to_p(number, base_of_system: integer): string; 
// number - число для перевода , base_of_system - основание СС,в кот-ую переводится
const
  // строка символов для записи числа в СС > 10ой (11, 12 ...)
  symbols: string[36] = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  // переменная для хранения цифр уже переведённого в нужную СС числа
  converted_number: string;
begin
  converted_number := '';
  repeat
    // алгоритм перевода, думаю, понятен. Он стандартный. 
    // Делим с остатком число на основание системы счисления, далее берём запись ...
    // ... этой цифры из массива (чтобы 10,11 и т.п. числа писались как A, B, C и т.д.)
    // Например, ввели число 15, а основание СС просят 16. Строка ниже добавит в ...
    // ... переменную s цифру по следующему правил: 15 mod(деление с остатком)16 =
    // ... 15. symbols[15] - это F. И того в переменной converted_number будет 
    // символ F(вместо 15).
    // Попробуй мысленно сама поподставлять разные числа вместо numbers и base_of_system, 
    // ...чтобы понять как работает перевод и замена получившегося остатка на буквенную запись.
    converted_number := symbols[(number mod base_of_system) + 1] + converted_number;
    // "обрезаем" число x, избавляясь от его последней цифры, так как мы её уже занесли в строку
    number := number div base_of_system;
  until number = 0;
  
  // это то, что функция "возвращает", как результат своей работы. Т.е. строку converted_number
  convert_to_p := converted_number;
end;


// тело программы
var
  // переменные для размерностей массива (таблицы) и ввода основания СС
  row, column, base_of_system: integer;
  // Массив для таблицы
  Addition_Table: Array [0..36, 0..36] of string;

begin
  CRT.Window(20, 20, 800, 600);
  Textbackground (7); 
  Textcolor (1);
  // запрос ввести основание СС (base_of_scale), пока base_of_scale < 2 или 
  // ... base_of_scale > 36
  repeat
    writeln('Input base of the number system ( 2 <= base <= 36) :');
    read(base_of_system);
    writeln('_____________________________________________');
  until base_of_system in [2..36];
  
  
  writeln(' Addition table in number system with base ', base_of_system, ':');
  // заполнение таблицы(матрицы), для ячеек которой считается сумма индексов...
  // ...соответствующего столбца и строки, а далее результат переводится в CC ...
  // ... с основанием P
  for row := 0 to base_of_system - 1 do 
    for column := 0 to base_of_system - 1 do 
      // то есть здесь значение ячейки - это сумма её адреса по столбцам и строкам ...
      // ... переведённая в нужную систему счисления. 
      Addition_Table[row, column] := convert_to_p(row + column, base_of_system); 
    
  // непосредственный вывод таблицы на экран
  for row := 0 to base_of_system - 1 do
  begin
    // row:4 здесь "4" указывает, что нужно добавить 4 пробела перед выводом row...
    // ...,что нужно для корректной ширины столбцов
    write(row:4);
    write('|');
    
    for column := 0 to base_of_system - 1 do
      write(Addition_Table[row, column]:4);
    writeln;
  end;
end.